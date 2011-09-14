From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 6/6] OMAP2+: id: remove OMAP_REVBITS_* macros
Date: Wed, 14 Sep 2011 15:51:03 +0300
Message-ID: <4E70A337.6090400@compulab.co.il>
References: <20110913212638.26161.62284.stgit@dusk> <20110913212806.26161.37867.stgit@dusk> <4E709D13.1080908@compulab.co.il> <alpine.DEB.2.00.1109140628520.27954@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:40800
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932406Ab1INMvK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:51:10 -0400
In-Reply-To: <alpine.DEB.2.00.1109140628520.27954@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/14/11 15:29, Paul Walmsley wrote:
> On Wed, 14 Sep 2011, Igor Grinberg wrote:
> 
>> Hi Paul,
>>
>> Same problem (as with 3_6) here...
> 
> Thanks, I'll repost those.  In the meantime, maybe try pulling the branch 
> 'id_3517_cleanup_3.2' from git://git.pwsan.com/linux-2.6 ?

I've applied those manually on top of v3.1-rc3:

--------------cut--------------------
[    0.000000] Linux version 3.1.0-rc3-00006-ga942f6de (grinberg@grinberg-linux) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #1 SMP Wed Sep 14 15:35:32 IDT 2011
[    0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: Compulab CM-T3517
[    0.000000] Reserving 8388608 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES1.0 (l2cache iva sgx neon isp )
----------cut----------------------------
               ^^^^^^^^^^^^^^^^^^^

While U-Boot says:

------------cut---------------------
U-Boot 2009.11-cm-t3517-1 (Dec 10 2010 - 23:25:02)

AM35xx-GP ES1.0, L3-165MHz
------------cut---------------------

Do I miss something, that should be in your tree?
Pulling it in right now, should be available shortly...


-- 
Regards,
Igor.
