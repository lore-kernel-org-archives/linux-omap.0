From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Tue, 8 Nov 2016 07:49:34 -0700
Message-ID: <20161108144934.GK2428@atomide.com>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161108133821.GA1855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161108133821.GA1855-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161108 06:39]:
> Hi Tony,
> 
> On Mon, Nov 07, 2016 at 02:50:16PM -0700, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here are musb fixes for the issues that I've been able to track down.
> > Not sure if these will help with the problem Ladis was seeing as I'm
> > not able to reproduce that one it seems.
> 
> I still need 87326e858448c40e32f142c0b8dcc59d7b27c641 (usb: musb: Remove
> extra PM runtime calls from 2430 glue layer) reverted, but I'm happy with
> that solution so far.

Weird, I have not figured out what happens there..

The only thing I'm still wondering about is if phy-twl4030-usb.c
is losing ID pin interrupts occasionally but have not been
able to verify that. Maybe try the following additional patch
and see if it makes any difference?

Regards,

Tony

8< --------------
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -304,6 +304,17 @@ static enum musb_vbus_id_status
 				status &= ~BIT(7);
 			else
 				twl->vbus_supplied = true;
+
+			/* Recheck status again for ID pin */
+			if (!(status & BIT(2))) {
+				msleep(200);
+				status = twl4030_readb(twl,
+						       TWL_MODULE_PM_MASTER,
+						       STS_HW_CONDITIONS);
+				if (status < 0)
+					dev_err(twl->dev, "USB link status err %d\n",
+						status);
+			}
 		}
 
 		if (status & BIT(2))
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
