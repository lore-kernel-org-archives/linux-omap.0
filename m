From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v6 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Fri, 16 May 2014 08:57:36 -0300
Message-ID: <20140516115736.GA684@arch.cereza>
References: <1400238230-26357-1-git-send-email-pekon@ti.com>
 <1400238230-26357-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35337 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbaEPL6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 07:58:12 -0400
Received: by mail-yk0-f180.google.com with SMTP id q9so1998376ykb.39
        for <linux-omap@vger.kernel.org>; Fri, 16 May 2014 04:58:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400238230-26357-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hello Pekon,

On 16 May 04:33 PM, Pekon Gupta wrote:
[..]
> +		gpmc,wait-pin = <0>;
> +		gpmc,wait-on-read;
> +		gpmc,wait-on-write;

Thanks for adding the wait-pin property. I think the other boards also
needs this change. Javier, do you have a IGEP Aquila with NAND to try?

Pekon, have you noticed that there's no devicetree property to enable
ready/busy? In other words, the NAND driver dev_ready field will never
be true when probed from DT.

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
