Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412022;
	b=wRtKooFRnYM+O5WXe8xwSJtEpuTNOmbjNpizwpzmwJQ5qU4vZDtR+MDP8h05fKXiXDn5
	 DH/5rGzndnx0M/PfHNqKPzxvVsirN4CvgBTOibG3KZiRxVh8G3QLioZ82jb4NdAymjP6h
	 Ei6DChFGwlgt8Yf66plJGXWdrxIe/Ntf1i00ONO8d8f0wyhqrgqkUL/SYS3MTzLnnB3Jy
	 78b0FVqLMKIhCMvu4knbJ/SMP231gEglknw8amrOoH5f2ykauj9NwZww2dg4yz1euGvcm
	 p2O0Jdl2g5FYWxyt9SuOe+AvcRVHfseuXMNf9XOcjtZPVsAUTmLzk5QeYrM0fKc8BSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412022;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:Subject:
	 Cc:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=lObV9SJ3OT2Wgv/d4ibJqweN/ItK4qe1uoafBv25MSk=;
	b=h1Y6hXDeKHPtrDr7iquKG+JPueK9ARApc+s5tHs4Kc/vfhM0dKpQAZQmoKiFQDncaY6R
	 HYiugbRsU7W117VXwgncuDNp0iHbkfmRsMHwS/AHxv3iZKKOfdi+cgZjSHePPT8/eitpy
	 g9ct445WF0iDkFWCg+rbmEgqzo/MmJ5iyT+r+GGoKgqJG0Q1sw659Xco36OfUYbe+aYjE
	 JJ+SKv9ijaDafbrk/hh+uE7s5w8uYVE9Ki5IJwGItJpNRnOUvX4wBeB3IjBS9CVwYlpOe
	 ZlTZ2sNnYD5TxEWqmH7UX64j8K4MoXe8kjMYBSJBR+pXDGmmL0978pY3Z9PzI/syhVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pa1SkCau;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23113606A890
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2026 15:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23113606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pa1SkCau
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 72B064E41408;
	Wed, 11 Nov 2026 15:46:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 247E86017E;
	Wed, 11 Nov 2026 15:46:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D2B111BC11DA;
	Wed, 11 Nov 2026 16:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794412016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lObV9SJ3OT2Wgv/d4ibJqweN/ItK4qe1uoafBv25MSk=;
	b=pa1SkCauabOXsGW1QTvaCW47YI99lKCbofvAZexbKBnnfFh55KV3oxKqHEM9b8AaV+Uj+t
	5oody8gTTyaxGnhdmUoldPEwpFgdESY2nZO/y6RKKMI5PkmzgzYrrVhdSJ5ACbwB/tB3J5
	rIBNsTavzzzfCU6PazyuSxFAYXlN0Uv6yTQ/3iYgJYLR077mTxRL14irfC+co9k6O/byy0
	BiDzxMdfpGjZdykdxVzWOk23FzoRs1a0kkhGLwlFI3j70yLhOeUn8fzujGEweeU8yfscGU
	tFL/93qAg6YkvvjGyQpg2LPNapv51pcpxL8BbCV8cr23YQhRkfVDVZQzI7FKZg==
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 16:46:51 +0100
Message-Id: <DMSHYXQ01R6O.3F13LZ51TUPCP@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/omap: dss: fix handling deferrals
Cc: <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
 <hns@goldelico.com>, <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Andreas Kemnade"
 <andreas@kemnade.info>
X-Mailer: aerc 0.22.0
References: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info> <33f63eaf-42a0-4b3f-a21c-3752436d07b4@ideasonboard.com>
In-Reply-To: <33f63eaf-42a0-4b3f-a21c-3752436d07b4@ideasonboard.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Andreas,

On Wed Nov 11, 2026 at 3:56 PM CET, Tomi Valkeinen wrote:
> Hi,
>
> On 11/11/2026 14:22, Andreas Kemnade wrote:
>> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
>> EPROBE_DEFER to ensure output gets initialized later when available.
>>
>> On GTA04/OMAP3 no display was found, but it appeared after doing
>> rmmod omapdrm ; modprobe omapdrm
>>
>> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")

Ouch, sorry about breaking this driver. To my excuse the old code removed
by b7e9b93fc8ecf was (ans still is) pretty obscure.

>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> ---
>>   drivers/gpu/drm/omapdrm/dss/output.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omap=
drm/dss/output.c
>> index 36d37deac8026..220ed7e003080 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/output.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
>> @@ -24,6 +24,11 @@ int omapdss_device_init_output(struct omap_dss_device=
 *out,
>>
>>   	bridge =3D of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_p=
ort, 0);
>>   	if (IS_ERR(bridge)) {
>> +		if (PTR_ERR(bridge) =3D=3D -EPROBE_DEFER) {
>> +			ret =3D PTR_ERR(bridge);
>> +			goto error;
>> +		}
>> +
> Shouldn't we just return PTR_ERR(bridge) here? The error label will call
> omapdss_device_cleanup_output(), which cleans up things set up later in
> this function.

Indeed.


Additionally, by looking at the omapdss_device_init_output() code right
now, the goto-based error management appears:

 1. unnecessarily complicated: only one goto for only one line of rollback
    code

 2. potentially wrong, or at least doing too much, because
    omapdss_device_cleanup_output() does two things:

      a. drm_bridge_put(out->next_bridge): but when goto is invoked the
         out->next_bridge pointer has not been touched yet
         (I assume we should not touch the refcount in this case)

      b. drm_bridge_put(out->bridge): unneeded because the goto is inside
         an 'if (!out->bridge)', thus there is no reference at all to put

Do you agree with these findings?

If you do, I guess this simple patch should fix both at once (untested):

---------------------------------8<---------------------------------
@@ -31,20 +31,14 @@ int omapdss_device_init_output(struct omap_dss_device *=
out,
        out->bridge =3D bridge;

        if (local_bridge) {
-               if (!out->bridge) {
-                       ret =3D -EPROBE_DEFER;
-                       goto error;
-               }
+               if (!out->bridge)
+                       return -EPROBE_DEFER;

                out->next_bridge =3D out->bridge;
                out->bridge =3D drm_bridge_get(local_bridge);
        }

        return 0;
-
-error:
-       omapdss_device_cleanup_output(out);
-       return ret;
 }
---------------------------------8<---------------------------------

Can you double check this, test on hardware and if it looks correct send
that as a separate patch?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
