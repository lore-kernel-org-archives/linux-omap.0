From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume balanced
 enable()/disable()
Date: Thu, 4 Aug 2016 08:01:26 -0700
Message-ID: <20160804150125.GH28140@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
 <20160804142919.GG28140@atomide.com>
 <3EF398D0-6B90-46B6-83AE-EAE065A68890@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3EF398D0-6B90-46B6-83AE-EAE065A68890-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160804 07:50]:
> > Am 04.08.2016 um 16:29 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > 
> > So I gave this patch a try but it now blocks all deeper SoC idle
> > states as the PHY stays active. I think the real fix is to make
> > sure the charger behaves independent of the USB PHY state.
> 
> IMHO, plugin detection of the cable is a phy task and then it tells
> the charger to start. This part works.

OK

> Charging did work up to kernel 4.3. It started to fail with 4.4-rc1
> without obvious changes to the charger but many patches to phy
> and musb. We had even backported the 4.7 charger driver
> to 4.3 and it failed as well.

OK

> > So
> > probably this needs to be fixed in phy-twl4030-usb.c and
> > twl4030_charger.c instead. Now it sounds like we're also shutting
> > down the charger with the USB PHY.
> 
> As a very deeply hidden side-effect the charger is shut down immediately
> after being started. Because phy-twl4030-usb.c does not do what it is expected
> and told to do.
> 
> I have developed a workaround for the charger driver but I do not consider it
> as the solution.
> 
> http://git.goldelico.com/?p=gta04-kernel.git;a=commit;h=b8c538e75c6dd034889bdb0d66e00ca6e128e616
...
> With that we have a workaround in the charger, but not a correct solution.
> That is what Andreas is trying to fix. The charger driver seems to be ok to
> me.

OK. So does the charger work with just phy-twl4030-usb and charger
modules loaded when cable is inserted?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
