From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Tue, 6 Mar 2012 09:29:44 -0600
Message-ID: <CAF6AEGvtGjgw+uEKTu34ukXNqZ-+gS6pQtv2oFM11X8ik1zY5w@mail.gmail.com>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	<1331040371.2059.113.camel@deskari>
	<CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	<1331044544.2059.150.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43245 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030689Ab2CFP3p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 10:29:45 -0500
Received: by vcqp1 with SMTP id p1so4482917vcq.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 07:29:44 -0800 (PST)
In-Reply-To: <1331044544.2059.150.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Tue, Mar 6, 2012 at 8:35 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Tue, 2012-03-06 at 08:01 -0600, Rob Clark wrote:
>> On Tue, Mar 6, 2012 at 7:26 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>
>> > Can there be more than one omapdrm device? I guess not. If so, the=
 id
>> > should be -1.
>>
>> in the past, we have used multiple devices (using the platform-data =
to
>> divide up the dss resources), although this was sort of a
>> special-case. =A0But in theory you could have multiple. =A0(Think of=
 a
>> multi-seat scenario, where multiple compositors need to run and each
>> need to be drm-master of their own device to do mode-setting on thei=
r
>> corresponding display.)
>>
>> I think if we use .id =3D -1, then we'd end up with a funny looking
>> bus-id for the device: "platform:omapdrm:-1"
>
> I don't know about that, but it's the way platform devices are meant =
to
> be used if there can be only one instance. If the case where there ar=
e
> multiple omapdrm devices is rather theoretical, or only used for cert=
ain
> debugging scenarios or such, I think having the id as -1 in the mainl=
ine
> is cleaner.

well, I don't care much one way or another, but need to check if there
is a small patch needed in drm core code that generates the bus-id for
=2Eid =3D -1..

>> >> +};
>> >> +
>> >> +static int __init omap_init_gpu(void)
>> >> +{
>> >> + =A0 =A0 struct omap_hwmod *oh =3D NULL;
>> >> + =A0 =A0 struct platform_device *pdev;
>> >> +
>> >> + =A0 =A0 /* lookup and populate the DMM information, if present =
- OMAP4+ */
>> >> + =A0 =A0 oh =3D omap_hwmod_lookup("dmm");
>> >> +
>> >> + =A0 =A0 if (oh) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D omap_device_build(oh->name, -1=
, oh, NULL, 0, NULL, 0,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 false);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(IS_ERR(pdev), "Could not build oma=
p_device for %s\n",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->name);
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 return platform_device_register(&omap_drm_device);
>> >> +
>> >> +}
>> >
>> > The function is called omap_init_gpu(), but it doesn't do anything
>> > related to the gpu... And aren't DMM and DRM totally separate thin=
gs,
>> > why are they bunched together like that?
>>
>> only legacy.. product branches also have sgx initialization here. =A0=
But
>> I can change that to omap_init_drm()
>>
>> DMM is managed by the drm driver (and exposed to userspace as drm/ge=
m
>> buffers, shared with other devices via dma-buf, etc). =A0It is only
>> split out to a separate device to play along with hwmod.
>
> I have to say I don't know much about DMM, but my understanding is th=
at
> DMM is a bigger entity, of which TILER is only a small part, and DMM
> manages all memory accesses.

when most people refer to TILER they actually refer to DMM..

DMM is the piece which is basically a GART, it is what omapdrm is
programming and managing.

> Can there be other users for the DMM than DRM? I know there could be
> other users for the TILER, and I know you want to combine that with t=
he
> DRM driver, but I'm wondering about the other parts of DMM than the
> TILER.

yes, clearly there are other users.. we pass gem buffers allocated
from omapdrm to (for example, video decoder).  But it is omapdrm which
is managing the allocation, keeping track of which buffers are pinned
and which can be evicted, dealing with the complications of userspace
mmap'ing of tiled buffers, etc.  That stuff you don't want littered
throughout the kernel.

> Somehow having a DMM driver inside omapdrm sounds strange.
>
>> >> +arch_initcall(omap_init_gpu);
>> >> +
>> >> +void omapdrm_reserve_vram(void)
>> >> +{
>> >> +#ifdef CONFIG_CMA
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Create private 32MiB contiguous memory area for om=
apdrm.0 device
>> >> + =A0 =A0 =A0* TODO revisit size.. if uc/wc buffers are allocated=
 from CMA pages
>> >> + =A0 =A0 =A0* then the amount of memory we need goes up..
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ_1M=
, 0, 0);
>> >
>> > What does this actually do? Does it reserve the memory, i.e. it's =
not
>> > usable for others? If so, shouldn't there be a way for the user to
>> > configure it?
>>
>> It can be re-used by others.. see http://lwn.net/Articles/479297/
>
> The link didn't tell much. I looked at the patches, and
> dma_declare_contiguous allocates the memory with memblock_alloc. So i=
s
> that allocated memory available for any users? If so, why does the
> function want a device pointer as an argument...
>
> Is the memory available for normal kmalloc, or only available via the
> CMA functions? Surely there must be some downside to the above? =3D) =
And
> if so, it should be configurable. You could have a board with no disp=
lay
> at all, and you probably don't want to have 32MB allocated for DRM in
> that case.

Basically the short version is memory from a CMA carveout can be
re-used for unpinnable memory.  Not kmalloc, but it can be used for
anon userspace pages, for example.  Userspace needs memory too.

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
