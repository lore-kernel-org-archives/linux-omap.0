From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Mon, 17 Mar 2014 16:22:08 +0200
Message-ID: <53270510.1030301@compulab.co.il>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <532037E0.1080309@ti.com> <53258DDA.50005@compulab.co.il> <532692A7.7000509@ti.com> <5326F71C.1060602@compulab.co.il> <5326F893.3080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52559 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932692AbaCQOWi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Mar 2014 10:22:38 -0400
In-Reply-To: <5326F893.3080607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomi,

Unfortunately, I have a lack of experience with DT DSS stuff.

How should I define the endpoints and the connector in my case?
Please, could you provide some reference.

Regarding omapfb, is it sufficient to turn it on in the Kernel config?

Thanks,

Dmitry

On 03/17/2014 03:28 PM, Tomi Valkeinen wrote:
> On 17/03/14 15:22, Dmitry Lifshitz wrote:
>> Hi Tomi,
>>
>> Thank you for the feedback.
>>
>> We have OMAP5 based board with no ESD & Level Translator chip.
>> So, I made a quick hack in tpd12s015 driver to skip using un-relevant
>> GPIOs.
> If you don't have tpd12s015 on your board, don't modify it. Remove it
> from your board's dts file totally.
>
>> I've copied DSS DT structure from uEmv board *.dts.
>> However the HDMI output is not activate yet.
>>
>> Here is some debug output:
>>
>> root@cm-debian:~# dmesg | grep -i dss
>> [    0.040554] omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>> [    0.043135] omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>> [    0.045725] omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>> [    0.048311] omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>> [    0.050888] omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
>> [    0.325392] DSS: set fck to 192000000
>> [    0.325400] DSS: dss_runtime_get
>> [    0.325427] DSS: dss_restore_context
>> [    0.325445] OMAP DSS rev 6.1
>> [    0.325450] DSS: dss_runtime_put
>> [    0.325456] DSS: dss_save_context
>> [    0.325461] DSS: context saved
>> [    0.325707] DSS: dss_restore_context
>> [    0.325711] DSS: context restored
>> [    0.325746] omapdss_dispc 58001000.dispc: OMAP DISPC rev 5.1
>> [    0.325838] DSS: dss_save_context
>> [    0.325843] DSS: context saved
>>
>>
>> I do not use uEvm BSP u-Boot. I'm forking from this source:
>> git://git.denx.de/u-boot-ti.git
>>
>> Perhaps I'm missing some clocks initialization?
>> What are the correct bootargs for activating HDMI video output?
> HDMI is the only output on the uevm, and if your board is similar, no
> boot args are needed. But, of course, you need omapfb or omapdrm to
> manage the display.
>
>   Tomi
>
>

