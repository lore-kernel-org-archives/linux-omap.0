From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/17] MMC: OMAP: Add MMC multislot support
Date: Wed, 28 Nov 2007 10:05:31 -0800
Message-ID: <20071128180531.GM11825@atomide.com>
References: <474AEDBB.1070006@indt.org.br> <20071128020300.GB11825@atomide.com>
	<9c9fda240711280006q209acc15r2de7cf5813385e1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9c9fda240711280006q209acc15r2de7cf5813385e1a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Kyungmin Park <kmpark@infradead.org> [071128 00:07]:
> Hi,
> 
> After multislot patches committed, I created the apollon mmc file.
> It probes the mmc slot and find partitions.
> 
> It seems to be working. but after some operations it stops. Actually
> it wait the interrupt.
> 
> I disabled a lot of options, wire4, high speed, max frequency. but it's same.
> 
> / # cat /proc/interrupts
>            CPU0
>  12:        493        INTC  DMA
>  37:       1580        INTC  gp timer
>  72:        783        INTC  serial
>  83:        101        INTC  mmci-omap
> 176:          0        GPIO  enter sw
> 177:          0        GPIO  up sw
> 218:          0        GPIO  down sw
> 234:       6057        GPIO  eth0
> Err:          0
> / # vmstat 1
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  0  1      0 107296  12220   2268    0    0     0    29   22    11  0  0 93  6
>  0  1      0 107296  12220   2268    0    0     0     0   48    26  0  1  0 99
>  0  1      0 107296  12220   2268    0    0     0     0   40    26  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   35    30  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   40    32  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   33    24  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   39    28  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   43    27  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   42    25  0  1  0 99
>  0  1      0 107296  12220   2268    0    0     0     0   35    29  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   35    27  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   29    22  0  1  0 99
>  0  1      0 107296  12220   2268    0    0     0     0   40    29  0  0  0 100
>  0  1      0 107296  12220   2268    0    0     0     0   38    26  0  0  0 100
> 
> / # cat /proc/interrupts
>            CPU0
>  12:        493        INTC  DMA
>  37:       2148        INTC  gp timer
>  72:        888        INTC  serial
>  83:        101        INTC  mmci-omap
> 176:          0        GPIO  enter sw
> 177:          0        GPIO  up sw
> 218:          0        GPIO  down sw
> 234:       6342        GPIO  eth0
> Err:          0
> 
> Are there any clues?

Where does it get stuck? If you enable CONFIG_MMC_DEBUG you may get a
clue if it's always the same command that gets it stuck.

There may also be some unmerged patches in the Nokia n8x0 sources,
at least the omap.c should be diffable against those now.

Tony
