From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Tue, 19 Aug 2014 00:50:59 +0200
Message-ID: <CABxcv=npv6bRq=VF8RT5trNxUzDj3bAm-PkvDEhcLVJ+uf8hCg@mail.gmail.com>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
	<1408202315-20006-6-git-send-email-mpa@pengutronix.de>
	<53F244DA.3070803@ti.com>
	<20140818154112.6601cbff@gandalf.local.home>
	<53F25AD1.8040504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:51503 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbaHRWvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2014 18:51:00 -0400
Received: by mail-we0-f177.google.com with SMTP id w62so5685590wes.36
        for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2014 15:50:59 -0700 (PDT)
In-Reply-To: <53F25AD1.8040504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Markus Pargmann <mpa@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel@pengutronix.de

Hello Mugunthan,

On Mon, Aug 18, 2014 at 9:58 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
>>
>> Thus, for this patchset, as is:
>>
>> Tested-by: Steven Rostedt <rostedt@goodmis.org>
>
> This will fail for DRA7xx not in AM33xx
>

cpsw_am33xx_cm_get_macid() checks for
of_machine_is_compatible("ti,am33xx") and returns 0 if the machine is
not an am33xx. cpsw_probe_dt() only propagates the return value if is
not 0 so this patch does not change the semantics for other SoCs
besides am33xx.

If the driver already fails for DRA7xx that certainly is not this
patch's fault. Of course it would be nice to add support for DRA7xx as
well but I think that could be a follow-up patch and shouldn't be a
blocker to merge this change if is useful for users.

> Regards
> Mugunthan V N
> --

Best regards,
Javier
