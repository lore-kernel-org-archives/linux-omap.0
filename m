From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [RFC/PATCH  1/4] MMC/SD Controller driver for OMAP2430
Date: Tue, 11 Dec 2007 11:22:31 +0530
Message-ID: <001d01c83bba$07e20d30$fe8818ac@ent.ti.com>
References: <20071210180006.GD19104@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071210180006.GD19104@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>, "'Syed Mohammed, Khasim'" <khasim@ti.com>
Cc: 'Pierre Ossman' <drzeus@drzeus.cx>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi,

>Do you still need to mux between slots if you have three controllers
>available? If so, it's worth doing it to start with.
I do not think that mux between slots is required in 2430 or 3430.So, I guess the usage of the multislot structure 
might not be required.

These platforms have two controllers connected to two separate slots on the SDP.The TRM of 2430 and 3430 states that 
one MMC/SD/SDIO controller can support one MMC memory card,one SD memory card, or one SDIO card.

Regards,
Madhu

-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com] 
Sent: Monday, December 10, 2007 11:30 PM
To: Syed Mohammed, Khasim
Cc: Carlos Aguiar; Chikkature Rajashekar, Madhusudhan; linux-omap@vger.kernel.org; linux-omap-open-source@linux.omap.com;
linux-arm-kernel@lists.arm.linux.org.uk; Pierre Ossman
Subject: Re: [RFC/PATCH 1/4] MMC/SD Controller driver for OMAP2430

* Syed Mohammed, Khasim <khasim@ti.com> [071208 07:50]:
> 
> 
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
> > open-source-bounces@linux.omap.com] On Behalf Of Carlos Aguiar
> > Sent: Friday, December 07, 2007 8:24 PM
> > To: Chikkature Rajashekar, Madhusudhan
> > Cc: linux-omap@vger.kernel.org; linux-omap-open-source@linux.omap.com;
> > linux-arm-kernel@lists.arm.linux.org.uk; 'Pierre Ossman'
> > Subject: Re: [RFC/PATCH 1/4] MMC/SD Controller driver for OMAP2430
> > 
> > ext Madhusudhan Chikkature Rajashekar wrote:
> > > This patch adds MMC controller driver for OMAP2430/3430.
> > >
> > > Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> > >
> > > ---
> > >  drivers/mmc/host/Makefile     |    9
> > >  drivers/mmc/host/omap_hsmmc.c |  985
> > ++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 993 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c
> > > ===================================================================
> 
> <snip>
> 
> > >
> > Hi Madhu,
> > 
> > I'd rather see this code using multislot structures and omap.c instead
> > of defining a whole new codebase for omap2430 and/or omap3.
> > 
> > BR,
> > 
> > Carlos.
> > 
> > 
> Hi Carlos,
> 
> Thanks for comments.
> 
> I remember we had discussed this before as well, as communicated before the MMC/SD controller on OMAP2430 and 3430 processors is
completely different( in Register width, bits, offsets, configuration etc) from OMAP2420 and OMAP1 platforms. It's not recommended
to add new MMC controller functionality to existing omap.c. 

Well, this time it actually looks like the MMC controller is
completely different.

> Yes we will definitely use multi-slot structures. We can add multi-slot support after we get formal approval of this code base.

Do you still need to mux between slots if you have three controllers
available? If so, it's worth doing it to start with.

Regards,

Tony
