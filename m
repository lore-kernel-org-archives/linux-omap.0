From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 13:36:59 +0200
Message-ID: <1326973019.7926.7.camel@lappy>
References: <20120112095940.0a54413e@notabene.brown>
	 <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	 <20120113222045.37f9b4ec@notabene.brown> <1326870839.1954.23.camel@deskari>
	 <20120118221538.342b4782@notabene.brown> <1326886940.1999.5.camel@lappy>
	 <20120119073032.74cc0992@notabene.brown>
	 <WC20120119101721.07072A@terrafix.co.uk> <1326969658.1935.24.camel@deskari>
	 <WC20120119112911.670749@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56656 "HELO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750980Ab2ASLhD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 06:37:03 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so457226lag.17
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 03:37:02 -0800 (PST)
In-Reply-To: <WC20120119112911.670749@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: NeilBrown <neilb@suse.de>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

On Thu, 2012-01-19 at 11:29 +0000, Joe Woodward wrote:
> ... (apologies for awful formatting of the previous mail) ...
>  
> > Well, I don't see how UART could directly affect DSS. The thing that
> > comes to my mind is that typing a char in the console causes a change
> > in
> > the power management, which then "fixes" the DSS. But then again, I'd
> > expect the console to go into sleep/idle state after a short while,
> > which should again cause sync_losts. But that's not happening...
> > 
> > Can you show the dss clocks you use (cat debugfs/omapdss/clk)?
> > 
> > It's been a while since I did anything with PM, so I don't remember how
> > and if it can be done, but a simple test would be to lock the OMAP to
> > always use OPP100.
> > 
> >  Tomi
> > 
> 
> Right,
> 
> I'm running with both CPUIDLE and CPUFREQ disabled at present so I assume that means I should always be in OPP100?
> 
> The panel is 800x480 (I've added a configuration to the generic-panel with the correct panel parameters), with just 1 FB device (/dev/fb0).
> 
> Clock dump is shown below:
> 
> # pwd
> /debug/omapdss
> # cat clk
> [   53.146057] omapdss DSS: dss_runtime_get
> [   53.151000] omapdss DSS: dss_runtime_put
> [   53.155151] omapdss DISPC: dispc_runtime_get
> [   53.160430] omapdss DISPC: dispc_runtime_put
> - DSS -
> dpll4_ck 432000000
> DSS_FCK (DSS1_ALWON_FCLK) = 432000000 / 12 * 2 = 72000000
> - DISPC -
> dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
> fck             72000000
> - LCD1 -
> lcd1_clk source = DSS_FCK (DSS1_ALWON_FCLK)
> lck             72000000        lck div 1
> pck             36000000        pck div 2
> 
> 
> The SYNC_LOST errors sometimes don't happen, and sometimes fix themselves. It does seem that whenever a character is typed in to the UART the SYNC_LOST errors stop immediately.

Yep, the clocks are so low that they should work fine with OPP50 also...

 Tomi


