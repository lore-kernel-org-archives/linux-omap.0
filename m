From: "Clark, Rob" <rob@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 00:27:19 -0600
Message-ID: <CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	<1337839294.2764.7.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:46388 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699Ab2EXG1W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 02:27:22 -0400
Received: by lbbgg6 with SMTP id gg6so6759824lbb.8
        for <linux-omap@vger.kernel.org>; Wed, 23 May 2012 23:27:19 -0700 (PDT)
In-Reply-To: <1337839294.2764.7.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andy Gross <andy.gross@ti.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, greg@kroah.com

On Thu, May 24, 2012 at 12:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> Hi,
>
> On Wed, 2012-05-23 at 15:08 -0500, Andy Gross wrote:
>> Register OMAP DRM/KMS platform device. =A0DMM is split into a
>> separate device using hwmod.
>>
>> Signed-off-by: Andy Gross <andy.gross@ti.com>
>
> <snip>
>
>> +static int __init omap_init_drm(void)
>> +{
>> + =A0 =A0 struct omap_hwmod *oh =3D NULL;
>> + =A0 =A0 struct platform_device *pdev;
>> +
>> + =A0 =A0 /* lookup and populate the DMM information, if present - O=
MAP4+ */
>> + =A0 =A0 oh =3D omap_hwmod_lookup("dmm");
>> +
>> + =A0 =A0 if (oh) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D omap_device_build(oh->name, -1, o=
h, NULL, 0, NULL, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(IS_ERR(pdev), "Could not build omap_d=
evice for %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->name);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return platform_device_register(&omap_drm_device);
>> +
>> +}
>
> I still don't like fixing the tiler to drm. I would like to have basi=
c
> tiler support in omapfb also, but with this approach I'll need to
> duplicate the code. And even if we disregard omapfb, wouldn't it be
> architecturally better to have the tiler as a separate independent
> library/driver?

Not easily, at least not if we want to manage to use tiler/dmm in a
more dynamic way, or to enable some additional features which are
still on the roadmap (like reprogramming dmm synchronized w/ scanout,
or some things which are coming if future hw generations).  We need
one place to keep track of which buffers are potentially evictable to
make room for mapping a new buffer.  And if you look at the tricks
that go on with mmap'ing tiled buffers to userspace, you *really*
don't want to duplicate that in N different drivers.

=46ortunately with dmabuf there is not really a need for N different
drivers to need to use tiler/dmm directly.  The dmabuf mechanism
provides what they need to import GEM buffers from omapdrm.  That may
not really help omapfb because fbdev doesn't have a concept of
importing buffers.  But OTOH this is unnecessary, because drm provides
an fbdev interface for legacy apps.  The best thing I'd recommend is,
if you miss some features of omapfb in the drm fbdev implementation,
is to send some patches to add this missing features.

>> +struct omap_drm_platform_data {
>> + =A0 =A0 struct omap_kms_platform_data *kms_pdata;
>> +};
>
> This one is missing struct omap_dmm_platform_data *dmm_pdata, so you
> didn't just move the struct. Is that on purpose?

the dmm pdata is no longer needed because we get what we need from
hwmod via platform_get_resource()

BR,
-R

> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
