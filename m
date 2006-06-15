From: Tony Lindgren <tony@atomide.com>
Subject: Re: Power domain addition.
Date: Wed, 14 Jun 2006 18:46:36 -0700
Message-ID: <20060615014636.GK13900@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A5062FD931@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5062FD931@dlee02.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com, sampsa.fabritius@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [060614 12:53]:
> 
> Tony,
> 
> Ok, by changing the size (1MB) and the type (MT_MEMORY) of the SRAM it
> now boots again with power enabled.  Apparently you must be developing
> on an older version of the kernel than is in git.  It seems MT_DEVICE
> results in a no execute mapping.  Giving it a try before committing
> would have saved some time.

Sorry, yes, I was working on it with some earlier kernel and am in
process of updating things.

Do you have a patch for your changes?
 
> Getting into the code a bit I see at few simple errors straight off.
> 
> -- The clearing of PM_WKST1_CORE, PM_WKS2_CORE, PM_WKST_WKUP need to
> have 1's written to clear bits not 0's.  This will defeat your sleep
> right out.  The code in our example clearly does this.

OK, thanks for noticing that, that's one step closer then.
 
> -- The code is doing debug printks after knocking out the uart clocks,
> this is strange.  I see that prior to attempted sleep that the UART3
> Iclk is enabled.  Was this left on for printing purposed?  I don't
> believe with the uart on the 48mhz can shut down, you never know when a
> start bit from someone else is coming in...

That should be fixed too.
 
> -- It doesn't seem like a proper wake up event path is being setup.  The
> PRCM side enables are being done but not at the module levels.  After I
> hacked the code a bit I was able to put the MPU into retention/clockstop
> but it would not wake up as no wakeup route was completely enabled.
> Modules meaning function level registers like GPIO and interrupt
> controller need to be setup also.

Hmmm, at least GPIO wake-up should work. I'll have to check if that
patch is missing something.
 
> -- By connecting with a emulator I was able to wake back up and
> continue.  I added the debug /proc/pwr24xx file from my code and it was
> apparent that the DSP moved from OFF back to the ON state.  It is likely
> not set up correctly.

Yes, currently you need to suspend DSP with a user space tool :(

I'd recommend leaving DSP out from Kconfig for now. The PM init
turns off DSP and IVA.
 
> -- In the example code I use the full auto method, I don't see auto
> state settings being done here (CM_CLKSTCTRL_CORE for instance)...

That might explain why the core retention does not happen.
 
> I didn't go though the code in detail just traced though it.  Sticking
> to the format of the working code I supplied would make it much easier
> for me to give comments. It seems several more bits are necessary before
> it will begin to work in this code tree.  As it was I spent a couple
> hours making this boot and tracing it.  No more time to spend now.

Thanks for taking a look at it. I tried to start with your code but it
was easier to start adding the components little by little.

Regards,

Tony
