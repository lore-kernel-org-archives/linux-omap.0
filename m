From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry
Date: Mon, 6 Jun 2016 23:00:05 -0700
Message-ID: <20160607060004.GD22406@atomide.com>
References: <1464853310-8738-1-git-send-email-yong.b.li@intel.com>
 <CAOCHtYib9YxckneM-j0Gk1YE=MnvAwAhvDjEDEuFJbH6W3EcWA@mail.gmail.com>
 <20160602173932.GF5995@atomide.com>
 <CAOCHtYiWYrwSidHnKv4siFT-wU=tt5-YeDTwbM022ZTxdPFYYA@mail.gmail.com>
 <20160602175635.GG5995@atomide.com>
 <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FB1EC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FB1EC-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Li, Yong B" <yong.b.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sdliyong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <sdliyong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Li, Yong B <yong.b.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [160602 22:49]:
> Hi Tony,
> 
> I can submit a V2 version about the "disabled", or just drop this patch?

Probably best to wait on this one until we know how it can be
enabled without manually editing the dts file. I'm still hoping
u-boot could enable it based on some environment variable..

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
