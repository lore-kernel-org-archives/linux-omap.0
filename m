From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: gpio Interrupt handling for omap5912
Date: Mon, 31 Jul 2006 11:22:50 +0200
Message-ID: <44CDCBEA.3040703@gmail.com>
References: <20060731085200.16004.qmail@web55810.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060731085200.16004.qmail@web55810.mail.re3.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnold <abo_gwapo@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Arnold wrote:
> Anybody knows what interrupt number a gpio on omap5912
> uses?

AFAIK interrupt numbers for GPIO start with 160 and then are 
numbered starting with first GPIO bank and so on.

See include/asm-arm/arch-omap/irqs.h:

#define IH2_BASE           32

/* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
#define OMAP_MAX_GPIO_LINES     192
#define IH_GPIO_BASE            (128 + IH2_BASE)
#define IH_MPUIO_BASE           (OMAP_MAX_GPIO_LINES + 
IH_GPIO_BASE)
#define IH_BOARD_BASE           (16 + IH_MPUIO_BASE)

Have a look to GPIO framework in gpio.c and its usage in 
various files which can help you programming GPIO stuff.

Cheers

Dirk
