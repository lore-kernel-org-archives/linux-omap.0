From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Mon, 24 Oct 2016 11:07:08 -0700
Message-ID: <20161024180708.kpx6s2jb7dpg6xfx@atomide.com>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
 <20161020193612.GA29736@localhost.localdomain>
 <20161021071722.2cetd2mt23t245ao@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161021071722.2cetd2mt23t245ao-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161021 00:18]:
> * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161020 12:37]:
> > [  186.457519] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_wait_bcon (90, <VBusValid), retry #3, port1 0008010c
> > 
> > And that's the end, since now it does not react on hub plug/unplug.
> > 
> > Also all that VBUS_ERROR conditions are strange as hub is powered separately
> > and power lines from phy are not used.
> 
> Hmm yeah. I'd like to be able to reproduce this. Can you email me
> your .config (again)? You have things in host mode with a powered
> hub plus few devices with no USB gadgets configured?

Well I found your earlier .config so presumably that did not change.
Below patch seems to do the trick for me, but I need to test more.

Care to test if it helps for you? Please test with v4.9-rc2 and the
following two fixes heading in Greg's usb-linus branch:

cacaaf80c3a6 ("usb: musb: Call pm_runtime from musb_gadget_queue")
d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe lock order error")

I'll send a proper patch if that works for you.

Regards,

Tony

8< ------------------------
diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -459,8 +459,6 @@ static int twl4030_phy_power_off(struct phy *phy)
 	struct twl4030_usb *twl = phy_get_drvdata(phy);
 
 	dev_dbg(twl->dev, "%s\n", __func__);
-	pm_runtime_mark_last_busy(twl->dev);
-	pm_runtime_put_autosuspend(twl->dev);
 
 	return 0;
 }
@@ -472,6 +470,8 @@ static int twl4030_phy_power_on(struct phy *phy)
 	dev_dbg(twl->dev, "%s\n", __func__);
 	pm_runtime_get_sync(twl->dev);
 	schedule_delayed_work(&twl->id_workaround_work, HZ);
+	pm_runtime_mark_last_busy(twl->dev);
+	pm_runtime_put_autosuspend(twl->dev);
 
 	return 0;
 }
-- 
2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
