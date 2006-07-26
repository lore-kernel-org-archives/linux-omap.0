From: Mark Howell <mhowell@northlink.com>
Subject: Re: Using McBSP in kernel...
Date: Wed, 26 Jul 2006 14:16:00 -0700
Message-ID: <44C7DB90.3050406@northlink.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBEB21CD9@DLEE09.ent.ti.com>
	<1153723664.5162.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1153723664.5162.18.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Matthew Percival <matthew@capgo.com>
Cc: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Matthew, I have a working driver that uses McBSP2 to talk to an SPI 
slave on my H2 (1611) dev board. It does *not* use the McBSP SPI driver 
in the kernel, but rather goes straight to the McBSP registers. If this 
would be handy to play with or refer to, I can e it to you off-list.

Cheers,

Mark.

Matthew Percival wrote:
> G'Day,
> 
> 	I am still unsuccessful at using McBSP2 as an SPI Master in a kernel
> driver.  I have confirmed that the mux settings are correct, and have
> attempted using a pull up (though have noted no change).
> 
> 	An interesting occurrence I have observed in my testing is that if I
> test that XRDY is set, indicating that I can load DXR2/1, load the
> transmit registers, then check again, XRDY is still set afterwards, and
> both registers still reflect the values I put in them earlier.  Clearly
> the module is not attempting to transmit, which would explain why I see
> nothing with the CRO.
> 
> 	Looking over the diagrams in spru762, I came across something
> interesting.  I understand that, for an SPI Master, FSXM should be set
> to 1, yet Figure 4 suggests that MCBSP2.FSX will only come out if FSXM
> is set to 0.  Am I mistaken in this, is the diagram wrong, or perhaps is
> McBSP2 unsuitable for use as a SPI Master (or at least in the way I have
> configured it)?
> 
> 	Thanks,
> 
> 	Matthew
> 
> PS I shall include a current register dump, in case this is of use:
> 		DRR2:  0x0000
> 		DRR1:  0x0000
> 		DXR2:  0x0000
> 		DXR1:  0x0000
> 		SPCR2: 0x00C3
> 		SPCR1: 0x1001
> 		RCR2:  0x0001
> 		RCR1:  0x00A0
> 		XCR2:  0x0001
> 		XCR1:  0x00A0
> 		SRGR2: 0x2000
> 		SRGR1: 0x1F00
> 		PCR0:  0x0A0B
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> 
> 
