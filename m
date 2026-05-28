Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC83FD12E
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990198; cv=none; b=u9T49x1Tpz2VojwAy400CMlMCZqgi0dGxHVIxyypotNg3eDZNld1lCpsuMr6fmPHc3A4ewaL51wFV44GpiuAzdBmJ1gEO1BCR+MREUq6/ezViPQ85eZyadcEPpbZBlVeKUUp+tCF5VCHxDFnMx0oTNL2uNtmnoMou39XbONttKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990198; c=relaxed/simple;
	bh=mjlE79CLvFDXiEdLK0Tcwhi3oihAcvaYAUy1iFvYE0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSFaWmxlzR+gS0TQoJFzxk1GwheGp0fni/fyTWcsqIiPI6cpy+jaNqHAIMYHtG6q9Co9zgpOHLNgklil3W3yV0zggGy+9/GTc1hanxshu4Myd7+lu1QZMP08Uh8bM9sTV93xooITM5xDS/w+DmpoLTqownsLlRgWUZ7kZBCgSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3Ns3WiV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3Ns3WiV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49048e043e5so53651885e9.1
        for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990195; x=1780594995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3amWZObV5I3DzXB5gq3TI2uVawFzEbcyJa+h0g3Fi8=;
        b=n3Ns3WiVDr57ZPsB2Pi5BevEVQsJsMeCOXhgAP8G8Lu6hfmbcFBOBW6Mf6xo+f80kD
         zl/tWFmBRJyzohE+o2m2/WlW4jpEKA38RLGa8tHi4V+SxmpzpqO4FZROqKAxR3UAHlut
         ESFyb03Q/zzXYMY0+lc6Ix+AKIi7rQTtpTuDr6QXQ+L5kUrGrDJeMd4lUXD1RqZa+JPJ
         vZSyj0Nlid5ZTHMpfXxMjgIL+Ae4Vb5SsQVa/TixDbaMmYjhVZT7IaaegiWqnB9nXtNK
         ZLESkvIoVupRGVc9QlDSKAwrQsaE+O5W3/xcJJD2fpDtuIxZoKhq91uFD1EujVVKU106
         FyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990195; x=1780594995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3amWZObV5I3DzXB5gq3TI2uVawFzEbcyJa+h0g3Fi8=;
        b=J/rvWAKnhZM5zQFm0HPX5JUtldwAuCd1BqQTXpNYcFRPRQjS7YAsJX1s9fNL+w7jWy
         cl4xSvDSJSh15qsoo57jKGanQQUAHcqQF0BhLXN7xARY9ODG/AP2Yg58tY7xreKE8hDF
         lbY0DR7+uCG7q36OUlnJPraOwwDHfTjwQQ7F2colokWhsP8mOTGzcEcoxWfoDQ5OFFU6
         cZ8HrjxdBirdLJKV7NJaZJ6oD53rr+uMpercYV1rgxm/QSaH2sivtExOfnHJkOvAjWWM
         sHovIUttK+G7HjwCnTOGtBFOFCejJURUwFO1NuKYjOjyBKvCgiA97ZRJ8Te4Bn/Ef/nU
         ymjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ipvRdZIlugcaWYDpxVHxfLUJV8oYK/s63kgPh7QKMMZcPlmPMz+fZFsfCcDDcqrL0K9MtI/8bUe4F@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBSz9mn3rLzL4tsuvL2xy7Oob+PwKckBUheAd2JmSQJYfSyTy
	lmVuvxZWHODeA0R3bSURa5s6U1qcQ2YjA6K1bhb1IRdrReQ475NRS0+K
X-Gm-Gg: Acq92OFUwJqPKhlQM/5OoEs6aocm917eH0lNMHr0wsLqVRpTknb1G/HZfS9IoH9ZaYR
	dzdzud1h6DjHErTU/FVNPfRGKsGR7qModBL4/zf+vWOcZSbETTRqQvlUOkZ8aN5nmgofVtlzFrl
	oWDHgay1CusEHNDy6AECyN60rYAQ7w2jBphZnT/jRE6/GYkOme7IYIHFq4/CNISF2Jqm33C0QgQ
	ThHg5hBMPM0yJKfHcIyEx3rEGqk3BtYbaa2wbU4hP3iL4pz+x2qsKGmTpsygqbiA21c3G8VoVf4
	WvB8sz6WU59tEFns+EL8E0t83a9ArTESYsXaQDhmmfaLa8qRW9Xqk12Kx+hGcM4lymarga0sEYs
	nD+sCpNeEHK8s+BnncDwgSMbJnIWg8cZrysJXr6oNmO9KrllOsMpR6tHcq63KwhWMNMozDHvMeF
	bCW0RltQ40f0qJIRnLnPss6/OhGBcfzvrXAYmkZZMwsUCAqg==
X-Received: by 2002:a05:600c:4591:b0:490:6869:46c6 with SMTP id 5b1f17b1804b1-490686947a8mr269136535e9.31.1779990194506;
        Thu, 28 May 2026 10:43:14 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909235d43esm87284155e9.1.2026.05.28.10.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 10:43:14 -0700 (PDT)
Message-ID: <37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
Date: Thu, 28 May 2026 20:43:12 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <akemnade@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Marek Vasut <marex@denx.de>, "H. Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Andreas Kemnade <andreas@kemnade.info>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
 <ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
 <20260528190234.4c00b740@kernel.org>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260528190234.4c00b740@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 28.05.26 г. 20:02 ч., Andreas Kemnade wrote:
> Hi,
> 
> so this droid4? Or which device is it?
> 

Oh, sorry, yes, this is droid4.

