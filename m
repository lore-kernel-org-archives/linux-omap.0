Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22113BED23
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979460; cv=none; b=jC7H/Qk8DKzklP+swrB1yE/qLpX8DnyyN+iF5B2v7fINVAG1LmmxDjscF2NyiQhL5ykFXdF3mVlpDAf67is3jMwbhL5WGrWcv8ogbPcS2P+41mQDhYgBlku07F7osDfL+WLSEjIFNuLT8bJnvaNwH1WVsz2KiPTs8nMjGam3f1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979460; c=relaxed/simple;
	bh=sPTKnC3+rF3Fi8+foWMfJkE3GcVdtuoZwJ9tgO8Zbf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZ5iEKD9tHuD17B3D2RGOXsc4G+qX7tIQPOlCKhzSaGjjjRIlysTBJ/Qo9th0Irq1cdG0QR/31oQqO7/5T8rpHGIz0Gu0GUgUNVkEXtztJQNIggXgwK2ubQjqvr2kN1piC5kcyK2inSZP+xEltHP7rTgD8+Nzou5VJp0Cmni++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHOg2WyN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHOg2WyN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eeea039ebso113460f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779979457; x=1780584257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+B00isbVBFjhd0ersE38u3Z7GxR7KNbXX2WyPtNeCI4=;
        b=ZHOg2WyN7ujI+Xf25mb1goe00C89LmjcuDPf80gKc4OzDVeicnigVMICFKKAex4jFq
         yxxCfFcC5PH1H3haT2Qu9FcsxaANx7uQDzyMkY6QM4MOP26KdZV+c3G992Vj1DRqHsPo
         3GUnmmswHYUDWibuB52SQlHGcSmvJRGm1UaW60EHFCr/NIZDs2q09DMZlA+bVsNbCyOs
         5RTxYZjS6ikr+GRJQ8gTrRqeqqVAVf23BhoToIKl3MtCKsiyuD5cnLXTbxUKZn1q6G3r
         S3zQ3pC/rv0W750jMORzuNNR/zNBpYzDNaBWyCAIHXvA0mJhXAPZB8DFQTz4NMxa2SaZ
         rheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779979457; x=1780584257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+B00isbVBFjhd0ersE38u3Z7GxR7KNbXX2WyPtNeCI4=;
        b=ZnfUSa7oKSkeo/aHwyq1SqppXN5CoJ54rpDqKKZe9ondnGDDi6qvG9l/yHNYsP2ty6
         FGIZ7513+ScepdCQFoXVSGWbHrNBcF9RdmAWKbC0/g7WJbe/AjAKl8tzoeL8I60IyZsI
         QWS42ExNmEe/ZOPlpGLqkW6E6fMqNuOd2KPfOTLU7efPr54gxz+TRhgTlq5YNC4rrK6j
         ShqfaBWocbcIpmnPguZBeNDb0Rc7isb3WW3T9vS4Pgww7hdrB90BHrqdGBwvO7DDkfYc
         bkA2U70GpjxY5ibsw0rG9ygrLGFCAoFkwebi1vxcJNmSxYLQwLiF1RL7r1RyEmo99NzQ
         ciTg==
X-Gm-Message-State: AOJu0Yyh60CoV/2HbCZGR7F/IAfy9BCo892wyQ9cYDx0TINnByrKwu3U
	7in79P6nv3EclbcaaSaP1tj6v706tYmqkC43r21eZS7t1pDfzqDrzoh8
X-Gm-Gg: Acq92OGACLfSXKwTV/W00kFA8wrkXHu9MNra0w7lEiwErLJ/kFCUo4jvPvnE6Bn7N4Y
	mv/FA/wG5pX9f9EE+kxBIyUSUXTqv7MtiCuvrALHhz27N22868E+m8ywYvzUBBslNmIbS3KHBk5
	K5uS1D4+mD/b0gu1NBIvrMnL7lSKw5RgyaWzd616AnS9ZeJgMaIbfcF5zXVqdsqV3vci08QJKXZ
	RBKgNuoYnhZeB1eXVhqJwiEZ7YvYuf3D3m2uk//sBPHq8tV87LJmmNSRB/8NZBXKOw65wwHKi3A
	R6+7EJoqsZqVHQUvjevDxFtzbpQj6TMJxPzKweTMolvJRj5jzjPDvF+Rsknmbb2lbAA0P4nFELk
	3dSuXPiGoZaePxJiH8Ku/rPfCEBVuWTzzA60Tfo6LVC19VI4ibkTLol4fMhfhlk6tYV4f/uFWVX
	Rc6o7J4KHU51bKmZ1W9C0KfCwaVE+A6L6JHgyhbCwywUVQGg==
