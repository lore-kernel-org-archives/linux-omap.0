From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v5 5/6] usb: musb: dsps: Add the sw_babble_control()
Date: Thu, 22 May 2014 15:39:58 +0400
Message-ID: <537DE20E.9050706@cogentembedded.com>
References: <1400740181-31213-1-git-send-email-george.cherian@ti.com> <1400740181-31213-6-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:64423 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbaEVLjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 07:39:55 -0400
Received: by mail-la0-f45.google.com with SMTP id gl10so2564037lab.32
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2014 04:39:54 -0700 (PDT)
In-Reply-To: <1400740181-31213-6-git-send-email-george.cherian@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, zonque@gmail.com, b-liu@ti.com

On 22-05-2014 10:29, George Cherian wrote:

> Add sw_babble_control() logic to differentiate between transient
> babble and real babble condition. Also add the SW babble control
> register definitions.

> Babble control register logic is implemented in the latest
> revision of AM335x.

> Signed-off-by: George Cherian <george.cherian@ti.com>
> ---
>   drivers/usb/musb/musb_dsps.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
>   drivers/usb/musb/musb_regs.h |  7 +++++++
>   2 files changed, 57 insertions(+)

> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index f6f3087..868caf8 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -536,6 +536,56 @@ static int dsps_musb_set_mode(struct musb *musb, u8 mode)
>   	return 0;
>   }
>
> +static int sw_babble_control(struct musb *musb)
> +{

    Doesn't gcc complain on this function being unused? I think you should 
have added this function along with the caller, not separately.

WBR, Sergei

