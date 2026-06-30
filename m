Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D335AC27
	for <linux-omap@vger.kernel.org>; Tue, 30 Jun 2026 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798183; cv=none; b=YgR74vWPgW85yPbWd0tuuuq/Vu+AAioPc8cdsWPAIwVPJ9YgIRUKdpqoK6/ulLMXYNgsPwnI0ovFxa3ZTQBnK6r3sczBxsBEVfya5W7OoiKgGWumcGnroPfBJdVN9tRY6qt9okVcqqAGwc5jqqwdeWqizahbBZ6Q9mTQoMaySqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798183; c=relaxed/simple;
	bh=LyrUuq/OZYi1Vy7RnOIIksiVI9H9chX7neLc+dpo/og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFK14WrLyzhmgqkRrDs5K9fXStOwJE9kN7zOca9vv1G8g/o/XU1OspHM+eSAqlVYRhEA3p02/u0VLZ2hpu+wQ3ra2OAmmNyYtEEdGNOmUHZ4+GYsYQGC39ktKTgK+iA+4Mw2xZamh8BGrPei3mGx7ADciItY3zWnqUjKfDo94Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkPpBVnj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkPpBVnj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493a613571eso17945685e9.3
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2026 22:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782798180; x=1783402980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l60qb829+b056CbQNBxrBvUbd99a3Y5SxJc1xaAoFIk=;
        b=MkPpBVnjHzECzIuOGy7XjRFm8IYFMNWdIOavWHKTOUmjZvPhfSKu7chrjN+OtDQkgM
         yywNPemKM3YhNJWAKcxgOx0anrp1Nd4N2C1W5rTHdFPEGU/Eh8JpjCE3p0+oH9S0VlWU
         1YJXzM7t811ID1qSYfTZiP83N7Tb4QQWeqSXzxk9VpCGd2vTnFDxuKAEyRtnMJEJmTqh
         9+R34gU0YELf3tw5mu/tQeArXqLgoWaJhiGTFQOEFRqJuEqsSKHegUuCmQwZyjqNMFye
         8JhKlZZSaiHcWhBnbDe0Yig7qe6mLVT/sOYp23OjVxo4Oq0Dl5AjG7sAl+weQaDjYkC/
         FHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798180; x=1783402980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l60qb829+b056CbQNBxrBvUbd99a3Y5SxJc1xaAoFIk=;
        b=VIgHW0LYHfYPqwnt90HAnjMiXj97ciYwugKK0FflpPeR8eMqD+JBgfTrwl8XbW3tiy
         /uIr/TG4MWXP1OP3WpXRXfFgG5cOFJPmA53hJW5xoa4+iIsaWDK2V/rwGX/TkF0lDw2W
         iKB9VvSUHbdrdmzFDYXMsTv6cLt4xU73LISN2lvE3d5WSzmj2XBtnc5kG8348QimQGs9
         cdRUxUoGj410B6AQqeJ2RPnzpQjsCxohMaNIZr7Wp2LMNP93+0miFISnDFwsp3TvVSn7
         5v21qbxHlHvVPyodwZRjGYxtwbm4nMu1MQ+1FoOrXHXrmIUqkApCT0uOKzCcb6ap0Gy5
         TBMQ==
X-Gm-Message-State: AOJu0YzHX625buPRiXVAFqN9zfTJ/j5vgsgc5xh4omCLywSSbEGLq9ml
	Zdp1SkH4Yo0qcoQMFwE7VmVX8sew0p1SQqDCm/bCbBmQMKsD+tEvNj9o
X-Gm-Gg: AfdE7clxUxJ/WuuAJifp77IGf1HFGAJR00jHDjjHcJ/1JHdae5GFG8meFMXIXiYJO4w
	p/5T9dvhnSOToXLmtKupSerC4vvjlNL9sVn4gknmHYu4btrtmSAje8Fv/Sjrc4SKsySwFRnVGaS
	hJr3mIu6g/eehfK8yvNCHvM5/m6RFjMY8wmIPaed0NBD9FhJvDpfzsxpRqv1s0N0HhR4wfvjOZO
	/sSMt/5qfMr1CvgD+eVyNmkKJXQITBcipv4OKCh1L2IPIAircsJETxqqrgPDNjuhJGGqiMkftI6
	GQ/qqHV/StUQseDGTtmtnYNjLM9+F5cH9oF/Zymg/rq4ptipncAQRmglueWWItnbe8AHWDPMxZA
	3D/KUDTqTg/87PrYpV25Uzi+dqzvjOfwLqop/cz/mTrSOH9Uwl2LnhBOsHh8E7FBAdldslbByEq
	ihhTAnuZ0IfM4dWO3opw2W5aG9LjQvFm1nFbU=
X-Received: by 2002:a05:600c:1f8f:b0:493:a5d4:3798 with SMTP id 5b1f17b1804b1-493b827f5ffmr33416535e9.1.1782798180072;
        Mon, 29 Jun 2026 22:43:00 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47563d194bbsm4025453f8f.3.2026.06.29.22.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 22:42:59 -0700 (PDT)
Message-ID: <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
Date: Tue, 30 Jun 2026 08:42:57 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <andreas@kemnade.info>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,
With this version of the patch I see:

