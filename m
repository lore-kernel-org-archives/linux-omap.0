From: Matthew Percival <matthew@capgo.com>
Subject: RE: Using McBSP in kernel...
Date: Thu, 20 Jul 2006 16:53:34 +1000
Message-ID: <1153378414.5157.7.camel@localhost.localdomain>
References: <77C7F7CB1230A74A9D19C0C111E6EDBEAD159C@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBEAD159C@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

	Thanks for the reply.

> Configuration seems to fine, did you check pin muxing?

	Aye, MUX settings are correct according to the manual.  The clock
(ARM_PER, according to the manual) is also on (I checked
both /proc/omap_clocks and the ARM_IDLCT2 register).  I have also
observed that, for whatever reason, I can read/write the registers
perfectly fine in kernel, but they always seem to return 0x0 when I try
to read from user space (using devmem2).  I am not sure if that is
relevant or not, but it seemed odd.

> Also, note that clock will be generated only when there is data on the
> bus. Otherwise the line will be simply high. If CS line is configured as
> active low, then you might not even see the CS line changing its
> transition. Try to put CS line as high during initialization and then do
> a write, it should drop to low.

	I am not sure what you mean by configuring the CS line.  Could you give
a reference for this?  If you are referring to the Frame Sync./Slave
Enable, that is configured to active low, but I am not sure how to
configure it to be high during initialisation.

	-- Matthew
