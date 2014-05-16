From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v6 1/4] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Fri, 16 May 2014 14:06:30 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACDAA4@DBDE04.ent.ti.com>
References: <1400238230-26357-1-git-send-email-pekon@ti.com>
 <1400238230-26357-2-git-send-email-pekon@ti.com>
 <20140516115736.GA684@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57506 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756119AbaEPOGl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 10:06:41 -0400
In-Reply-To: <20140516115736.GA684@arch.cereza>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hi Ezequiel,

>From: Ezequiel Garcia [mailto:ezequiel@vanguardiasur.com.ar]
>
>Hello Pekon,
>
>On 16 May 04:33 PM, Pekon Gupta wrote:
>[..]
>> +		gpmc,wait-pin = <0>;
>> +		gpmc,wait-on-read;
>> +		gpmc,wait-on-write;
>
>Thanks for adding the wait-pin property. I think the other boards also
>needs this change. Javier, do you have a IGEP Aquila with NAND to try?
>
>Pekon, have you noticed that there's no devicetree property to enable
>ready/busy? In other words, the NAND driver dev_ready field will never
>be true when probed from DT.
>
Yes, that is know, therefore I din't reply to your earlier email.
I was just fixing your DT comments and have a small patch to set
dev_ready=true. I'll send it soon.

But still you need to consider that nand/omap2.c driver only supports
polling way of monitoring READY/BUSY pin. That is instead of polling
for status-bit | waiting for predefined delay, NAND driver now polls
for READY/BUSY pin.
However, actual benefit of wait-pin monitoring might be visible when
READY/BUSY pin is used with interrupt.


with regards, pekon
