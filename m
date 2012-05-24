From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 02:44:30 -0600
Message-ID: <CAF6AEGur-mmZDVrE+Y-6tesNCVKp4xKKuS-C7ozTSJ2KQijHdw@mail.gmail.com>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	<1337839294.2764.7.camel@lappyti>
	<CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
	<1337843144.2909.17.camel@deskari>
	<1337844098.2909.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37789 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab2EXIob convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 04:44:31 -0400
Received: by vcbf11 with SMTP id f11so1313452vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 01:44:31 -0700 (PDT)
In-Reply-To: <1337844098.2909.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: greg@kroah.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, May 24, 2012 at 1:21 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Thu, 2012-05-24 at 10:05 +0300, Tomi Valkeinen wrote:
>> On Thu, 2012-05-24 at 00:27 -0600, Clark, Rob wrote:
>> > On Thu, May 24, 2012 at 12:01 AM, Tomi Valkeinen <tomi.valkeinen@t=
i.com> wrote:
>> > > Hi,
>> > >
>> > > On Wed, 2012-05-23 at 15:08 -0500, Andy Gross wrote:
>> > >> Register OMAP DRM/KMS platform device. =A0DMM is split into a
>> > >> separate device using hwmod.
>> > >>
>> > >> Signed-off-by: Andy Gross <andy.gross@ti.com>
>> > >
>> > > <snip>
>> > >
>> > >> +static int __init omap_init_drm(void)
>> > >> +{
>> > >> + =A0 =A0 struct omap_hwmod *oh =3D NULL;
>> > >> + =A0 =A0 struct platform_device *pdev;
>> > >> +
>> > >> + =A0 =A0 /* lookup and populate the DMM information, if presen=
t - OMAP4+ */
>> > >> + =A0 =A0 oh =3D omap_hwmod_lookup("dmm");
>> > >> +
>> > >> + =A0 =A0 if (oh) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D omap_device_build(oh->name, =
-1, oh, NULL, 0, NULL, 0,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 false);
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(IS_ERR(pdev), "Could not build o=
map_device for %s\n",
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->name);
>> > >> + =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 return platform_device_register(&omap_drm_device);
>> > >> +
>> > >> +}
>> > >
>> > > I still don't like fixing the tiler to drm. I would like to have=
 basic
>> > > tiler support in omapfb also, but with this approach I'll need t=
o
>> > > duplicate the code. And even if we disregard omapfb, wouldn't it=
 be
>> > > architecturally better to have the tiler as a separate independe=
nt
>> > > library/driver?
>> >
>> > Not easily, at least not if we want to manage to use tiler/dmm in =
a
>> > more dynamic way, or to enable some additional features which are
>> > still on the roadmap (like reprogramming dmm synchronized w/ scano=
ut,
>> > or some things which are coming if future hw generations). =A0We n=
eed
>> > one place to keep track of which buffers are potentially evictable=
 to
>> > make room for mapping a new buffer. =A0And if you look at the tric=
ks
>> > that go on with mmap'ing tiled buffers to userspace, you *really*
>> > don't want to duplicate that in N different drivers.
>>
>> So why can't all that code be in a tiler library/driver?
>
> And I think we've discussed about this before, so sorry if I'm repeat=
ing
> myself. I just find it odd that we are not able to create a nice
> separate lib/driver for the tiler, which is a separate piece of HW th=
at
> multiple drivers might want to use.

but other drivers *can* use tiler, thanks to dmabuf.. I have omap4iss
v4l2 camera working w/ tiler buffers on my pandaboard, for example.

Maybe fbdev is an exception to the rule because it has no way for
userspace to pass it a buffer to use.  But on the other hand it is a
legacy API so I'm not sure if it is worth loosing too much sleep over
that.

BR,
-R

> =A0Tomi
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
