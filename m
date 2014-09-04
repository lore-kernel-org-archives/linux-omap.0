From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/5] usb: phy: twl4030-usb: Move code from twl4030_phy_power
 to the runtime PM calls
Date: Thu, 4 Sep 2014 19:20:53 +0530
Message-ID: <54086E3D.4000200@ti.com>
References: <1409182091-31191-1-git-send-email-tony@atomide.com> <1409182091-31191-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409182091-31191-4-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thursday 28 August 2014 04:58 AM, Tony Lindgren wrote:
> We don't need twl4030_phy_power() any longer now that we have
> the runtime PM calls. Let's get rid of it as it's confusing.
> No functional changes, just move the code and use res instead
> of ret as we are not returning that value.

Now that you are doing pm_runtime_get_sync in twl4030_phy_init, won't it power
on the phy even before initializing it (since runtime_resume will be invoked
even before doing phy_init)?

Even if pm_runtime_get_sync in not done in twl4030_phy_init, phy-core itself
does pm_runtime_get_sync in phy_init().

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
