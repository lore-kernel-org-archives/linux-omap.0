From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/5] usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API
 to take 'chain' parameter
Date: Wed, 10 Jun 2015 21:12:52 +0300
Message-ID: <55787E24.7030608@cogentembedded.com>
References: <1433927932-32395-1-git-send-email-kishon@ti.com> <1433927932-32395-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34980 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934072AbbFJSM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2015 14:12:56 -0400
Received: by lbbtu8 with SMTP id tu8so33707322lbb.2
        for <linux-omap@vger.kernel.org>; Wed, 10 Jun 2015 11:12:54 -0700 (PDT)
In-Reply-To: <1433927932-32395-4-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, gregkh@linuxfoundation.org

Hello.

On 06/10/2015 12:18 PM, Kishon Vijay Abraham I wrote:

> No functional change. Added a new parameter in _dwc3_ep0_start_trans_ to
> indicate whether the TRB is a chained TRB or last TRB. This is in
> preparation for adding chained TRB support for ep0.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/usb/dwc3/ep0.c |   15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)

> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 4998074..d1a2be1 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -56,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
>   }
>
>   static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
> -		u32 len, u32 type)
> +		u32 len, u32 type, unsigned chain)

    Why not *bool*? You're passing boolean values anyway...

[...]

WBR, Sergei

