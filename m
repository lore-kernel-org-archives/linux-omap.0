Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012B47141F;
	Wed, 29 Jul 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323752; cv=none; b=GiqzN5KGqDd8q8C02D2+VO6PM/poSqmCx7N6DQRv7xmBZ2CnP6hC7HgoHIc/o9K5FM+BGsNr2eI/9ErMPBw67rga2eEaSjthw1Hm2DVDUVf2s4DUtYkX6Wk4UvSgyr9RgY5I7n0OT4mkBiA7S9t8Txhl0FMnqKQRdi3wsynvZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323752; c=relaxed/simple;
	bh=gUuCfUtOb85tDdPzGoRIzPIcJj5GwVQkb8T2n6kQVN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AM9knKjTXtJ85cvTtDSATb7ohIB7Ub9AcURamEgmG/7GFNLABl0Wvy3wYKDo/OkcsZfyAfWa7oRmGsbQWVV2CQZge7NH6+iM2zY4qLp6ptRqW3R+6qbZVq38WBRxJXX+calUp/a8A/r6qPBb9ZD7SjNRMjezRImX+iXvXvDaTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UaKHHXN7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UaKHHXN7"
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A2F419C;
	Wed, 29 Jul 2026 13:14:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1785323672;
	bh=gUuCfUtOb85tDdPzGoRIzPIcJj5GwVQkb8T2n6kQVN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UaKHHXN7cE5QGzdupJ0rdab4haVGTOnnbDYV7w4gVY39ViQEUwUKuyO3tIk2YoORr
	 gIkQQfWj/552Pm70wBLAyhouc96sE3mNo6pJs5YSwqsd9vo6aIlSO9n65NjlkngE4l
	 JLyIctzKKDOyKYqMAS6eoYhFwCjSovWQU+yOUJCs=
Message-ID: <39434782-9909-4bb4-b3da-a507acfc5e3d@ideasonboard.com>
Date: Wed, 29 Jul 2026 14:15:33 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
 hns@goldelico.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
References: <20260725165909.508612-1-andreas@kemnade.info>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260725165909.508612-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 25/07/2026 19:59, Andreas Kemnade wrote:
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
> Changes in v5:
> - send bta sync on VC_CMD again
> 
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
> ---
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 53 ++++++++++++++-----------------
>   1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27fe7bca9e2cf..eb3cd0d23cae3 100644
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

The dsi_vc_send_bta_sync() function does dsi_get_errors(), which we now 
don't always do here. I think that might cause any errors to be left 
there, which would trigger error handling on next read or write-with-bta.

_omap_dsi_host_transfer forward declaration can now be remove.

I don't have HW to test this, but other than the above, it looks 
reasonable. Although I have to say, based on my past experience, it's 
also very easy to break a use case =).

  Tomi

