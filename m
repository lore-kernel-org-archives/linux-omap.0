From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] arm: dts: Add gta04a5 model
Date: Tue, 29 Jul 2014 05:41:20 -0700
Message-ID: <20140729124120.GS29045@atomide.com>
References: <1406577213-9642-1-git-send-email-marek@goldelico.com>
 <1406577213-9642-4-git-send-email-marek@goldelico.com>
 <CAOf5uwk=ctww=pP4Ae+1C6i-oOtiYTv2NJbj1GpuPwVSKXB4Hw@mail.gmail.com>
 <CAAfyv35jvhzvjCKMwrpa=RQ1JkfcmthCsGDzwLW9Y6bq3Ww_fg@mail.gmail.com>
 <CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw@mail.gmail.com>
 <1FA8171E-1B7A-4684-887E-11593BB9C29E@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1FA8171E-1B7A-4684-887E-11593BB9C29E-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Marek Belisko <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dr. H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [140728 13:45]:
> 
> Yes,
> the boot loader either loads gta04a3.dtb gta04.dtb or gta05.dtb
> depending on board revision.
> 
> Therefore we have multiple device tree files to represent such hardware
> differences. Like Gumstix Overo variants (using a  omap3-overo-base.dtsi)
> 
> And, this difference is not the only one. Other are to come later.
> 
> Unfortunately we were recommend to submit only DT nodes that already
> have drivers. Therefore, the "big picture" of the device variants support
> may not yet be visible from this patch.
> 
> I hope this gives a little background.

So what's the conclusion? Are changes needed to this patch
series or not?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
