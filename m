From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Power domain addition.
Date: Wed, 14 Jun 2006 12:20:59 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5062FD6B8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony,

> Or put clock related PRCM registers to clock.c, power domain related
> registers to pm-domain.c and so on. I have pm-domain.c somewhat ready
> here and will push it as soon as I can.

I thought I might try this out quickly to see if anything obvious was
wrong with the flow.

I was surprised to find that when enabling power management the code
infinite loops in calling into SRAM to do an idle-wfi.  It appears that
somehow the mapped SRAM does not have execute permission.  The pm code
calls to SRAM and takes an exception, which resets (but not enough to
execute) and restarts the fault, ... back to the exception.

How did you test the code which was put in?  I'm not sure if this is a
timing thing which I hit or it wasn't tested against the latest kernel
which comes with a git pull.

Regards,
Richard W.
