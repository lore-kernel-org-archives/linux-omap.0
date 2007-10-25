From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] include/asm-arm/arch-omap/omap24xx.h
Date: Thu, 25 Oct 2007 10:00:59 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0710250955270.25986@utopia.booyaka.com>
References: <ae36f8040710240958l579ad5el16f17cb073e25387@mail.gmail.com>   
	<471F868A.3060106@googlemail.com> <20071025053143.222542615@pwsan.com>
	<4720B62A.1010406@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4720B62A.1010406@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Dirk,

On Thu, 25 Oct 2007, Dirk Behme wrote:

> Mmh, I like to fix it in include/asm-arm/arch-omap/omap24xx.h, so I prefer 
> [1].
>
> With [1] we
>
> - fix it where it was introduced
> - have an additional #ifdef only in a header file instead of 
> plat-omap/devices.c, which is IMHO better
> - fix it for everybody now and in the future who directly or indirectly 
> includes omap24xx.h.

Hopefully this is just a workaround until we can get rid of these 
conditional defines for multiboot kernels.  Generally speaking, would you 
propose doing the same thing for the other conditional defines in 
include/asm-arm/arch-omap/omap24xx.h, such as OMAP2_32KSYNCT_BASE, 
OMAP2_SDRC_BASE, etc.?


- Paul
