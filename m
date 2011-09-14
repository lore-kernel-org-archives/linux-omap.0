From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 6/6] OMAP2+: id: remove OMAP_REVBITS_* macros
Date: Wed, 14 Sep 2011 16:30:06 +0300
Message-ID: <4E70AC5E.8050300@compulab.co.il>
References: <20110913212638.26161.62284.stgit@dusk> <20110913212806.26161.37867.stgit@dusk> <4E709D13.1080908@compulab.co.il> <alpine.DEB.2.00.1109140628520.27954@utopia.booyaka.com> <4E70A337.6090400@compulab.co.il> <alpine.DEB.2.00.1109140708590.27954@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:44861
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932610Ab1INNaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 09:30:16 -0400
In-Reply-To: <alpine.DEB.2.00.1109140708590.27954@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, premi@ti.com, linux-arm-kernel@lists.infradead.org

On 09/14/11 16:10, Paul Walmsley wrote:
> Hi Igor,
> 
> Could you try this patch on top of the ones that you are testing?

After applying the patch to your id_3517_cleanup_3.2 branch:
--------------cut-------------------
[    0.000000] Linux version 3.1.0-rc4-00014-gbe89163 (grinberg@grinberg-linux) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #2 SMP Wed Sep 14 16:21:47 IDT 2011
[    0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: Compulab CM-T3517
[    0.000000] Reserving 8388608 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM3517 ES1.0 (l2cache iva sgx neon isp )
-------------cut--------------------

The SoC is really AM3517. I have no AM3505 available right now, sorry...

Feel free to add:

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

> 
> thanks for the testing help,

No problem ;)


-- 
Regards,
Igor.
