From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 00/43] ARM: TI SoC clock DT conversion
Date: Tue, 29 Oct 2013 11:19:00 -0500
Message-ID: <526FDFF4.9030806@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48689 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817Ab3J2QT2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Oct 2013 12:19:28 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/25/2013 10:56 AM, Tero Kristo wrote:
<snip>
> Testing done:
> - omap3-beagle: boot + suspend/resume (ret + off)
> - omap4-panda-es: boot + suspend/resume
> - omap5-uevm: boot
> - dra7-evm: boot
> - am335x-bone: boot
> 
> Test branches available:
> 
> tree: https://github.com/t-kristo/linux-pm.git

<snip>
> Fully functioning test branch: 3.12-rc6-dt-clks-v9
> 
^^ I tested this branch (boot testing):
Beagle-XM: http://pastebin.com/50A1qtFq (crashes + clkdm issues, dpll5
failed to transition)
Panda-ES: http://pastebin.com/dWMp7D1z (bandgap_fclk not found)
OMAP5-UEVM: http://pastebin.com/pHEx6Yzg (omap-gpmc 50000000.gpmc:
error: clk_get)
DRA7-EVM: http://pastebin.com/uYNQ6Sss
BeagleBone-Black: http://pastebin.com/biGXS2vi
AM335x-evm: http://pastebin.com/K7qwJpCb


-- 
Regards,
Nishanth Menon
