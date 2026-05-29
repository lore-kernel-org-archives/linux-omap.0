Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E1351C0D
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2026 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035989; cv=none; b=ddoMNdwtAWko80HMQM5goX0LwMLmhCbyzmftA93yVm0Zv+D65e9eESRH2EzGxzXYC2j4PdQNxtfhgcmSW0apQa7xEmGsqLXwpWMD53WXdVV+I0zfOp0Un215XKAHAjLr0PJ4u3MXcNzuxCgcNpQRefG79anZEkwqBoAKvMPdm4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035989; c=relaxed/simple;
	bh=4tIOhzB8HhqUG/CMo1D8RPwFfHP7hzp+hMbw8lDkHeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8CWC68+3owgYeE4OCMsCzm5f7rKHtY/wtk8nDpU8WQmpIvG5U3WNbCSEAVMHKbIT1OnzcW2rh3Aq0Ccx59uvCuZ6DN6n+Ln71/ev/1Png/WDpTX+mhqIbdZ3Q8YN8yFH3q/m09fSh0/TnJdz9Ihq2XCqWMcHrELGqkGS5Rebu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaZz79+O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaZz79+O"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so872964f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780035986; x=1780640786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6w0+5mCVlOlxvbGiaPZUip+G9h6j0Uqf+tR53uTjHI=;
        b=QaZz79+OV44R5Bet3qco/lXbVllsvr68EA5v4WrLwhGzE2q5m5lR0K7U8dnYkDXiAT
         Fx8lMRgEDRs8ZETRr351kC59NbCm4dTS7eU0gXo2XlzddXwT/g1mS/TiIJ83J2O899km
         29U+IVxGcIITQYl/rpB6AyEavh28wgdOSPKHhTxN990xyi6FvEJNciNGUai4rGEZmu07
         qxk9qFRIRxbXx/ZZ8q+W46E9E7aLW5DeaywTGrDmN/w9sIip2JpyXQnZigNUqv3fyQ79
         FDMUo85PxyJUpQhkXn7gm9a0ULH6Xz+OoLsKgZ8W9sAwN0vewJwJOJD+f+QFL2WfvRmj
         JgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780035986; x=1780640786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6w0+5mCVlOlxvbGiaPZUip+G9h6j0Uqf+tR53uTjHI=;
        b=B2tEuyPGeoLpHCcUYQwDZNPjJkz9lYTD7PB5JxT4cxpEXtinvvusCBk2DbSWPzCiHd
         SsXeaG4e+w3R23l90GzGyr7cANiV3tb4wRJHP2Ru+QmrYFjB2yLHzSmw+LLcRW4oXe9O
         bVBTEuMjmdSgG9IoGO6r43CRjtafKwcPABTGb/oL8Pudu/FUH4csaN+m5+1bxOe/dQvD
         3OYKi4xqC3dYGEd8x9O50Uz7mJks5vQFdKAj5+E76CZzaVOU/QmB2o8eF1UYZWrI3vEm
         9yaWvqroPQReS6g33opsnerO7ulN9HKJ1UezCHlWzrA+Wjr3E+8tjeGYiimVcK/2fNof
         XciA==
X-Forwarded-Encrypted: i=1; AFNElJ+qc6oetAln+FxNR/Y01hWkXoHTFmYo9DKnoPTTz4DwEpkf/wD3sCrOfBNlnJ9MC/Oo1SSnAEw8Gu1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFFt4JuliZTsuDIM1jmsEiSrdO5EKXS9gyvUfpVuz7hgYBhZX
	k6JRNH7kt08rj7O2o2Jb3VNxLW0gdDz9ZJEu1b2Jb/yb/SiCUi6krgGr
