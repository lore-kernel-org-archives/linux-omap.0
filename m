From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v3 2/4] ARM: dts: am437x-gp-evm: add support for
 parallel NAND flash
Date: Wed, 7 May 2014 19:19:33 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACB432@DBDE04.ent.ti.com>
References: <1398152020-19391-1-git-send-email-pekon@ti.com>
 <1398152020-19391-3-git-send-email-pekon@ti.com>
 <20140506153956.GE18474@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38697 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaEGTTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 15:19:40 -0400
In-Reply-To: <20140506153956.GE18474@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>

>From: Tony Lindgren [mailto:tony@atomide.com]
>>* Pekon Gupta <pekon@ti.com> [140422 00:34]:
>> +&gpmc {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&nand_flash_x8>;
>> +	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
>
>Please use the minimum size 16MB GPMC range here, NAND only
>has few registers addressable unlike NOR that actually uses the
>whole range.
>
>> +	nand@0,0 {
>> +		reg = <0 0 0>; /* CS0, offset 0 */
>
>Then here map the true size of the NAND device IO register area.
>
>BTW, we should do the similar changes to other files so we can
>unify the GPMC partitioning a bit. But that's unsafe to do until
>we have fixed the issue of mapping GPMC devices to a different
>location from the bootloader location.
>
I have found the fix of this issue in gpmc_cs_remap() just testing it
using beaglebone NOR cape. I'll post that separately, once I'm confident.

But for now, I'll re-send just these patches for NAND DT node with
your feedbacks incorporated, so that NAND is stable on these
platforms / boards from 3.16 onwards.

with regards, pekon
