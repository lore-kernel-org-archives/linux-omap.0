From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [RFCv4 06/11] misc: Introduce Nokia CMT driver
Date: Sun, 22 Dec 2013 11:22:06 +0100
Message-ID: <CACRpkdZpAwemVCWubVC6Fe+CNrzPo97uTzyEQt1uD4M2iutnPQ@mail.gmail.com>
References: <1387150085-23173-1-git-send-email-sre@debian.org>
	<1387150085-23173-7-git-send-email-sre@debian.org>
	<CACRpkdYjjXgE_W8gq1e6z=nGMF=r-m+o2kkvrBFrEMm3o0=RwQ@mail.gmail.com>
	<20131216121524.GA6177@earth.universe>
	<CACRpkdbx=Ye8xo4wMkyntME45xv15DeyqV32aeCAcSaa+vDpfA@mail.gmail.com>
	<20131216183448.GA10614@earth.universe>
	<52B090E0.5040006@gmail.com>
	<20131217232525.GA12152@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131217232525.GA12152-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivajlo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?windows-1251?B?yOLg6evuIMTo7Ojy8O7i?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aar>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 18, 2013 at 12:25 AM, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org> wrote:

> I had a look at both ofono's and freesmartphone.org's implementation
> for the GPIO handling and both implementations are very similar. I
> think it should be possible to move the state machine described in
> [0] into the kernel and provide a simple sysfs/uevent interface.
>
> I was thinking of something like /sys/devices/platform/nokia-cmt/state,
> which accepts "enable", "disable" and "reset" as input and outputs the
> current state.
>
> [0] https://git.kernel.org/cgit/network/ofono/ofono.git/tree/plugins/nokia-gpio.c

Yes this looks like kernel code shoehorned into userspace. As it
deals with suspending/resuming hardware for example, and that is
something the kernel needs to coordinate and do uniformly across
all devices (IMO).

A while back Arun Murthy was working on creating an embedded
modem subsystem but the development stopped. However such a
subsystem is a generic problem of general interest and this would be
one of the candidates for drivers/modem I think. Sadly creating it
may be a lot of work, I don't know exactly.
http://marc.info/?l=linux-kernel&m=135027904405680&w=2

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