X-Gm-Gg: Acq92OH2i+5gfdWqNG1pjiqUX9Zkge3GbJLqQQw2dSt2UhGfx0d9+bsG8L1ste4wzvk
	j/RVvKL5SYwJsTddDcOgqZPdqiR9Ol/0yQFcl1x3/+2TXSW3r5TX3FnXqwVuu0w7r6z8tiF+U6+
	6SsCXhTPM1oE5YTvnfNs19pS7d2uN5i2jOMYK/Vl+h950CQu34zoRVOULHwtDvhv69vNbUqpBjI
	otzPuB5xxoBW+nfRHFJCoG4JaCc9x+5OcuC4OstffH9ngBGU6B65FxbRWj3K7lh1TYEjBFpdycR
	jaLdN1Gfg+Lnpq6MBvauLCGFlNwcjWywvspmKZBSNl6IORcTZXhxIpGHmUOnTRgaYNqtoTgcy3o
	3P6jJQ2sRvGIRewatfZOEq1AW56l3iUYdf7uK4eiEg2wNywBNNxK3REHIRsTqSITEqKx9HJxS5Q
	Yrws2G2gjYCalj5LA7mEYDdLSEXy37FkNXU0yWBhqm3qpYu1g71v+66aT4
X-Received: by 2002:a05:600c:3545:b0:490:50ff:d394 with SMTP id 5b1f17b1804b1-4909c1670a5mr24522085e9.16.1780035985401;
        Thu, 28 May 2026 23:26:25 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45ef34b47eesm1319191f8f.9.2026.05.28.23.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 23:26:25 -0700 (PDT)
Message-ID: <4cb8a90b-6345-47a8-b15a-a977a33af8b3@gmail.com>
Date: Fri, 29 May 2026 09:26:23 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Marek Vasut <marex@denx.de>, "H. Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
 <ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
 <20260528190234.4c00b740@kernel.org>
 <37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
 <20260528220603.6600d45b@kemnade.info> <20260528221912.1771daa4@kemnade.info>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260528221912.1771daa4@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

with the following changes:

user@devuan:/media/user/7b76ddc8-44f5-47b5-af5b-e5e9b5ab39c3/user/linux_openpvrsgx$ 
git diff drivers/gpu/drm/omapdrm/dss/dsi.c
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c 
b/drivers/gpu/drm/omapdrm/dss/dsi.c
index af27339c79f9..8ffcd95c3bc3 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2199,7 +2199,7 @@ static int dsi_vc_write_common(struct 
omap_dss_device *dssdev, int vc,
         int r;

         if (mipi_dsi_packet_format_is_short(msg->type))
-               r = dsi_vc_send_short(dsi, vc, msg);
+               return dsi_vc_send_short(dsi, vc, msg);
         else
                 r = dsi_vc_send_long(dsi, vc, msg);

@@ -3247,21 +3247,6 @@ static int _dsi_update(struct dsi_data *dsi)
         return 0;
  }

