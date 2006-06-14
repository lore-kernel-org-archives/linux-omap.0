From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Power domain addition.
Date: Wed, 14 Jun 2006 14:52:11 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5062FD931@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C68FEC.077AA99A"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com, sampsa.fabritius@nokia.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C68FEC.077AA99A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Tony,

Ok, by changing the size (1MB) and the type (MT_MEMORY) of the SRAM it
now boots again with power enabled.  Apparently you must be developing
on an older version of the kernel than is in git.  It seems MT_DEVICE
results in a no execute mapping.  Giving it a try before committing
would have saved some time.

Getting into the code a bit I see at few simple errors straight off.

-- The clearing of PM_WKST1_CORE, PM_WKS2_CORE, PM_WKST_WKUP need to
have 1's written to clear bits not 0's.  This will defeat your sleep
right out.  The code in our example clearly does this.

-- The code is doing debug printks after knocking out the uart clocks,
this is strange.  I see that prior to attempted sleep that the UART3
Iclk is enabled.  Was this left on for printing purposed?  I don't
believe with the uart on the 48mhz can shut down, you never know when a
start bit from someone else is coming in...

-- It doesn't seem like a proper wake up event path is being setup.  The
PRCM side enables are being done but not at the module levels.  After I
hacked the code a bit I was able to put the MPU into retention/clockstop
but it would not wake up as no wakeup route was completely enabled.
Modules meaning function level registers like GPIO and interrupt
controller need to be setup also.

-- By connecting with a emulator I was able to wake back up and
continue.  I added the debug /proc/pwr24xx file from my code and it was
apparent that the DSP moved from OFF back to the ON state.  It is likely
not set up correctly.

-- In the example code I use the full auto method, I don't see auto
state settings being done here (CM_CLKSTCTRL_CORE for instance)...

I didn't go though the code in detail just traced though it.  Sticking
to the format of the working code I supplied would make it much easier
for me to give comments. It seems several more bits are necessary before
it will begin to work in this code tree.  As it was I spent a couple
hours making this boot and tracing it.  No more time to spend now.

Regards,
Richard W.


> Tony,
>=20
> > Or put clock related PRCM registers to clock.c, power domain related
> > registers to pm-domain.c and so on. I have pm-domain.c somewhat
ready
> > here and will push it as soon as I can.
>=20
> I thought I might try this out quickly to see if anything obvious was
> wrong with the flow.
>=20
> I was surprised to find that when enabling power management the code
> infinite loops in calling into SRAM to do an idle-wfi.  It appears
that
> somehow the mapped SRAM does not have execute permission.  The pm code
> calls to SRAM and takes an exception, which resets (but not enough to
> execute) and restarts the fault, ... back to the exception.
>=20
> How did you test the code which was put in?  I'm not sure if this is a
> timing thing which I hit or it wasn't tested against the latest kernel
> which comes with a git pull.
>=20
> Regards,
> Richard W.

------_=_NextPart_001_01C68FEC.077AA99A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C68FEC.077AA99A--
