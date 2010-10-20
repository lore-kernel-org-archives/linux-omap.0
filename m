From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Tue, 19 Oct 2010 17:31:16 -0700
Message-ID: <20101020003115.GC30991@atomide.com>
References: <20101019103234.GI31170@legolas.emea.dhcp.ti.com>
 <AANLkTinXzMQXoyyu+anSCvSuE9w3FWAP5HswDS0kfpzE@mail.gmail.com>
 <20101019111613.GJ31170@legolas.emea.dhcp.ti.com>
 <AANLkTikkMphKa2DGGtWxy-3LpFX0kn92UEYPj==Euzok@mail.gmail.com>
 <20101019115236.GL31170@legolas.emea.dhcp.ti.com>
 <AANLkTim3NsgjC3Nh8VCCrx4cV1Y+kn38=30=en0KCft6@mail.gmail.com>
 <6ea089ac75d4d15d88698468eacb7fe3@secure211.sgcpanel.com>
 <AANLkTinYM5aavk9_jcTTymff=OY+Yyv8T6C+dmMih0p_@mail.gmail.com>
 <20101019234414.GB30991@atomide.com>
 <87fww1u3fw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87fww1u3fw.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> [101019 17:04]:
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> >
> > This actually produces a booting omap2+ kernel with no .config
> > at all. I've tested it with:
> >
> > $ echo CONFIG_ARCH_OMAP=y > .config
> > $ yes "" | ARCH=arm make oldconfig
> >
> > So if you have something that's needed on almost every omap,
> > you can select it there.
> 
> One thing I don't like about this is that there is currently no way to
> 'select' as a module.

I think that would take two passes to do currently for the depenencies..
But we can certainly select all the omap drivers as modules in
omap2plus_defconfig.

> In order to get to a minimal kernel, in theory, we don't need regulator,
> i2c, MFD, or twl4030* built in.  They should all be built as modules.
> Yes, there are some assumptions made today that some of these things are
> built in, and then are used from init code, but that is broken.

I think the only thing keeping us from doing that is that most of
the boards don't use initramfs. Without initramfs these are needed
to mount root on MMC.
 
> If someone is looking for a good omap-kernel-janitors project, I would
> suggest getting to a *really* minimal OMAP2+ kernel with everything
> possible built as modules to be a very good project.

Agreed. The way to do that is to set everything possible as modules
in omap2plus_defconfig, and move to kernel + initramfs based booting
like most distros do.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
