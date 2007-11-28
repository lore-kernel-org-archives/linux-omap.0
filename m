From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: [PATCH 00/17] MMC: OMAP: Add MMC multislot support
Date: Wed, 28 Nov 2007 17:06:51 +0900
Message-ID: <9c9fda240711280006q209acc15r2de7cf5813385e1a@mail.gmail.com>
References: <474AEDBB.1070006@indt.org.br> <20071128020300.GB11825@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071128020300.GB11825@atomide.com>
Content-Disposition: inline
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
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

After multislot patches committed, I created the apollon mmc file.
It probes the mmc slot and find partitions.

It seems to be working. but after some operations it stops. Actually
it wait the interrupt.

I disabled a lot of options, wire4, high speed, max frequency. but it's same.

/ # cat /proc/interrupts
           CPU0
 12:        493        INTC  DMA
 37:       1580        INTC  gp timer
 72:        783        INTC  serial
 83:        101        INTC  mmci-omap
176:          0        GPIO  enter sw
177:          0        GPIO  up sw
218:          0        GPIO  down sw
234:       6057        GPIO  eth0
Err:          0
/ # vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1      0 107296  12220   2268    0    0     0    29   22    11  0  0 93  6
 0  1      0 107296  12220   2268    0    0     0     0   48    26  0  1  0 99
 0  1      0 107296  12220   2268    0    0     0     0   40    26  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   35    30  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   40    32  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   33    24  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   39    28  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   43    27  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   42    25  0  1  0 99
 0  1      0 107296  12220   2268    0    0     0     0   35    29  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   35    27  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   29    22  0  1  0 99
 0  1      0 107296  12220   2268    0    0     0     0   40    29  0  0  0 100
 0  1      0 107296  12220   2268    0    0     0     0   38    26  0  0  0 100

/ # cat /proc/interrupts
           CPU0
 12:        493        INTC  DMA
 37:       2148        INTC  gp timer
 72:        888        INTC  serial
 83:        101        INTC  mmci-omap
176:          0        GPIO  enter sw
177:          0        GPIO  up sw
218:          0        GPIO  down sw
234:       6342        GPIO  eth0
Err:          0

Are there any clues?

Thank you,
Kyungmin Park


On 11/28/07, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Carlos Aguiar <carlos.aguiar@indt.org.br> [071126 08:03]:
> > Hi Tony and folks,
> >
> > This is the latest 'MMC: OMAP: Add MMC multislot support' patch series
> > with changes, corrections and improvements based on recent comments and
> > suggestions from community and coworkers.
> >
> > Just to remind you, this patch series adds the MMC multislot support for
> > N800 and TI OMAP H2 and H3 boards, and Siemens SX1. It's based on Juha's and Jarkko's
> > earlier implementation and it can be applied against most updated
> > linux-omap tree (2.6.24-rc3-omap1, on top of commit 3e1251dd443d07f5a5298646adf746e4add89cf3).
> >
> > After recent merging of linux omap tree with linus tree, such support was broken for N800.
> > After investigating it, I realize the source of the problem comes from DMA, from a line of
> > Anand Gadiyar' earlier patch committed [1].
> >
> > In order this support work properly on N800, please apply the patch I proposed at [2].
>
> Thanks, pushed your DMA fix.
>
> > I've tested with MMC, SD and SDHC cards and looks fine for the boards
> > mentioned above (SX1 is compiled test only).
> >
> > Testing, comments and suggestions are welcome.
>
> Well, I've pushed most of your patches. I ended up splitting your
> patch 02/17 into something that's easier to read and also compiles.
> Basically I temporarily removed all the cover switch handling and
> fixed the header.
>
> I did not push patches 15-17 as the power up should be done the same
> way as for other boards. Can you please refresh those patches?
>
> Regards,
>
> Tony
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
