From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 2/2] Expose the OMAP Z-Order property through DRM
Date: Thu, 16 Aug 2012 08:18:39 -0500
Message-ID: <CAF6AEGvR8+PNHEhsN2EpEm1e1=m06gNYCWBxwGFNZiQgpqbJHA@mail.gmail.com>
References: <1345061882-9743-1-git-send-email-rob.clark@linaro.org>
	<1345061882-9743-3-git-send-email-rob.clark@linaro.org>
	<20120816130053.GA4421@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46220 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161Ab2HPNSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Aug 2012 09:18:40 -0400
Received: by vcbfk26 with SMTP id fk26so2329915vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 06:18:39 -0700 (PDT)
In-Reply-To: <20120816130053.GA4421@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>

On Thu, Aug 16, 2012 at 8:00 AM, Ville Syrj=E4l=E4
<ville.syrjala@linux.intel.com> wrote:
> On Wed, Aug 15, 2012 at 03:18:02PM -0500, Rob Clark wrote:
>> From: Andre Renaud <andre@bluewatersys.com>
>>
>> Added support for zorder changes through DRM plane properties
>>
>> Signed-off-by: Andre Renaud <andre@bluewatersys.com>
>> Signed-off-by: Rob Clark <rob@ti.com>
>> ---
>>  drivers/staging/omapdrm/omap_drv.h   |    1 +
>>  drivers/staging/omapdrm/omap_plane.c |   19 +++++++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/om=
apdrm/omap_drv.h
>> index b103d28..9dc72d1 100644
>> --- a/drivers/staging/omapdrm/omap_drv.h
>> +++ b/drivers/staging/omapdrm/omap_drv.h
>> @@ -62,6 +62,7 @@ struct omap_drm_private {
>>
>>       /* properties: */
>>       struct drm_property *rotation_prop;
>> +     struct drm_property *zorder_prop;
>>  };
>>
>>  /* this should probably be in drm-core to standardize amongst drive=
rs */
>> diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/=
omapdrm/omap_plane.c
>> index 6931d06..4bde639 100644
>> --- a/drivers/staging/omapdrm/omap_plane.c
>> +++ b/drivers/staging/omapdrm/omap_plane.c
>> @@ -433,6 +433,15 @@ void omap_plane_install_properties(struct drm_p=
lane *plane,
>>               priv->rotation_prop =3D prop;
>>       }
>>       drm_object_attach_property(obj, prop, 0);
>> +
>> +        prop =3D priv->zorder_prop;
>> +        if (!prop) {
>> +             prop =3D drm_property_create_range(dev, 0, "zorder", 0=
, 3);
>> +             if (prop =3D=3D NULL)
>> +                     return;
>> +             priv->zorder_prop =3D prop;
>> +     }
>> +     drm_object_attach_property(obj, prop, 0);
>>  }
>>
>>  int omap_plane_set_property(struct drm_plane *plane,
>> @@ -452,6 +461,16 @@ int omap_plane_set_property(struct drm_plane *p=
lane,
>>                       ret =3D omap_plane_dpms(plane, DRM_MODE_DPMS_O=
N);
>>               else
>>                       ret =3D 0;
>> +     } else if (property =3D=3D priv->zorder_prop) {
>> +             struct omap_overlay *ovl =3D omap_plane->ovl;
>> +
>> +             DBG("%s: zorder: %d", ovl->name, (uint32_t)val);
>> +             omap_plane->info.zorder =3D val;
>
> What would happen when there's a conflicting assignment between two
> planes?

non-good things.. basically as part of re-working the
omapdss<->omapdrm stuff, I'll have a good point in omapdrm before
setting GO bit(s) where I can calculate the actual z-order from that
is set from userspace.  If two planes had same z-order from userspace,
omapdrm would simply put one in front of the other.  If the planes
aren't overlapping, this is fine.

> I tried to think of a decent way to do this stuff, but some hardware
> can have rather complicated stacking order limitations. One idea I
> came up with was to have an enum prop on the crtc, where the individu=
al
> enum value names would somehow describe the whole stacking order with=
in
> the crtc. That way user space couldn't even try to use an unsupported
> configuration. The downside is that user space would need to parse
> those strings if it wants to do some automagic stacking order changes=
,
> which means the string format would need some though.

I was thinking about this, but then you run into the same issue if you
move a plane from one CRTC to another without userspace setting the
property again.  In the end if userspace is ambiguous the driver has
to just arbitrarily pick some z-order to keep the hw happy.

BR,
-R

> --
> Ville Syrj=E4l=E4
> Intel OTC
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
