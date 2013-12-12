From: Nishanth Menon <nm@ti.com>
Subject: Re: debugfs pinctrl crash on beagle-xm
Date: Thu, 12 Dec 2013 17:36:52 -0600
Message-ID: <52AA4894.4040901@ti.com>
References: <52A6EFE5.2040706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33898 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab3LLXgx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 18:36:53 -0500
In-Reply-To: <52A6EFE5.2040706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 12/10/2013 04:41 AM, Tomi Valkeinen wrote:
> Hi,
> 
> On beagle-xm, v3.13-rc3, I see the following crash if I use the pinctrl
> debugfs:
> 
> # cat /debug/pinctrl/48002030.pinmux/pins
> [   16.464233] Unhandled fault: external abort on non-linefetch (0x1028)
> at 0xfa002268

in 3630 TRM, There is a hole in the memory map between
0x48002264(CONTROL_PADCONF_SDRC_CKE1) and
0x480025A0(CONTROL_PADCONF_SDRC_BA0) which obviously generates abort
when read at 0x48002268

on 3430, we should also see a crash in the hole region
0x48002264(CONTROL_PADCONF_SDRC_CKE1) to
0x480025D8(CONTROL_PADCONF_ETK_CLK).

in dts, omap3_pmx_core: pinmux@48002030 describes the range as reg =
<0x48002030 0x05cc> (which is the max range for the module)

wish pinctrl-single driver could support handle multiple address ranges?

[...]

-- 
Regards,
Nishanth Menon
