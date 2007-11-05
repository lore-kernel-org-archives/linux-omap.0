From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 2/2] 3430 clock: add emulation clocks
Date: Mon, 5 Nov 2007 05:49:34 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429026298DF@dlee13.ent.ti.com>
References: <20071105082406.387923286@pwsan.com>
	<20071105082528.483327389@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20071105082528.483327389@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Add clocks for the EMU domain for OMAP3430.  These clocks are not
> well-documented in the TRM, beyond register bit settings.  Some
> information is available in the ARM Cortex-A8 TRM, section 10.1.  Also
> rename existing emul_* clocks to emu_* to conform with recent TRMs.

There are TRM addendums for emulations which have much more information.
You at times need more than the base TRM these days.  There are probably
a couple thousand more pages removed :) You wouldn't want to have too
big of TRM, 43Meg is just the right size.

There actually is a lot more to the emulation capabilities on OMAP3 as
compared to previous OMAPs.  It has the ability to selectively wake on
JTAG accesses and source clocks too potentially inactive modules for
debug of things like OFF mode (icemelter module in wakeup, can wake
emulation domain, which then does the heavy lifting).  It also adds a
DAP so you can make many accesses with out involving the ARM. With out
using some of these features you will find your emulator won't connect
well if the ARM's target state is retention or off.  This is now common
place with cpu-idle.

Regards,
Richard W.