-static int _dsi_send_nop(struct dsi_data *dsi, int vc, int channel)
-{
-       const u8 payload[] = { MIPI_DCS_NOP };
-       const struct mipi_dsi_msg msg = {
-               .channel = channel,
-               .type = MIPI_DSI_DCS_SHORT_WRITE,
-               .tx_len = 1,
-               .tx_buf = payload,
-       };
-
-       WARN_ON(!dsi_bus_is_locked(dsi));
-
-       return _omap_dsi_host_transfer(dsi, vc, &msg);
-}
-
  static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
  {
         struct dsi_data *dsi = to_dsi_data(dssdev);
@@ -3282,11 +3267,11 @@ static int dsi_update_channel(struct 
omap_dss_device *dssdev, int vc)
         DSSDBG("dsi_update_channel: %d", vc);

         /*
-        * Send NOP between the frames. If we don't send something here, the
+        * Transition to LP here. If we don't send something here, the
          * updates stop working. This is probably related to DSI spec 
stating
          * that the DSI host should transition to LP at least once per 
frame.
          */
-       r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
+       r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
         if (r < 0) {
                 DSSWARN("failed to send nop between frames: %d\n", r);
                 goto err;


Leste boots properly on droid4. No visible side effects in hildon so 
far, chromium runs as slow as usual, glmark2 score is 85, which looks 
normal, so with the above changes you may add my Tested-by, unless you 
want me to test more things.

Thanks and regards,
Ivo

On 28.05.26 г. 23:19 ч., Andreas Kemnade wrote:
> On Thu, 28 May 2026 22:06:03 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
>> On Thu, 28 May 2026 20:43:12 +0300
>> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
>>
>>> Hi,
>>>
>>> On 28.05.26 г. 20:02 ч., Andreas Kemnade wrote:
>>>> Hi,
>>>>
>>>> so this droid4? Or which device is it?
>>>>      
>>>
>>> Oh, sorry, yes, this is droid4.
>>>    
>>>> On Thu, 28 May 2026 17:44:14 +0300
>>>> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
>>>>      
>>>>> Applied against 6.18.31, no dice :)
>>>>>
>>>>> [   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on
>>>>> minor 0
>>>>> [   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>>>>> dispc_component_ops [omapdrm])
>>>>> [   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on minor 1
>>>>> [   12.311981] [drm] Enabling DMM ywrap scrolling
>>>>
>>>> I would expect some
>>>> output from  the panel-dsi-cm driver:
>>>> dev_info(&ddata->dsi->dev, "panel revision %02x.%02x.%02x\n",
>>>>                           id1, id2, id3);
>>>>
>>>> or some error:
>>>>           dev_err(&ddata->dsi->dev, "error while enabling panel, issuing HW reset\n");
>>>>
>>>> Any explanation why it is missing?
>>>>      
>>>
>>> It is there, I grep-ed for omapdrm only, didn't want to flood the ML:
>>>
>>> 2026-05-28T17:34:45.761932+03:00 devuan-droid4 kernel: [   12.502105]
>>> panel-dsi-cm 58004000.encoder.0: panel revision 70.01.02
>>>
>>> Here is the (almost)full boot log: https://paste.debian.net/hidden/e6ca55a7
>>>    
>> 2026-05-28T17:34:45.763732+03:00 devuan-droid4 kernel: [  112.820404] DSI: omapdss DSI: failed to send nop between frames: -5
>> 2026-05-28T17:34:45.763732+03:00 devuan-droid4 kernel: [  113.331726] DSI: omapdss DSI: failed to send nop between frames: -5
>>
>> and that is interesting. Apparently no PACKET_SENT_IRQ and the wait
>> completion times out. Maybe it is not used with short packets.
>> But..
>>         /*
>>           * Send NOP between the frames. If we don't send something here, the
>>           * updates stop working. This is probably related to DSI spec stating
>>           * that the DSI host should transition to LP at least once per frame.
>>           */
>>          r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
>>
>> I do not see a reason why something should go into LP mode here. the
>> message will probably be sent in HS mode but the BTA sync (not done anymore)
>> is probably the only thing turning something to LP mode.
>>
>> So to avoid PACKET_SENT_IRQ trouble, do:
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> index dcfcfc0efcdc..37323c9b08a8 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> @@ -2200,7 +2200,7 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>>   	int r;
>>   
>>   	if (mipi_dsi_packet_format_is_short(msg->type))
>> -		r = dsi_vc_send_short(dsi, vc, msg);
>> +		return dsi_vc_send_short(dsi, vc, msg);
>>   	else
>>   		r = dsi_vc_send_long(dsi, vc, msg);
>>   
>>
>> Also try:
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> index dcfcfc0efcdc..37323c9b08a8 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> @@ -3283,11 +3283,11 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>>   	DSSDBG("dsi_update_channel: %d", vc);
>>   
>>   	/*
>> -	 * Send NOP between the frames. If we don't send something here, the
>> +	 * Transition to LP here. If we don't send something here, the
>>   	 * updates stop working. This is probably related to DSI spec stating
>>   	 * that the DSI host should transition to LP at least once per frame.
>>   	 */
>> -	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
>> +	r = dsi_vc_send_bta_sync(dssdev, vc);
> 
> probably rather VC_CMD
>>   	if (r < 0) {
>>   		DSSWARN("failed to send nop between frames: %d\n", r);
>>   		goto err;
>>
>>
>>
>> Regards,
>> Andreas
>>
> 
