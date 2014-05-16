From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v2 1/2] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Fri, 16 May 2014 19:39:51 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACDC2D@DBDE04.ent.ti.com>
References: <1395300886-383-1-git-send-email-pekon@ti.com>
 <1395300886-383-2-git-send-email-pekon@ti.com>
 <20140512160354.GA16440@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51255 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992428AbaEPTkB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 15:40:01 -0400
In-Reply-To: <20140512160354.GA16440@arch.cereza>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>

Hi Ezequiel,

Sorry for delayed replies..

>From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
>Pekon,
>
>A few questions regarding this patch, despite the fact I'm not sure it will
>ever be included.
>
>On 20 Mar 01:04 PM, Pekon Gupta wrote:	
>> +			0x70 (MUX_MODE0 | PIN_INPUT_PULLUP )	/* gpmc_wait0.gpmc_wait0 */
>> +			0x74 (MUX_MODE7 | PIN_OUTPUT_PULLUP)	/* gpmc_wpn.gpio0_30 */
>
>Is this output pin?
Yes, it's the "Write Protect (WP)" pin. And goes controller -> device.


>
>> +			0x7c (MUX_MODE0 | PIN_OUTPUT_PULLUP)	/* gpmc_csn0.gpmc_csn0  */
>
>Again: is this output pin?
>
Yes, this is "Chip-select"  and goes from controller -> device.
Though it should already have external pull-up resistor on board, to avoid
glitches due to noise, and avoid device getting confused when SoC
is not driving anything (like before pin-muxing).


>> +		gpmc,wait-on-read = "true";
>> +		gpmc,wait-on-write = "true";
>
>The devicetree binding says these wait properties are bool, so the above
>should be:
>
>		gpmc,wait-on-read;
>		gpmc,wait-on-write;
>
>But the problem is that there's no wait-pin defined, so this not enabled.
>
>Could you explain what should be the correct binding? This is very confusing
>for me.
>
I have fixed the above DT mapping in newer version of the patch [1].

Sorry, yes the wait-pin monitoring implementation is not cleanly done,
there is mix of platform_data and DT stuff. So in addition to updated DT patch
you need following patch to enable wait-pin monitoring in NAND driver.

http://www.spinics.net/lists/linux-omap/msg107253.html



with regards, pekon
