From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
Date: Thu, 26 Apr 2012 06:43:25 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FEB50@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204252335190.30642@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FE7EA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204260025140.30642@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1204260025140.30642@utopia.booyaka.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 26, 2012 at 12:06:00, Paul Walmsley wrote:
> On Thu, 26 Apr 2012, Hiremath, Vaibhav wrote:
> 
> > Unfortunately, this is fractional divider, assuming input clock of 24MHz.
> > 
> > 24MHz / 732.4219 = 32KHz (Normal OPP100)
> > 24MHz / 366.2109 = 32KHz (OPP50)
> 
> Yes, I already saw that in the TRM.  The question is, how is the 
> fractional divider implemented in the hardware?  Is it implemented as an 
> M,N counter?  It's rather unlikely to be dividing by 732.4219 directly -- 
> in fact that value isn't even accurate.
> 

Not sure how it is implemented in HW, in any case we do not have control 
over it. The control is only provided using,
	- MODULEMODE (module enable/disable)
	- CONTROL_CLK32K_DIVRATIO_CTRL (divisor selection)


> > As per the Spec, we have some known HW/Si issues to run whole system at 
> > OPP50, that's where if you refer to the TRM Table 8-22. Per PLL Typical 
> > Frequencies (MHz), it only talks about OPP100, which is 732.4219 divider.
> > 
> > So, technically, if both OPP's (OPP100 and OPP50) works fine, then yes, we 
> > should handle it. But given the fact that, OPP50 is not fully functional due 
> > to HW/Si issues, from CORE and PER perspective we will always stay at OPP100.
> 
> I see.
> 
> > To summarize, I had to make it fixed-frequency due to,
> > 
> >  - Fractional divisor value.
> 
> This could be implemented as an M,N counter, unless the hardware is doing 
> something more unusual.
> 
> > > - This clock is feeding downstream clocks, but it's using the MODULEMODE 
> > > control interface, as if it were a standalone IP block.  Do you know why 
> > > it's using the MODULEMODE control method rather than some optional clock 
> > > control bits, like OMAP4 does?
> > 
> > Yes, this clock is feeding to timers, gpio debounce clocks, etc...
> > Honestly, I do not know the answer to why part of it.
> > (May be another integration/design issue)
> 
> Could you please check with the AM335x PRCM designers about this to find 
> out what that MODULEMODE bit is actually doing (i.e., is it actually 
> enabling the clock, and if so, why did they not use the OPTFCLKEN bits) ?  
> The AM335x TRM has almost no documentation on what those MODULEMODE bits 
> are doing in this case.
> 

I can check, I am certain that, the answer would be to consider this as a 
separate independent module. And same as other modules, control is provided 
to the SW.

> We're trying to remove all of these MODULEMODE clocks from the clock 
> framework, and also remove the accompanying clockdomain control sequence 
> from the clock code.  But now it's looking like it may be impossible due 
> to this "clock," which means we'll need to keep that code around, which is 
> unfortunate.
> 

I think we have to live with it.

Thanks,
Vaibhav
> 
> - Paul
> 
