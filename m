From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix MMC gpio_wp for BeagleBoard C2 and above
Date: Fri, 18 Sep 2009 13:22:50 +0300
Message-ID: <20090918132250.c4382f67.jhnikula@gmail.com>
References: <1253266372-23943-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:45583 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbZIRKWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 06:22:34 -0400
Received: by ewy2 with SMTP id 2so1179933ewy.17
        for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2009 03:22:37 -0700 (PDT)
In-Reply-To: <1253266372-23943-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Fri, 18 Sep 2009 12:32:52 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Earlier BeagleBoards were using pad AH8 muxed to GPIO29 for MMC write-protect.
> However, this signal has been changed to pad AG9 in board revision C2.
> 
> Fix this by adding mux configuration for pad AG9, runtime check for board
> revisions and set the gpio number and pad muxing accordingly.
> 
...
> +MUX_CFG_34XX("AH8_34XX_GPIO23", 0x5ee,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
>  MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)

Stupid copy-paste error here. Will print the wrong pad. I'll resend
in a minute.


-- 
Jarkko
