From: Nishanth Menon <nm@ti.com>
Subject: Re: debugfs pinctrl crash on beagle-xm
Date: Fri, 13 Dec 2013 11:10:20 -0600
Message-ID: <52AB3F7C.9050201@ti.com>
References: <52A6EFE5.2040706@ti.com> <52AA4894.4040901@ti.com> <20131213170438.GA28184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42680 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579Ab3LMRKY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 12:10:24 -0500
In-Reply-To: <20131213170438.GA28184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 12/13/2013 11:04 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [131212 15:38]:
>> On 12/10/2013 04:41 AM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On beagle-xm, v3.13-rc3, I see the following crash if I use the pinctrl
>>> debugfs:
>>>
>>> # cat /debug/pinctrl/48002030.pinmux/pins
>>> [   16.464233] Unhandled fault: external abort on non-linefetch (0x1028)
>>> at 0xfa002268
>>
>> in 3630 TRM, There is a hole in the memory map between
>> 0x48002264(CONTROL_PADCONF_SDRC_CKE1) and
>> 0x480025A0(CONTROL_PADCONF_SDRC_BA0) which obviously generates abort
>> when read at 0x48002268
>>
>> on 3430, we should also see a crash in the hole region
>> 0x48002264(CONTROL_PADCONF_SDRC_CKE1) to
>> 0x480025D8(CONTROL_PADCONF_ETK_CLK).
>>
>> in dts, omap3_pmx_core: pinmux@48002030 describes the range as reg =
>> <0x48002030 0x05cc> (which is the max range for the module)
>>
>> wish pinctrl-single driver could support handle multiple address ranges?
>>
>> [...]
> 
> There's an RFC patch from Laurent to split the pmx_core into two instances
> that should take care of this issue:
> 
> [PATCH/RFC] ARM: omap3: Split the pinmux core device


Arggh.. yet again, I missed that :( grr...
https://patchwork.kernel.org/patch/3335341/ follows the similar
direction Laurent took for https://patchwork.kernel.org/patch/3283781/


-- 
Regards,
Nishanth Menon
