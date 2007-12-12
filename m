From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [RFC/PATCH  1/4] MMC/SD Controller driver for OMAP2430
Date: Wed, 12 Dec 2007 11:29:56 +0530
Message-ID: <001101c83c84$3c33b370$fe8818ac@ent.ti.com>
References: <c8caf88777c82890a658d7fc3beca7c0@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <c8caf88777c82890a658d7fc3beca7c0@felipebalbi.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Felipe Balbi' <me@felipebalbi.com>
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, 'Pierre Ossman' <drzeus@drzeus.cx>
List-Id: linux-omap@vger.kernel.org

 

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
> Sent: Tuesday, December 11, 2007 6:03 PM
> To: Madhusudhan Chikkature Rajashekar
> Cc: Tony Lindgren; Syed Mohammed, Khasim; Carlos Aguiar; 
> linux-omap@vger.kernel.org; 
> linux-omap-open-source@linux.omap.com; 
> linux-arm-kernel@lists.arm.linux.org.uk; Pierre Ossman
> Subject: RE: [RFC/PATCH 1/4] MMC/SD Controller driver for OMAP2430
> 
> Hi,
> 
> On Tue, 11 Dec 2007 11:22:31 +0530, "Madhusudhan Chikkature 
> Rajashekar"
> <madhu.cr@ti.com> wrote:
> > Hi,
> > 
> >>Do you still need to mux between slots if you have three controllers
> >>available? If so, it's worth doing it to start with.
> > I do not think that mux between slots is required in 2430 
> or 3430.So, I
> > guess the usage of the multislot structure
> > might not be required.
> 
> I think it is, X430sdp has only one slot per controller, but let's say
> someone puts 2 slots using only HSMMC? Then we would need to mux
> between then and multislot structures would be really helpful if they
> were already there.
I think you should also consider the point mentioned in the 2430/3430 TRM
that "one MMC/SD/SDIO controller can support one MMC memory card,one SD memory
card, or one SDIO card" before connecting an additional slot to the single controller.
As you might know, the OMAP2420 MMC controller details in the TRM clearly stated that
the host controller can support one or more MMC memory cards sharing the same bus.But
that is not the case on OMAP2430/3430.

I do not say that multi slot structures are not required at all. But they are required
only if a second slot can be connected to the single controller. So, I beleive we should 
get our first version of code pushed which can support the MMC1 controller first and then if
need comes then we can think of multi slot support.

> 
> > 
> > These platforms have two controllers connected to two 
> separate slots on
> > the SDP.The TRM of 2430 and 3430 states that
> > one MMC/SD/SDIO controller can support one MMC memory 
> card,one SD memory
> > card, or one SDIO card.
> 
> So only one slot supports HSMMC, is that right? And in this 
> case it makes
> sense creating a whole new code base for hsmmc controller on omap.
No. I guess you got it wrong.Both the controllers on OMAP2430/3430 are identical
and can support high speed MMC cards(i,e,both are HSMMC controllers). Providing support 
to the second controller should be very simple and is a matter of registering one more platform device with
correct attributes. This can be pushed subsequently once the driver for MMC1 controller 
support is pushed.

As communicated before, since the controller in 2430/3430 is quite different from the
one on 2420 or OMAP1, we have created a new file to support the same.


> 
> 
> 
> PS: try to not top post, it makes things more difficult to 
> track down. ;-)
>  
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Monday, December 10, 2007 11:30 PM
> > To: Syed Mohammed, Khasim
> > Cc: Carlos Aguiar; Chikkature Rajashekar, Madhusudhan;
> > linux-omap@vger.kernel.org; linux-omap-open-source@linux.omap.com;
> > linux-arm-kernel@lists.arm.linux.org.uk; Pierre Ossman
> > Subject: Re: [RFC/PATCH 1/4] MMC/SD Controller driver for OMAP2430
> > 
> > * Syed Mohammed, Khasim <khasim@ti.com> [071208 07:50]:
> >>
> >>
> >> > -----Original Message-----
> >> > From: linux-omap-open-source-bounces@linux.omap.com
> > [mailto:linux-omap-
> >> > open-source-bounces@linux.omap.com] On Behalf Of Carlos Aguiar
> >> > Sent: Friday, December 07, 2007 8:24 PM
> >> > To: Chikkature Rajashekar, Madhusudhan
> >> > Cc: linux-omap@vger.kernel.org; 
> linux-omap-open-source@linux.omap.com;
> >> > linux-arm-kernel@lists.arm.linux.org.uk; 'Pierre Ossman'
> >> > Subject: Re: [RFC/PATCH 1/4] MMC/SD Controller driver 
> for OMAP2430
> >> >
> >> > ext Madhusudhan Chikkature Rajashekar wrote:
> >> > > This patch adds MMC controller driver for OMAP2430/3430.
> >> > >
> >> > > Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> >> > >
> >> > > ---
> >> > >  drivers/mmc/host/Makefile     |    9
> >> > >  drivers/mmc/host/omap_hsmmc.c |  985
> >> > ++++++++++++++++++++++++++++++++++++++++++
> >> > >  2 files changed, 993 insertions(+), 1 deletion(-)
> >> > >
> >> > > Index: linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c
> >> > > 
> ===================================================================
> >>
> >> <snip>
> >>
> >> > >
> >> > Hi Madhu,
> >> >
> >> > I'd rather see this code using multislot structures and 
> omap.c instead
> >> > of defining a whole new codebase for omap2430 and/or omap3.
> >> >
> >> > BR,
> >> >
> >> > Carlos.
> >> >
> >> >
> >> Hi Carlos,
> >>
> >> Thanks for comments.
> >>
> >> I remember we had discussed this before as well, as 
> communicated before
> > the MMC/SD controller on OMAP2430 and 3430 processors is
> > completely different( in Register width, bits, offsets, 
> configuration
> etc)
> > from OMAP2420 and OMAP1 platforms. It's not recommended
> > to add new MMC controller functionality to existing omap.c.
> > 
> > Well, this time it actually looks like the MMC controller is
> > completely different.
> > 
> >> Yes we will definitely use multi-slot structures. We can 
> add multi-slot
> > support after we get formal approval of this code base.
> > 
> > Do you still need to mux between slots if you have three controllers
> > available? If so, it's worth doing it to start with.
> > 
> > Regards,
> > 
> > Tony
> > 
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
> 
> 
