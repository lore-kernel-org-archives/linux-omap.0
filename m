From: Matthew Percival <matthew@capgo.com>
Subject: RE: Using McBSP in kernel...
Date: Mon, 24 Jul 2006 16:47:44 +1000
Message-ID: <1153723664.5162.18.camel@localhost.localdomain>
References: <77C7F7CB1230A74A9D19C0C111E6EDBEB21CD9@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBEB21CD9@DLEE09.ent.ti.com>
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

	I am still unsuccessful at using McBSP2 as an SPI Master in a kernel
driver.  I have confirmed that the mux settings are correct, and have
attempted using a pull up (though have noted no change).

	An interesting occurrence I have observed in my testing is that if I
test that XRDY is set, indicating that I can load DXR2/1, load the
transmit registers, then check again, XRDY is still set afterwards, and
both registers still reflect the values I put in them earlier.  Clearly
the module is not attempting to transmit, which would explain why I see
nothing with the CRO.

	Looking over the diagrams in spru762, I came across something
interesting.  I understand that, for an SPI Master, FSXM should be set
to 1, yet Figure 4 suggests that MCBSP2.FSX will only come out if FSXM
is set to 0.  Am I mistaken in this, is the diagram wrong, or perhaps is
McBSP2 unsuitable for use as a SPI Master (or at least in the way I have
configured it)?

	Thanks,

	Matthew

PS I shall include a current register dump, in case this is of use:
		DRR2:  0x0000
		DRR1:  0x0000
		DXR2:  0x0000
		DXR1:  0x0000
		SPCR2: 0x00C3
		SPCR1: 0x1001
		RCR2:  0x0001
		RCR1:  0x00A0
		XCR2:  0x0001
		XCR1:  0x00A0
		SRGR2: 0x2000
		SRGR1: 0x1F00
		PCR0:  0x0A0B
