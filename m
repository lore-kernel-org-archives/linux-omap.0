From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: Add support for rev C
Date: Wed, 16 Aug 2017 08:23:44 -0700
Message-ID: <20170816152343.GG8569@atomide.com>
References: <20170814175820.12065-1-robertcnelson@gmail.com>
 <bf2a5868-4c0b-58a1-350e-cba7dcfb5166@ti.com>
 <CAOCHtYi=JxMirp03DMny+HFo3g9nsPO--VuNK7N-YtctNhj2dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOCHtYi=JxMirp03DMny+HFo3g9nsPO--VuNK7N-YtctNhj2dg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [170816 07:23]:
> and this is going to conflict with:
> 
> [v2,04/10] ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC
> 
> https://patchwork.kernel.org/patch/9903875/
> 
> i'll wait for Tony to pick up Kishon's before i re-submit..

OK Kishon's patches are now all applied and merged into
my for-next branch I just pushed out. Can you please
update and test against that and repost?

The commit to use as base is commit 271df663be9e ("Merge branch
'omap-for-v4.14/dt-v3' into for-next") as that has -rc4 merged
in that has commit c5b3955828ba ("ARM: OMAP4: Fix legacy code
clean-up regression") while omap-for-v4.14/dt-v3 is missing that
for testing.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
