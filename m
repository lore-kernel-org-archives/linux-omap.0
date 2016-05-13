From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 10/15] usb: musb: Don't set d+ high before enable for
 2430 glue layer
Date: Fri, 13 May 2016 15:25:17 -0700
Message-ID: <20160513222517.GG5995@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-11-git-send-email-tony@atomide.com>
 <20160513210334.GC1665@uda0271908>
 <20160513211739.GE5995@atomide.com>
 <20160513212252.GA1659@uda0271908>
 <20160513213900.GF5995@atomide.com>
 <20160513220232.GA2478@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160513220232.GA2478@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 15:04]:
> 
> But what would be in musb_default_set_mode()? Currently only am35x,
> da8xx, dsps, and omap2430 glues implement _set_mode(), but they don't
> have any in common. Only omap2430 sets session bit in _set_mode(), no
> one else does so.

Well how about the following if no glue specific configuration of the
ID pin is possible?

Tony

8< -----------------------
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -416,6 +416,26 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	return hw_ep->musb->io.write_fifo(hw_ep, len, src);
 }
 
+static int musb_try_set_mode(struct musb *musb, u8 mode)
+{
+	if (musb->ops->set_mode)
+		return musb->ops->set_mode(musb, mode);
+
+	if (mode == MUSB_HOST) {
+		u8 devctl;
+
+		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+		devctl |= MUSB_DEVCTL_SESSION;
+		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+	} else {
+		dev_warn(musb->controller,
+			 "platform specific set_mode not implemnted: %i\n",
+			 mode);
+	}
+
+	return 0;
+}
+
 /*-------------------------------------------------------------------------*/
 
 /* for high speed test mode; see USB 2.0 spec 7.1.20 */
@@ -1723,11 +1743,11 @@ musb_mode_store(struct device *dev, struct device_attribute *attr,
 
 	spin_lock_irqsave(&musb->lock, flags);
 	if (sysfs_streq(buf, "host"))
-		status = musb_platform_set_mode(musb, MUSB_HOST);
+		status = musb_try_set_mode(musb, MUSB_HOST);
 	else if (sysfs_streq(buf, "peripheral"))
-		status = musb_platform_set_mode(musb, MUSB_PERIPHERAL);
+		status = musb_try_set_mode(musb, MUSB_PERIPHERAL);
 	else if (sysfs_streq(buf, "otg"))
-		status = musb_platform_set_mode(musb, MUSB_OTG);
+		status = musb_try_set_mode(musb, MUSB_OTG);
 	else
 		status = -EINVAL;
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -2185,13 +2205,13 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		status = musb_host_setup(musb, plat->power);
 		if (status < 0)
 			goto fail3;
-		status = musb_platform_set_mode(musb, MUSB_HOST);
+		status = musb_try_set_mode(musb, MUSB_HOST);
 		break;
 	case MUSB_PORT_MODE_GADGET:
 		status = musb_gadget_setup(musb);
 		if (status < 0)
 			goto fail3;
-		status = musb_platform_set_mode(musb, MUSB_PERIPHERAL);
+		status = musb_try_set_mode(musb, MUSB_PERIPHERAL);
 		break;
 	case MUSB_PORT_MODE_DUAL_ROLE:
 		status = musb_host_setup(musb, plat->power);
@@ -2202,7 +2222,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 			musb_host_cleanup(musb);
 			goto fail3;
 		}
-		status = musb_platform_set_mode(musb, MUSB_OTG);
+		status = musb_try_set_mode(musb, MUSB_OTG);
 		break;
 	default:
 		dev_err(dev, "unsupported port mode %d\n", musb->port_mode);
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -556,14 +556,6 @@ static inline void musb_platform_disable(struct musb *musb)
 		musb->ops->disable(musb);
 }
 
-static inline int musb_platform_set_mode(struct musb *musb, u8 mode)
-{
-	if (!musb->ops->set_mode)
-		return 0;
-
-	return musb->ops->set_mode(musb, mode);
-}
