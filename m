From: "Krishna Prasad Herur" <kherur@nextwave.com>
Subject: RE: DMA transfer using McSPI driver
Date: Tue, 30 Jan 2007 10:16:09 -0800
Message-ID: <E6CCDC65B8C522458685D8D1F145FEA814F0F8@CA2-MSX-C01.nw.net>
References: <E6CCDC65B8C522458685D8D1F145FEA811B9CE@CA2-MSX-C01.nw.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <E6CCDC65B8C522458685D8D1F145FEA811B9CE@CA2-MSX-C01.nw.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I think I know the reason for the soft lockup.

The omap 2430 errata says that the DMA Tx complete interrupt continues
to be asserted after a transaction error. I found this to be the reason
for the soft lockup. I am still unsure as to why there is a transaction
error!=20

=20

The McSpi driver configuration for DMA transfer seems to be
straightforward. The McSpi driver seems to be calling all the Dma driver
functions with the right parameters.=20

=20

Does anyone had success doing DMA transfers to/from McSpi channels using
the Omap McSpi driver?

Regards,

-Prasad

=20

________________________________

From: Krishna Prasad Herur=20
Sent: Tuesday, January 23, 2007 12:02 PM
To: linux-omap-open-source@linux.omap.com
Subject: DMA transfer using McSPI driver=20

=20

Hi Gurus,

            I was able to get raw data transfers over the McSPI bus on
an Omap 2430 based platform running Linux 2.6. I am trying to do the
same transmit using DMA. Is it possible to use DMA in polling mode? I
have not registered interrupt handlers or dma handlers.  Below is the
programming sequence I followed, after calling all the config macros.

=20

      omap2_mcspi_request_interface(devPtr);

      omap2_mcspi_interface_reset(devPtr);

      omap2_mcspi_get(devPtr);

      omap2_mcspi_config_channel(devPtr);

      omap2_mcspi_enable_channel(devPtr);

      omap2_mcspi_dma_writereq(devPtr,OMAP2_McSPI_DMAW_ENABLE);

      omap2_mcspi_transmit_buf(devPtr,dmaBuf,8);

=20

I get a DMA transaction error, and a soft lockup.=20

=20

DMA transaction error occurred with device 35

BUG: soft lockup detected on CPU#0!

=20

Regards,

-Prasad
