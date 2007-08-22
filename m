From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock autoidling
 viathe clock framework
Date: Wed, 22 Aug 2007 03:49:16 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0708220312320.15587@utopia.booyaka.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708210050330.5695@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD86A6@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901AD86A6@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Richard,

On Tue, 21 Aug 2007, Woodruff, Richard wrote:

> Like I was indicating for OMAP2/3 if the PRCM auto idle was switched 
> with the module auto-idle it would not be noise it would be substantive.

It sounds like one doesn't even need to switch these bits, once we turn 
them on, correct?  Just enable *_SYSCONFIG autoidle and ICLK autoidle at 
boot in pm.c, and then never disable them, with no ill effects.  Some 
extra latency perhaps?  Drivers that need to toggle them to work around 
some hardware bug can just do that themselves, for the time being...

> 	-- One issue here is the address range for this bit is with each 
> driver in the _generic_ IP OCP (open core protocol bus interface) 
> wrapper header.  To write to this you need i+f clock on.  It still helps 
> to set this bit even if the module is off as the clock tree can still be 
> active and dissipating some power in the module.

You're talking about the *_SYSCONFIG autoidle bits here, right?  So to set 
those properly we'd need to walk the clock tree, enabling module clocks 
and setting the *_SYSCONFIG autoidle bit, then powering the module clocks 
back down again?

> 	-- This is what the patch I sent out a while back was about 
> (RFC/PATCH) to just enable all of these.  It did save a lot of power.

I just took another look at that patch.  The only downside is latency, 
right?  Are you thinking about updating the patch for the new PRCM access 
code?  That would make it much easier to test...

> 	** As its generic and symmetric for every IP in the OCP wrapper I 
> personally like to stick it all in one spot inside of adding a bunch of 
> defines to every driver.

Since all of those registers are in SCM space, perhaps an scm.h/scm.c file 
might be useful here.  I've been running into this with CONTROL_DEVCONF* 
on 3430 code.  I don't think the *_SYSCONFIG powersave bits fit well into 
the clock framework, so we should probably place it outside the clocks. 
I do think it would make sense to specifically encode the power domain 
that each clock resides in into the struct clk, for use by PM or SCM code.

> 	** Recently we internally were debating a bit about if an API was 
> needed as you really in some cases do need to set the CLOCKACTIVITY bits 
> in the OCP wrapper depending on the drivers mode of activity.

I've been looking at these CLOCKACTIVITY bits and am not clear on the 
intended use.  They are read-only in many modules, at least according to 
the TRM.  There is a notation about "Clock activity during wakeup mode 
period" -- could you elaborate about what that means?

> When ICLKEN is enabled and the PRCM-auto-idle is enabled hardware can 
> manage that clock at domain change time assuming the peripheral 
> handshakes it ok (force/no/smart).
>
> If the ICLKEN is disabled the setting of PRCM-auto-idle has no effect.

Okay, makes sense.

> One of the big target states for big power savings is this so called 
> 'partially' active state.  In this case you do want the clock domains 
> and the power domains states to not be in sync.  The L3/L4 can be 
> stopped, but say an F-Clock to a McBSP can still be running pushing data 
> out to a codec.  If programmed up correctly, the codec need for data can 
> automatically signal the prcm to re-activate the L3/L4 then allow the 
> new data to flow.

This is via the WKDEP/SLEEPDEP registers, correct?  or is this via another 
mechanism?

> However, other bits in the same range CLOCKACTIVTY do have a bit more 
> need of dynamic access.  WE enable also might be conditionally set.

Sorry, you lost me there - what is WE enable?


Thanks for all of the detailed information, Richard,

- Paul
