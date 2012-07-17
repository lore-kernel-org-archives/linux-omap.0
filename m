From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 07/11] usb: otg: nop: add dt support
Date: Tue, 17 Jul 2012 16:40:52 +0400
Message-ID: <50055D54.9040005@mvista.com>
References: <1342516407-16515-1-git-send-email-ajay.gupta@ti.com> <1342516407-16515-8-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37703 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab2GQMlm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 08:41:42 -0400
Received: by lbbgm6 with SMTP id gm6so573741lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 05:41:40 -0700 (PDT)
In-Reply-To: <1342516407-16515-8-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

Hello.

On 17-07-2012 13:13, Ajay Kumar Gupta wrote:

> Added device tree support for nop transceiver driver and updated the
> Documentation with device tree binding information for am33xx platform.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>   .../devicetree/bindings/usb/am33xx-usb.txt         |    3 +++
>   drivers/usb/otg/nop-usb-xceiv.c                    |   12 ++++++++++++
>   2 files changed, 15 insertions(+), 0 deletions(-)

> diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> index ca8fa56..a314720 100644
> --- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> @@ -12,3 +12,6 @@ AM33XX MUSB GLUE
>      represents PERIPHERAL.
>    - power : Should be "250". This signifies the controller can supply upto
>      500mA when operating in host mode.
> +
> +NOP USB PHY
> + - compatible : Should be "ti,nop-xceiv-usb"

    Why are you declaring it as TI specific. There's nothing company specific 
in the NOP transceiver.

WBR, Sergei
