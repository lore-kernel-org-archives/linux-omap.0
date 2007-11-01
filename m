From: "Heilpern, Mark" <mark.heilpern@authentec.com>
Subject: SPI slave / receive w/ DMA failing
Date: Thu, 1 Nov 2007 09:30:13 -0400
Message-ID: <5ACCFDF5BCF2C34DB62D54EFA1FDF700519556@corp-mail01.auth.org>
References: <46F28BC7.80309@indt.org.br> <20071101125558.GG20403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Class: urn:content-classes:message
In-Reply-To: <20071101125558.GG20403@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello,

Using kernel 2.6.19, I'm almost successful in using SPI the way I need,
but not quite. It seems that whatever is wrong is probably something
simple I'm overlooking, so I'm hoping someone on the list will have an
idea...

My configuration is using SPI2, where my OMAP (2430) is a receive-only
slave. In advance of data arriving on the channel, I prepare a DMA-based
receive, and my callback is being run, indicating that the DMA is
satisfied it's been completed. My test is a request for only 16 bytes
but the command I'm sending my external hardware (through a non-McSPI
channel) results in 126 bytes coming in; I can verify with a logic
analyzer that the proper data is sent by my external hardware.

Here's the problem... prior to the operation I allocate (using
dma_alloc_coherent()) more than enough RAM to receive my data (I'm
allocating 1k), and I memset that block to 0xFF. The DMA callback
function is printk'ing 32 bytes from that buffer (remember, I set the
DMA for only 16 bytes, using omap2_mcspi_receive_buf(..., dma_phys_addr,
16)), and what I find is the first 16 bytes are 0x00 and the next 16 are
0xFF. So, it seems likely that DMA is putting data into my buffer, but
based on the logic analyzer data (which shows the exact data I expect
from my device), DMA isn't seeing proper data; probably SPI2 isn't
seeing proper data.

My device's data out signal is attached to spi2_simo, and prior to using
the SPI channel I've configured the input to be on simo using
omap2_mcspi_set_is(..., OMAP2_McSPI_CHCFG_IS_DL1RECEIVE).

I noticed that the reset configuration for spi2_simo is to configure the
pin as mode3 (GPIO 89), so I've reconfigured it for mode0 (spi2_simo),
but this didn't change my results.

The spi documentation mentions several times that a byte must be placed
into th TX register (even though the channel is configured for
receive-only) in order to work, so this has been done... but no
improvement.

At the end of things, my SPI2 register set is:
   MCSPI_REV : [0xD809A000] =3D 0x00000018
   MCSPI_SYSCONFIG : [0xD809A010] =3D 0x00000000
   MCSPI_SYSSTATUS : [0xD809A014] =3D 0x00000001
   MCSPI_IRQSTATUS : [0xD809A018] =3D 0x00010009
   MCSPI_IRQENABLE : [0xD809A01C] =3D 0x00000000
   MCSPI_WAKEUPENABLE : [0xD809A020] =3D 0x00000000
   MCSPI_SYST : [0xD809A024] =3D 0x00000000
   MCSPI_MODULCTRL : [0xD809A028] =3D 0x00000004
   MCSPI_CH0CONF [0xD809A02C] =3D 0x000793D6
   MCSPI_CH0STAT [0xD809A030] =3D 0x00000005
   MCSPI_CH0CTRL [0xD809A034] =3D 0x00000001

Register 49002114 (the top byte of which configures spi2_simo) =3D=3D
0x000F1B0F

It seems to me that the pin must not be configured correctly, but I'm
not clear on what else to change to see a difference.

Any thoughts?

Thanks,
Mark


NOTE: The information in this message is intended for the personal and =
confidential use
of the designated recipient(s) named above. To the extent the =
recipient(s) is/are bound
by a non-disclosure agreement, or other agreement that contains an =
obligation of
confidentiality, with AuthenTec, then this message and/or any =
attachments shall be
considered confidential information and subject to the confidentiality =
terms of that
agreement.  If the reader of this message is not the intended recipient =
named above, you
are notified that you have received this document in error, and any =
review, dissemination,
distribution or copying of this message is strictly prohibited. If you =
have received this
document in error, please delete the original message and notify the =
sender immediately.
Thank you.

AuthenTec, Inc.  http://www.authentec.com
