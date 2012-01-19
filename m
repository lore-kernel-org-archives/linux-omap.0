From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 12:21:28 +0000
Message-ID: <WC20120119122128.020787@terrafix.co.uk>
References: <20120113222045.37f9b4ec@notabene.brown> <1326870839.1954.23.camel@deskari> <20120118221538.342b4782@notabene.brown> <1326886940.1999.5.camel@lappy> <20120119073032.74cc0992@notabene.brown> <WC20120119101721.07072A@terrafix.co.uk> <1326969658.1935.24.camel@deskari> <WC20120119112911.670749@terrafix.co.uk> <1326973019.7926.7.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:33726 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750807Ab2ASMVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 07:21:45 -0500
In-Reply-To: <1326973019.7926.7.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: NeilBrown <neilb@suse.de>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org



-----Original Message-----
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: NeilBrown <neilb@suse.de>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org
Date: Thu, 19 Jan 2012 13:36:59 +0200
Subject: Re: DSS2/PM on 3.2 broken?

> On Thu, 2012-01-19 at 11:29 +0000, Joe Woodward wrote:
> > ... (apologies for awful formatting of the previous mail) ...
> >  
> > > Well, I don't see how UART could directly affect DSS. The thing
> that
> > > comes to my mind is that typing a char in the console causes a
> change
> > > in
> > > the power management, which then "fixes" the DSS. But then again,
> I'd
> > > expect the console to go into sleep/idle state after a short while,
> > > which should again cause sync_losts. But that's not happening...
> > > 
> > > Can you show the dss clocks you use (cat debugfs/omapdss/clk)?
> > > 
> > > It's been a while since I did anything with PM, so I don't remember
> how
> > > and if it can be done, but a simple test would be to lock the OMAP
> to
> > > always use OPP100.
> > > 
> > >  Tomi
> > > 
> > 
> > Right,
> > 
> > I'm running with both CPUIDLE and CPUFREQ disabled at present so I
> assume that means I should always be in OPP100?
> > 
> > The panel is 800x480 (I've added a configuration to the generic-panel
> with the correct panel parameters), with just 1 FB device (/dev/fb0).
> > 
> > Clock dump is shown below:
> > 
> > # pwd
> > /debug/omapdss
> > # cat clk
> > [   53.146057] omapdss DSS: dss_runtime_get
> > [   53.151000] omapdss DSS: dss_runtime_put
> > [   53.155151] omapdss DISPC: dispc_runtime_get
> > [   53.160430] omapdss DISPC: dispc_runtime_put
> > - DSS -
> > dpll4_ck 432000000
> > DSS_FCK (DSS1_ALWON_FCLK) = 432000000 / 12 * 2 = 72000000
> > - DISPC -
> > dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
> > fck             72000000
> > - LCD1 -
> > lcd1_clk source = DSS_FCK (DSS1_ALWON_FCLK)
> > lck             72000000        lck div 1
> > pck             36000000        pck div 2
> > 
> > 
> > The SYNC_LOST errors sometimes don't happen, and sometimes fix
> themselves. It does seem that whenever a character is typed in to the
> UART the SYNC_LOST errors stop immediately.
> 
> Yep, the clocks are so low that they should work fine with OPP50
> also...

If I do (either from the console or via a button press on the screen) then I never get a SYNC_LOST.
  echo 0 > /sys/devices/omapdss/display0/enabled
  echo 1 > /sys/devices/omapdss/display0/enabled

Just trying to think of some ideas that may be affecting the DSS...
  - Could it to be to do with the GPIO being used as a wake source (i.e. does the GPIO driver do runtime_pm properly?)?
  - Could it to be to do with the UART as it seems to fix itself whenever a character is pressed?
  - Could it to be to do with the ordering in which drivers are resumed?

Is the SYNC_LOST normally due to a lack of memory bandwidth? If so, it is possible to find out what the kernel is doing during the resume?

And before looking at this too much more, is the changing of the pm_runtime_put to the _sync versions the correct fix?

Sorry for so many questions, but I'm interested in getting this fixed as it's the only thing stopping me from switching to 3.2 from 3.0!

Cheers,
Joe


