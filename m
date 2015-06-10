From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/5] usb: dwc3: ep0: Add chained TRB support
Date: Wed, 10 Jun 2015 21:11:14 +0300
Message-ID: <55787DC2.7030703@cogentembedded.com>
References: <1433927932-32395-1-git-send-email-kishon@ti.com> <1433927932-32395-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33432 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbbFJSLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2015 14:11:18 -0400
Received: by labpy14 with SMTP id py14so38830762lab.0
        for <linux-omap@vger.kernel.org>; Wed, 10 Jun 2015 11:11:17 -0700 (PDT)
In-Reply-To: <1433927932-32395-5-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, gregkh@linuxfoundation.org

Hello.

On 06/10/2015 12:18 PM, Kishon Vijay Abraham I wrote:

> Add chained TRB support to ep0. Now TRB's can be chained just by
> invoking _dwc3_ep0_start_trans_ with 'chain' parameter set to true.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/usb/dwc3/ep0.c    |   16 +++++++++++++---
>   drivers/usb/dwc3/gadget.c |    2 +-
>   2 files changed, 14 insertions(+), 4 deletions(-)

> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index d1a2be1..6847afe 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
[...]
> @@ -78,10 +81,17 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
>   	trb->ctrl = type;
>
>   	trb->ctrl |= (DWC3_TRB_CTRL_HWO
> -			| DWC3_TRB_CTRL_LST
> -			| DWC3_TRB_CTRL_IOC
>   			| DWC3_TRB_CTRL_ISP_IMI);
>
> +	if (chain)
> +		trb->ctrl |= DWC3_TRB_CTRL_CHN;
> +	else
> +		trb->ctrl |= (DWC3_TRB_CTRL_IOC
> +				| DWC3_TRB_CTRL_LST);

    Parens not needed here (and above too).

[...]

WBR, Sergei

