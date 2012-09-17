From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Enable pinctrl dummy states
Date: Mon, 17 Sep 2012 13:07:49 -0400
Message-ID: <20120917170749.GQ27758@beef>
References: <1347385599-27558-1-git-send-email-mporter@ti.com>
	<1347385599-27558-3-git-send-email-mporter@ti.com>
	<20120911180306.GI23092@atomide.com> <20120911181540.GO27758@beef>
	<20120911183522.GL23092@atomide.com> <20120911190602.GP27758@beef>
	<20120912010307.GP23092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120912010307.GP23092-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, AnilKumar <anilkumar-l0cyMroinI0@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2012 at 06:03:07PM -0700, Tony Lindgren wrote:
> * Matt Porter <mporter-l0cyMroinI0@public.gmane.org> [120911 12:05]:
> > On Tue, Sep 11, 2012 at 11:35:22AM -0700, Tony Lindgren wrote:
> > > Added Linus Walleij to Cc as well.
> 
> Now I think I really managed to add Linus W to Cc, sent too fast
> earlier.
> ...
> 
> > > But do you get an error then if the desired pins are not found?
> > > If you do get an error, then sounds like it's OK to do.
> >
> > Hrm, no. In that case, it will be completely silent (assuming we took
> > care of the pinmuxing in the bootloader) as it uses the dummy state.
> > Only with debug on will you see the information that mcspi has used
> > the dummy state as is the case with !DT.
> ...
>  
> > > Well I think we should consider at least the following:
> > > 
> > > 1. Always see warnings when device tree is populated with board-generic.
> > >    If somebody wants to use bootloader only muxing with DT, they can patch
> > >    in pinctrl_provide_dummies() somewhere. But let's assume we always
> > >    want to see the warnings with board-generic.c and DT.
> > 
> > Ok, this is clear.
> > 
> > > 2. For legacy booting without DT, we should not see any warnings
> > >    from pinctrl-single.c as it's DT based.
> > 
> > Right, except anything legacy booting without DT will require that
> > dummy states be present otherwise it will fail probe.
> 
> But I guess we should enable the dummy states only for other
> board-*.c files, not board-generic.c? 
> 
> > > 3. There may be other non-pinctrl drivers too that are not DT
> > >    based, and in those cases we should see the warnings as well
> > >    for in the non-DT case.
> > 
> > I'm not sure what you mean here. "non-pinctrl drivers" means any driver
> > that is not yet pinctrl or DT enabled? It's unclear to me how this
> > case has a bearing on mcspi and pinctrl enablement across legacy
> > board-foo.c !DT booting platforms.
> 
> Right, sorry I meant "non DT pinctrl drivers"..
>  
> > However, I think if the approach was modified by only calling
> > pinctrl_provide_dummies() when we are booting with DT populated
> > and using board-generic.c then it will satisfy all of your
> > concerns. Thoughts?
> 
> Hmm but shouldn't it be call pinctrl_provide_dummies() only
> for other boards except board-generic.c? And that is assuming
> we don't have any other "non DT pinctrl drivers" around.

Yes, I've addressed this now in v2.

> > i.e. the legacy !DT booting will have dummy states and continue
> > along through mcspi the way it does today, relying on board-foo level
> > pinmux calls (or bootloader pinmuxing). Meanwhile DT booting will now
> > require that a mcspi instance also require pinctrl entry in this dts.
> 
> Yes agreed, except let's just produce a warning for the pinctrl
> errors..

Sounds good, I changed this in v2 to use the same warning as leds-gpio.

> > The only worrisome thing is the pinctrl requirement on DT booting is
> > now an implicit requirement.
> 
> ..as otherwise not much will work at this point :)

:)

> > > > > For board-generic.c we always want to see the warnings. And some boards
> > > > > insist on doing all the muxing only in the bootloader.
> > > > 
> > > > Which warnings are you saying we should see in the board-generic.c
> > > > case?  Sure, there's plenty of cases where this will be unused due to
> > > > somebody setting all the muxes in the bootloader and then not using
> > > > pinctrl data. I'll have to doublecheck but I believe that case is also
> > > > fine as the -single driver can't override the dummy state if the DT has
> > > > no pinctrl data for the spi driver.
> 
> I suggest all pinctrl errors should show up as warnings with
> board-generic.c, but we should not exit out of the driver probe
> on errors.

Ok, makes sense to me now.

Thanks,
Matt

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
