From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 7 Mar 2012 07:27:58 -0600
Message-ID: <CAF6AEGs7nk94YyY462di1CZt627wA2Xan_uL-es-WDCD4SDZ4Q@mail.gmail.com>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	<1331040371.2059.113.camel@deskari>
	<CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	<1331044544.2059.150.camel@deskari>
	<CABT81PhtXsuy_XL0i+4TV=BScYV9-0nfzys5Gi_-=iiSso0bSQ@mail.gmail.com>
	<1331121928.4348.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53394 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab2CGN16 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 08:27:58 -0500
Received: by iagz16 with SMTP id z16so8635518iag.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 05:27:58 -0800 (PST)
In-Reply-To: <1331121928.4348.28.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Gross, Andy" <andy.gross@ti.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, patches@linaro.org, dri-devel@lists.freedesktop.org

On Wed, Mar 7, 2012 at 6:05 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Tue, 2012-03-06 at 09:50 -0600, Gross, Andy wrote:
>>
>>
>> On Tue, Mar 6, 2012 at 8:35 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m>
>> wrote:
>>
>>
>> =A0 =A0 =A0 =A0 I have to say I don't know much about DMM, but my
>> =A0 =A0 =A0 =A0 understanding is that
>> =A0 =A0 =A0 =A0 DMM is a bigger entity, of which TILER is only a sma=
ll part,
>> =A0 =A0 =A0 =A0 and DMM
>> =A0 =A0 =A0 =A0 manages all memory accesses.
>>
>> =A0 =A0 =A0 =A0 Can there be other users for the DMM than DRM? I kno=
w there
>> =A0 =A0 =A0 =A0 could be
>> =A0 =A0 =A0 =A0 other users for the TILER, and I know you want to co=
mbine that
>> =A0 =A0 =A0 =A0 with the
>> =A0 =A0 =A0 =A0 DRM driver, but I'm wondering about the other parts =
of DMM
>> =A0 =A0 =A0 =A0 than the
>> =A0 =A0 =A0 =A0 TILER.
>>
>> =A0 =A0 =A0 =A0 Somehow having a DMM driver inside omapdrm sounds st=
range.
>>
>>
>> The DMM does indeed contain a number of entities. =A0However, the TI=
LER
>> portion is the only part that requires a driver. =A0All other regist=
er
>> modifications (LISA map settings, EMIF, etc) are done statically in
>> the loader or u-boot and never changed again. =A0As such, DMM has be=
come
>> synonymous with TILER.
>
> Ok. Well, as I said, I don't know much about that, just sounds rather
> strange to me =3D).
>
> Does this "DMM has become synonymous" mean that people just started
> calling TILER DMM, and thus the name has stuck, or are there technica=
l
> reasons to handle it as DMM in the kernel? If the former, and if TILE=
R
> is the technically exact name for it, perhaps it would make sense to
> call it TILER, as that's what (at least I) would be looking for if I
> read the TRM and try to find the code for the TILER.

Well, "dmm" is the name in hwmod, so either way we are sort of "stuck"
with that.. but if you look in the TRM, you'd be looking for "dynamic
memory manager", so I tend to think "dmm" is the better name.  But for
some reason the old driver (in some product kernels but never made it
upstream) was called "tiler", which might be part of the reason that
people have started using the names interchangeably.

At any rate, neither "tiler" nor "dmm" appear in any userspace facing
API (instead you just have some bits you can set in the flags you
specify if you want tiled buffer or not when allocating a gem buffer
object).  So I guess it isn't as critical.

BR,
-R

> =A0Tomi
>
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
