From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 4/4] OMAP: DMA: Added support for DMA chaining
Date: Wed, 31 Oct 2007 10:46:15 -0700
Message-ID: <4728BF67.2020208@mvista.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804AF986A@dbde01.ent.ti.com>
	<20071031131833.GJ32547@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071031131833.GJ32547@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Gadiyar, Anand <gadiyar@ti.com> [071024 00:10]:
>> From: Anand Gadiyar <gadiyar@ti.com>
>>
>> Added support for DMA chaining.
>> This patch depends on patches [1-3]
>> "OMAP: DMA: Cleanup of DMA Request Lines",
>> "OMAP: DMA: Added support for OMAP3" and 
>> "OMAP: DMA: Added utility APIs for setting DMA global parameters".
> 

FYI... without PATCH 1/1 the new DMA stuff doesn't compile on OMAP2.
While waiting for that fix, at least this is required to build in
current git

Kevin


Index: dev/include/asm-arm/arch-omap/dma.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/dma.h
+++ dev/include/asm-arm/arch-omap/dma.h
@@ -62,6 +62,7 @@
 #define OMAP_DMA4_IRQENABLE_L2		(OMAP_DMA4_BASE + 0x20)
 #define OMAP_DMA4_IRQENABLE_L3		(OMAP_DMA4_BASE + 0x24)
 #define OMAP_DMA4_SYSSTATUS		(OMAP_DMA4_BASE + 0x28)
+#define OMAP_DMA4_OCP_SYSCONFIG		(OMAP_DMA4_BASE + 0x2c)
 #define OMAP_DMA4_CAPS_0		(OMAP_DMA4_BASE + 0x64)
 #define OMAP_DMA4_CAPS_2		(OMAP_DMA4_BASE + 0x6c)
 #define OMAP_DMA4_CAPS_3		(OMAP_DMA4_BASE + 0x70)