> On Thu, 28 May 2026 17:44:14 +0300
> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
> 
>> Applied against 6.18.31, no dice :)
>>
>> [   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on
>> minor 0
>> [   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>> dispc_component_ops [omapdrm])
>> [   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on minor 1
>> [   12.311981] [drm] Enabling DMM ywrap scrolling
> 
> I would expect some
> output from  the panel-dsi-cm driver:
> dev_info(&ddata->dsi->dev, "panel revision %02x.%02x.%02x\n",
>                          id1, id2, id3);
> 
> or some error:
>          dev_err(&ddata->dsi->dev, "error while enabling panel, issuing HW reset\n");
> 
> Any explanation why it is missing?
> 

It is there, I grep-ed for omapdrm only, didn't want to flood the ML:

2026-05-28T17:34:45.761932+03:00 devuan-droid4 kernel: [   12.502105] 
panel-dsi-cm 58004000.encoder.0: panel revision 70.01.02

Here is the (almost)full boot log: https://paste.debian.net/hidden/e6ca55a7

> 
> 
>> [   12.770385] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [   22.901306] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   22.901306] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit
>> wait timed out
> looks like dsi is not involed here, so something else is producing problems?
> 
>> [   33.131256] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   33.131378] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]
>> commit wait timed out
> 
> This might have something to do with the patch.
> 
>> [   43.371307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   43.371398] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]
>> commit wait timed out
>> [   43.631408] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [   43.692504] omapdrm omapdrm.0: [drm] fb0: omapdrmdrmfb frame buffer
>> device
>> [   54.251342] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   54.251464] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit
>> wait timed out
>> [   64.491302] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   64.491424] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]
>> commit wait timed out
>> [   74.731323] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   74.731445] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]
>> commit wait timed out
>> [   74.991363] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [   85.621307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   85.621398] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit
>> wait timed out
>> [   95.851287] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   95.851379] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]
>> commit wait timed out
>> [  106.101257] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [  106.101440] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]
>> commit wait timed out
>> [  106.371459] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [  106.961334] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [  141.301269] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [  141.301269] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit
>> wait timed out
>> [  151.531280] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [  151.531402] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]
>> commit wait timed out
>>
>>
> Thanks for testing.
> 

You're welcome, I can do more testing as needed, ATM I am trying to 
upgrade leste to 6.18 anyways so have all tools in place. Feel free to 
ping me on leste IRC channel if you think I can be of any help here.

Regards,
Ivo

> Regards,
> Andreas
> 
>> On 28.05.26 г. 13:16 ч., akemnade@kernel.org wrote:
>>> From: Andreas Kemnade <andreas@kemnade.info>
>>>
>>> Some chips need configuration commands to be sent first, before they can
>>> send data. TC358762 for example needs PPI_LPTXTIMECNT configured
>>> and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
>>> configure such chips, do not send bta sync during writes if no acks are
>>> requested. Instead just wait for the packet to be sent to avoid FIFO
>>> overflows. There might be more to do about acks, but there seem to be
>>> virtually no users of that flag.
>>>
>>> This came to light when fiddling with the Epson Moverio BT-200 display
>>> which consists of 2 TC358762 bridges with SPI funneled through
>>> to the unknown display chip. With that patch the bridge can be accessed,
>>> Reading back registers works, when the above-mentioned registers are set.
>>>
>>> Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
>>>
>>> Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>> This was not tested on any command mode display, which IMHO should be
>>> done.  So droid4 folks: please give it a try
>>> ---
>>>    drivers/gpu/drm/omapdrm/dss/dsi.c | 32 +++++++++++++++++++++++---------
>>>    1 file changed, 23 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
>>> index 27fe7bca9e2cf..98362b0157023 100644
>>> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
>>> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
>>> @@ -2194,6 +2194,7 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
>>>    static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>>>    			       const struct mipi_dsi_msg *msg)
>>>    {
>>> +	DECLARE_COMPLETION_ONSTACK(completion);
>>>    	struct dsi_data *dsi = to_dsi_data(dssdev);
>>>    	int r;
>>>    
>>> @@ -2205,17 +2206,30 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>>>    	if (r < 0)
>>>    		return r;
>>>    
>>> -	/*
>>> -	 * TODO: we do not always have to do the BTA sync, for example
>>> -	 * we can improve performance by setting the update window
>>> -	 * information without sending BTA sync between the commands.
>>> -	 * In that case we can return early.
>>> -	 */
>>> +	/* wait for IRQ for long packet transmission confirmation */
>>> +	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
>>> +			&completion, DSI_VC_IRQ_PACKET_SENT);
>>> +	if (r)
>>> +		return r;
>>>    
>>> -	r = dsi_vc_send_bta_sync(dssdev, vc);
>>> -	if (r) {
>>> -		DSSERR("bta sync failed\n");
>>> +	if (wait_for_completion_timeout(&completion,
>>> +			msecs_to_jiffies(500)) == 0)
>>> +		r = -EIO;
>>> +
>>> +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
>>> +			      &completion, DSI_VC_IRQ_PACKET_SENT);
>>> +
>>> +	if (r)
>>>    		return r;
>>> +
>>> +	/* TODO: find out if more needs to be done for MIPI_DIS_MSG_REQ_ACK */
>>> +
>>> +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
>>> +		r = dsi_vc_send_bta_sync(dssdev, vc);
>>> +		if (r) {
>>> +			DSSERR("bta sync failed\n");
>>> +			return r;
>>> +		}
>>>    	}
>>>    
>>>    	/* RX_FIFO_NOT_EMPTY */
>>>
>>> ---
>>> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
>>> change-id: 20260528-vm-upstr-c8e7634ebf56
>>>
>>> Best regards,
>>> --
>>> Andreas Kemnade <akemnade@kernel.org>
>>>
>>>    
>>
>>
> 
