From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] staging: drm/omap: add rotation properties
Date: Fri, 29 Jun 2012 07:17:23 -0500
Message-ID: <CAF6AEGsW158Z1zsTsygmwHfBeLVRdP6zuf06SWvQ=SiRX13X4Q@mail.gmail.com>
References: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
	<1340966763.2767.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57134 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab2F2MRY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 08:17:24 -0400
Received: by vbbff1 with SMTP id ff1so2258971vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 05:17:23 -0700 (PDT)
In-Reply-To: <1340966763.2767.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>, cmahapatra@ti.com, s-guiriec@ti.com, archit@ti.com

On Fri, Jun 29, 2012 at 5:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-06-27 at 09:06 -0500, Rob Clark wrote:
>> From: Rob Clark <rob@ti.com>
>>
>> Use tiled buffers for rotated/reflected scanout, with CRTC and plane
>> properties as the interface for userspace to configure rotation.
>>
>> Signed-off-by: Rob Clark <rob@ti.com>
>
>> +/* this should probably be in drm-core to standardize amongst drive=
rs */
>> +#define DRM_ROTATE_0 0
>> +#define DRM_ROTATE_90 =A0 =A0 =A0 =A01
>> +#define DRM_ROTATE_180 =A0 =A0 =A0 2
>> +#define DRM_ROTATE_270 =A0 =A0 =A0 3
>> +#define DRM_REFLECT_X =A0 =A0 =A0 =A04
>> +#define DRM_REFLECT_Y =A0 =A0 =A0 =A05
>
> Are both reflect X and Y needed? You can get all the possible
> orientations with just one of the reflects.
>
> And I think the word "mirror" represents nicely what the reflect does=
,
> i.e. if you look at the mirror, the image you see is flipped
> horizontally.

fwiw these values are aligned with what is used in userspace xrandr..
an earlier version of this patch used just 3 bits, which where aligned
with what the omap hw uses and can describe all possible combinations
of mirroring and isomorphic rotation (x-invert, y-invert, and
xy-flip).  But the advantage of the xrandr approach is you can more
easily leave out bits for rotation/mirroring modes that your hw does
not support.. for example if some hw supports only certain rotations
or does not support mirror/reflect.

BR,
-R

> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