[  102.760894] DSI: omapdss DSI error: Framedone not received for 250ms!
[  303.860321] DSI: omapdss DSI error: Framedone not received for 250ms!
[  307.071624] DSI: omapdss DSI error: Framedone not received for 250ms!
[  307.360626] DSI: omapdss DSI error: Framedone not received for 250ms!
[  307.671142] DSI: omapdss DSI error: Framedone not received for 250ms!
[  308.660339] DSI: omapdss DSI error: Framedone not received for 250ms!
[  308.961059] DSI: omapdss DSI error: Framedone not received for 250ms!
[  313.191314] DSI: omapdss DSI error: Framedone not received for 250ms!
[  313.700378] DSI: omapdss DSI error: Failed to set dsi_if_enable to 0
[  313.980346] DSI: omapdss DSI error: Framedone not received for 250ms!
[  314.791564] DSI: omapdss DSI error: Framedone not received for 250ms!
[  315.090362] DSI: omapdss DSI error: Framedone not received for 250ms!
[  322.850952] DSI: omapdss DSI error: Framedone not received for 250ms!
[  323.111175] DSI: omapdss DSI error: Framedone not received for 250ms!

while scrolling the (hildon)desktop on droid4, so I would say the change 
broke command mode.

Regards,
Ivo

On 29.06.26 г. 18:50 ч., Andreas Kemnade wrote:
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
> In Command-Mode update, there was a nop sent, apparently the most
> relevant part was the bta sync to actually force low power mode.
> 
> Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
> 
> Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v4:
> - wait on completition on all packets (was limited to long packets only,
>    because I had the wrong impression that there is no confirmation on
>    these)
> - Link to v3: https://patch.msgid.link/20260628-vm-upstr-v3-1-9e9add93378b@kemnade.info
> 
> Changes in v3:
> 
> - Link to v2: https://patch.msgid.link/20260529-vm-upstr-v2-1-24c30671719f@kernel.org
> - fix things mentioned by claude here:
>    https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch1-20260529-vm-upstr-v2-1-24c30671719f@kernel.org/
>    - fix typos
>    - register ISR before sending packet
>    - check for RX_FIFO_NOT_EMPTY also in for short packets
> 
> Changes in v2:
> - fix commandmode update, need bta sync there
> - do not wait on short packets
> - Link to v1: https://patch.msgid.link/20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org
> 
> To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 53 ++++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27fe7bca9e2c..3f22929c36e2 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2194,28 +2194,38 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
>   static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>   			       const struct mipi_dsi_msg *msg)
>   {
> +	DECLARE_COMPLETION_ONSTACK(completion);
>   	struct dsi_data *dsi = to_dsi_data(dssdev);
>   	int r;
>   
> +	/* wait for IRQ for packet transmission confirmation */
> +	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> +				&completion, DSI_VC_IRQ_PACKET_SENT);
> +	if (r)
> +		return r;
> +
>   	if (mipi_dsi_packet_format_is_short(msg->type))
>   		r = dsi_vc_send_short(dsi, vc, msg);
>   	else
>   		r = dsi_vc_send_long(dsi, vc, msg);
>   
> -	if (r < 0)
> +	if ((!r) && wait_for_completion_timeout(&completion,
> +				msecs_to_jiffies(500)) == 0)
> +		r = -EIO;
> +
> +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> +			      &completion, DSI_VC_IRQ_PACKET_SENT);
> +	if (r)
>   		return r;
>   
> -	/*
> -	 * TODO: we do not always have to do the BTA sync, for example
> -	 * we can improve performance by setting the update window
> -	 * information without sending BTA sync between the commands.
> -	 * In that case we can return early.
> -	 */
> +	/* TODO: find out if more needs to be done for MIPI_DSI_MSG_REQ_ACK */
>   
> -	r = dsi_vc_send_bta_sync(dssdev, vc);
> -	if (r) {
> -		DSSERR("bta sync failed\n");
> -		return r;
> +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
> +		r = dsi_vc_send_bta_sync(dssdev, vc);
> +		if (r) {
> +			DSSERR("bta sync failed\n");
> +			return r;
> +		}
>   	}
>   
>   	/* RX_FIFO_NOT_EMPTY */
> @@ -3233,21 +3243,6 @@ static int _dsi_update(struct dsi_data *dsi)
>   	return 0;
>   }
>   
> -static int _dsi_send_nop(struct dsi_data *dsi, int vc, int channel)
> -{
> -	const u8 payload[] = { MIPI_DCS_NOP };
> -	const struct mipi_dsi_msg msg = {
> -		.channel = channel,
> -		.type = MIPI_DSI_DCS_SHORT_WRITE,
> -		.tx_len = 1,
> -		.tx_buf = payload,
> -	};
> -
> -	WARN_ON(!dsi_bus_is_locked(dsi));
> -
> -	return _omap_dsi_host_transfer(dsi, vc, &msg);
> -}
> -
>   static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>   {
>   	struct dsi_data *dsi = to_dsi_data(dssdev);
> @@ -3268,13 +3263,13 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>   	DSSDBG("dsi_update_channel: %d", vc);
>   
>   	/*
> -	 * Send NOP between the frames. If we don't send something here, the
> +	 * Transition to LP here. If we don't send something here, the
>   	 * updates stop working. This is probably related to DSI spec stating
>   	 * that the DSI host should transition to LP at least once per frame.
>   	 */
> -	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
> +	r = dsi_vc_send_bta_sync(dssdev, vc);
>   	if (r < 0) {
> -		DSSWARN("failed to send nop between frames: %d\n", r);
> +		DSSWARN("failed to send bta sync between frames: %d\n", r);
>   		goto err;
>   	}
>   
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260528-vm-upstr-c8e7634ebf56
> 
> Best regards,
> --
> Andreas Kemnade <andreas@kemnade.info>
> 