X-Received: by 2002:a05:600c:8a0d:20b0:490:32da:30d with SMTP id 5b1f17b1804b1-4904249742cmr336725155e9.9.1779979456942;
        Thu, 28 May 2026 07:44:16 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49092654befsm44027825e9.6.2026.05.28.07.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 07:44:16 -0700 (PDT)
Message-ID: <ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
Date: Thu, 28 May 2026 17:44:14 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: akemnade@kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Andreas Kemnade <andreas@kemnade.info>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Applied against 6.18.31, no dice :)

[   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on 
minor 0
[   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops 
dispc_component_ops [omapdrm])
[   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on minor 1
[   12.311981] [drm] Enabling DMM ywrap scrolling
[   12.770385] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[   22.901306] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   22.901306] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit 
wait timed out
[   33.131256] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   33.131378] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1] 
commit wait timed out
[   43.371307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   43.371398] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0] 
commit wait timed out
[   43.631408] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[   43.692504] omapdrm omapdrm.0: [drm] fb0: omapdrmdrmfb frame buffer 
device
[   54.251342] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   54.251464] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit 
wait timed out
[   64.491302] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   64.491424] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1] 
commit wait timed out
[   74.731323] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   74.731445] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0] 
commit wait timed out
[   74.991363] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[   85.621307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   85.621398] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit 
wait timed out
[   95.851287] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   95.851379] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1] 
commit wait timed out
[  106.101257] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[  106.101440] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0] 
commit wait timed out
[  106.371459] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[  106.961334] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[  141.301269] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[  141.301269] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit 
wait timed out
[  151.531280] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[  151.531402] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1] 
commit wait timed out


On 28.05.26 г. 13:16 ч., akemnade@kernel.org wrote:
> From: Andreas Kemnade <andreas@kemnade.info>
> 
> Some chips need configuration commands to be sent first, before they can
> send data. TC358762 for example needs PPI_LPTXTIMECNT configured
> and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
> configure such chips, do not send bta sync during writes if no acks are
> requested. Instead just wait for the packet to be sent to avoid FIFO
> overflows. There might be more to do about acks, but there seem to be
> virtually no users of that flag.
> 
> This came to light when fiddling with the Epson Moverio BT-200 display
> which consists of 2 TC358762 bridges with SPI funneled through
> to the unknown display chip. With that patch the bridge can be accessed,
> Reading back registers works, when the above-mentioned registers are set.
> 
> Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
> 
> Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> This was not tested on any command mode display, which IMHO should be
> done.  So droid4 folks: please give it a try
> ---
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27fe7bca9e2cf..98362b0157023 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2194,6 +2194,7 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
>   static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>   			       const struct mipi_dsi_msg *msg)
>   {
> +	DECLARE_COMPLETION_ONSTACK(completion);
>   	struct dsi_data *dsi = to_dsi_data(dssdev);
>   	int r;
>   
> @@ -2205,17 +2206,30 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>   	if (r < 0)
>   		return r;
>   
> -	/*
> -	 * TODO: we do not always have to do the BTA sync, for example
> -	 * we can improve performance by setting the update window
> -	 * information without sending BTA sync between the commands.
> -	 * In that case we can return early.
> -	 */
> +	/* wait for IRQ for long packet transmission confirmation */
> +	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> +			&completion, DSI_VC_IRQ_PACKET_SENT);
> +	if (r)
> +		return r;
>   
> -	r = dsi_vc_send_bta_sync(dssdev, vc);
> -	if (r) {
> -		DSSERR("bta sync failed\n");
> +	if (wait_for_completion_timeout(&completion,
> +			msecs_to_jiffies(500)) == 0)
> +		r = -EIO;
> +
> +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> +			      &completion, DSI_VC_IRQ_PACKET_SENT);
> +
> +	if (r)
>   		return r;
> +
> +	/* TODO: find out if more needs to be done for MIPI_DIS_MSG_REQ_ACK */
> +
> +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
> +		r = dsi_vc_send_bta_sync(dssdev, vc);
> +		if (r) {
> +			DSSERR("bta sync failed\n");
> +			return r;
> +		}
>   	}
>   
>   	/* RX_FIFO_NOT_EMPTY */
> 
> ---
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> change-id: 20260528-vm-upstr-c8e7634ebf56
> 
> Best regards,
> --
> Andreas Kemnade <akemnade@kernel.org>
> 
> 
