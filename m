From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/5] usb: dwc3: ep0: preparation for handling non maxpacket
 aligned transfers > 512
Date: Wed, 10 Jun 2015 21:16:49 +0300
Message-ID: <55787F11.8000709@cogentembedded.com>
References: <1433927932-32395-1-git-send-email-kishon@ti.com> <1433927932-32395-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:34595 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965035AbbFJSQx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2015 14:16:53 -0400
Received: by laew7 with SMTP id w7so38793750lae.1
        for <linux-omap@vger.kernel.org>; Wed, 10 Jun 2015 11:16:51 -0700 (PDT)
In-Reply-To: <1433927932-32395-3-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, gregkh@linuxfoundation.org

On 06/10/2015 12:18 PM, Kishon Vijay Abraham I wrote:

> No functional change. This is in preparation for handling non maxpacket
> aligned transfers greater than bounce buffer size. This is basically to
> avoid code duplication when using chained TRB transfers to handle
> non maxpacket aligned transfers greater than bounce buffer size.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/usb/dwc3/ep0.c |   25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)

> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 713e46a..4998074 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
[...]
> @@ -808,20 +812,24 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
>   	}
>
>   	ur = &r->request;
> +	buf = ur->buf;
> +	remaining_ur_length = ur->length;
>
>   	length = trb->size & DWC3_TRB_SIZE_MASK;
>
> +	maxp = ep0->endpoint.maxpacket;
> +
>   	if (dwc->ep0_bounced) {
> -		unsigned maxp = ep0->endpoint.maxpacket;
> -		unsigned transfer_size = roundup(ur->length, maxp);
> +		transfer_size = roundup((ur->length - transfer_size),
> +					maxp);

    The innermost parens shouldn't be needed (if thay are, fix the macro instead).

[...]
> @@ -941,7 +949,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>   		}
>
>   		maxpacket = dep->endpoint.maxpacket;
> -		transfer_size = roundup(req->request.length, maxpacket);
> +		transfer_size = roundup((req->request.length - transfer_size),
> +					maxpacket);

    Likewise.

[...]

WBR, Sergei

