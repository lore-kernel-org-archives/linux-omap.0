From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/17] MMC: OMAP: Add MMC multislot support
Date: Tue, 27 Nov 2007 18:03:00 -0800
Message-ID: <20071128020300.GB11825@atomide.com>
References: <474AEDBB.1070006@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <474AEDBB.1070006@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Carlos Aguiar <carlos.aguiar@indt.org.br> [071126 08:03]:
> Hi Tony and folks,
> 
> This is the latest 'MMC: OMAP: Add MMC multislot support' patch series
> with changes, corrections and improvements based on recent comments and
> suggestions from community and coworkers.
> 
> Just to remind you, this patch series adds the MMC multislot support for
> N800 and TI OMAP H2 and H3 boards, and Siemens SX1. It's based on Juha's and Jarkko's
> earlier implementation and it can be applied against most updated
> linux-omap tree (2.6.24-rc3-omap1, on top of commit 3e1251dd443d07f5a5298646adf746e4add89cf3).
>
> After recent merging of linux omap tree with linus tree, such support was broken for N800.
> After investigating it, I realize the source of the problem comes from DMA, from a line of 
> Anand Gadiyar' earlier patch committed [1].
>
> In order this support work properly on N800, please apply the patch I proposed at [2].

Thanks, pushed your DMA fix.

> I've tested with MMC, SD and SDHC cards and looks fine for the boards
> mentioned above (SX1 is compiled test only).
> 
> Testing, comments and suggestions are welcome.

Well, I've pushed most of your patches. I ended up splitting your
patch 02/17 into something that's easier to read and also compiles.
Basically I temporarily removed all the cover switch handling and
fixed the header.

I did not push patches 15-17 as the power up should be done the same
way as for other boards. Can you please refresh those patches?

Regards,

Tony
