From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: Using McBSP in kernel...
Date: Thu, 20 Jul 2006 07:16:41 -0500
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBEB21CD9@DLEE09.ent.ti.com>
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
To: Matthew Percival <matthew@capgo.com>, Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi

There are some app notes on TI site, I found one here
http://focus.ti.com/lit/an/spra487c/spra487c.pdf

Try to compare your values with this example.

McBSP registers are 16bit, Some times reading them as 32bit will result
in 0s. I don't know if this is the exact issue you are facing when
reading from application space. Make sure you do a 16bit read of every
register.

The FSX line will be used as Chip Select for SPI operations, So, while
doing initial mux settings, you put the line as pulled up. If you are
using a CRO to probe the signals, then probing this line should show
high.=20

When you configure your SPI for a low Chip select polarity and then
write to a DXR register, the FSX / CS line should go low. This will
confirm if all your register settings clock and mux settings.

Regards,
Khasim


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Matthew Percival
Sent: Thursday, July 20, 2006 1:54 AM
To: Linux OMAP Open Source
Subject: RE: Using McBSP in kernel...

G'Day,

	Thanks for the reply.

> Configuration seems to fine, did you check pin muxing?

	Aye, MUX settings are correct according to the manual.  The
clock
(ARM_PER, according to the manual) is also on (I checked
both /proc/omap_clocks and the ARM_IDLCT2 register).  I have also
observed that, for whatever reason, I can read/write the registers
perfectly fine in kernel, but they always seem to return 0x0 when I try
to read from user space (using devmem2).  I am not sure if that is
relevant or not, but it seemed odd.

> Also, note that clock will be generated only when there is data on the
> bus. Otherwise the line will be simply high. If CS line is configured
as
> active low, then you might not even see the CS line changing its
> transition. Try to put CS line as high during initialization and then
do
> a write, it should drop to low.

	I am not sure what you mean by configuring the CS line.  Could
you give
a reference for this?  If you are referring to the Frame Sync./Slave
Enable, that is configured to active low, but I am not sure how to
configure it to be high during initialisation.

	-- Matthew

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
