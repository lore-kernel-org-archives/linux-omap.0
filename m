From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/20] Build omap_device for each DSS HW IP
Date: Thu, 26 Aug 2010 16:33:00 -0700
Message-ID: <874oehuez7.fsf@deeprootsystems.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	<1282579089-10487-2-git-send-email-svadivu@ti.com>
	<1282579089-10487-3-git-send-email-svadivu@ti.com>
	<1282579089-10487-4-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65077 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0HZXdC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:33:02 -0400
Received: by pwi7 with SMTP id 7so916065pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:33:02 -0700 (PDT)
In-Reply-To: <1282579089-10487-4-git-send-email-svadivu@ti.com> (Guruswamy
	Senthilvadivu's message of "Mon, 23 Aug 2010 21:27:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com

Guruswamy Senthilvadivu <svadivu@ti.com> writes:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> Looks up the HWMOD database for each of the given DSS HW IP
> and builds omap_device which inturn does the platform device
> register for each of DSS HW IP
>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

[...]

> +	for (i = 0; i < 5; i++) {
> +		l = snprintf(oh_name[i], MAX_OMAP_DSS_HWMOD_NAME_LEN,
> +				 oh_name[i]);
> +		WARN(l >= MAX_OMAP_DSS_HWMOD_NAME_LEN,
> +			"String buffer overflow in DSS device setup\n");
> +
> +		oh = omap_hwmod_lookup(oh_name[i]);
> +		if (!oh) {
> +			pr_err("Could not look up %s\n", oh_name[i]);
> +			return ;
> +		}
> +		strcpy(pdata.name, oh_name[i]);
> +		pdata.board_data		=       board_data;
> +		pdata.board_data->get_last_off_on_transaction_id = NULL;
> +		pdata.device_enable    =       omap_device_enable;
> +		pdata.device_idle      =       omap_device_idle;
> +		pdata.device_shutdown  =       omap_device_shutdown;

Please use runtime PM API in driver instead of calling these using pdata
function pointers.

Kevin
