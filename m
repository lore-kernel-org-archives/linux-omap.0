From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2 00/19] bus: omap_l3_noc: driver cleanups and support
 for DRA7/AM4372
Date: Thu, 24 Apr 2014 09:25:36 -0700
Message-ID: <20140424162536.GD22987@atomide.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
 <53504041.7090906@ti.com>
 <5350410B.5010507@ti.com>
 <5358D16A.9000500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5358D16A.9000500-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [140424 01:55]:
> On 04/18/2014 12:00 AM, Nishanth Menon wrote:
> > On 04/17/2014 03:57 PM, Santosh Shilimkar wrote:
> >> I looked at the series and its looks pretty good. Thanks for fixups, updates.
> >> For whole series,
> >> Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> >>
> > 
> > Thanks.
> > 
> >>> Patches(including Peter's) is available here:
> >>> https://github.com/nmenon/linux-2.6-playground/commits/l3noc/driver-fixes-v2
> >>>
> >> Can Tony pull this branch for 3.16 then which includes Peter's series as well ?
> > 
> > there is just an empty commit with information about peter's patches
> > that i lined up to differentiate the series.. I can drop it if Tony
> > would like me to.
> 
> Looking at the branch I see my patches underneath so they are in the branch.
> It would be great if Tony pulls this... Will be a great present to my patches
> (omap_l3 patches in the branch) for their 1 year anniversary of being out on
> the mailing list ;)

If you insist :) Maybe we should have some cake or something with it?
Seriously, I always thought that's a nice clean-up set, but never thought
I'm supposed to merge it. Will merge it as soon as I'm out of the fixes
and regressions land as that way I can easier test for any kind of
new regressions that might occur related to PM at least.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
