From: Nishanth Menon <nm@ti.com>
Subject: next-20150511 / omap2-mcspi: regression for sdp4430 boot
Date: Mon, 11 May 2015 11:50:19 -0500
Message-ID: <5550DDCB.8010303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40055 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbbEKQuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 12:50:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Michael Welling <mwelling@ieee.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-spi@vger.kernel.org

Hi,

SDP4430 uses a SPI based network chip ks8851.

next-20150508:
https://github.com/nmenon/kernel-test-logs/blob/next-20150508/omap2plus_defconfig/sdp4430.txt

However, next-20150511:
https://github.com/nmenon/kernel-test-logs/blob/next-20150511/omap2plus_defconfig/sdp4430.txt

Generates infinite "ks8851 spi1.0: ks8851_irq: spi bus error" errors
and hangs the platform.

Bisected the issue down to the following two commits when reverted
allows the board to function:


commit b28cb9414db9f8e42ac18c9e360e4e99cda42489
Author: Michael Welling <mwelling@ieee.org>
Date:   Thu May 7 18:36:53 2015 -0500

    spi: omap2-mcspi: Switch driver to use transfer_one

    Switches from transfer_one_message to transfer_one to prepare
driver for
    use of GPIO chip selects.

    Signed-off-by: Michael Welling <mwelling@ieee.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>

Reverting this alone: http://paste.ubuntu.org.cn/2594735 (did not boot up)

commit bc7f9bbc80bcc77745b3f54ec4e7103e3e142bb9
Author: Michael Welling <mwelling@ieee.org>
Date:   Fri May 8 13:31:01 2015 -0500

    spi: omap2-mcspi: Add gpio_request and init CS

    If GPIO chip select is specified, request the GPIO in the setup
function
    and release it in the cleanup function.

    Signed-off-by: Michael Welling <mwelling@ieee.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>

Reverting this as well allowed boot.

-- 
Regards,
Nishanth Menon
