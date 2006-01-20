From: tony@atomide.com
Subject: Re: [PATCH] Palm TE Touchscreen and fixes
Date: Fri, 20 Jan 2006 11:53:52 -0800
Message-ID: <20060120195352.GB6683@atomide.com>
References: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
	<20060115201949.GF5905@atomide.com>
	<fb249edb0601161523q70fc0ba1n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0601161523q70fc0ba1n@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [060116 15:23]:
> Hi there,
> 
> > Regarding changes to clock.[ch], we should have CLOCK_IN_OMAP1510 and
> > CLOCK_IN_OMAP3XX separate. At least the DSP clocks should not be on 310
> > because it does not have a DSP AFAIK. They may be also other clocks that
> > are not on 310.
> >
> > Could you please redo the clock.[ch] patch so it adds CLOCK_IN_OMAP3XX,
> > and masks it only for the clocks you think you have on 310?
> >
> > Or if you don't know which clocks are on both 310 and 1510, you could
> > just leave out DSP clocks for now, and enable all other 1510 clocks
> > also for 310.
> 
> Indeed, I don't know which clocks are there and I don't know if the
> board has a DSP or not. There is no real documentation for OMAP310
> publicly availiable. The product page
> (http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=11997&path=templatedata/cm/product/data/omap_310)
> doesn't mention DSP, except the line
> "Digital Phase-Locked Loop (DPLL) for MPU/DSP/TC Clocking Control",
> however it is said that OMAP310 is similar to OMAP5910
> (http://focus.ti.com/docs/prod/folders/print/omap5910.html) which is
> fully documented and this one definitely has a DSP.
> After disabling the DSP related clocks and the DSP initialisation,
> McBSP fails to initialise with the message: "mcbsp: could not acquire
> dsp_ck handle", nevertheless the kernel still boots and everything
> works fine. (It feels bad not knowing what's inside your computer.)
> I'm attaching the same patch but with CLOCK_IN_OMAP1510 and
> CLOCK_IN_OMAP310 separate and everything DSP-related turned off.

OK, I've pushed linux-palmte-errors.patch in three separate patches.
Where did find out the mclk for 15xx entry, BTW? Just trying out the
bits?

Regards,

Tony
