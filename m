From: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] spi: omap2-mcspi: add FIFO buffer support
Date: Fri, 14 Jun 2013 19:12:06 +0300
Message-ID: <1371226328-24147-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

These patches introduce FIFO support for TI OMAP4/OMAP5 MCSPI controller.
Using FIFO unload the DMA and improve data throughput. On Blaze (OMAP 4460) 
ethernet throughput with MTU 1500 was increased:
* for TX from 6.9476 Mbps (FIFO disabled) to 8.1046 Mbps (FIFO enabled),
* for RX from 6.5120 Mbps (FIFO disabled) to 7.6091 Mbps (FIFO enabled).

The FIFO sanity test on OMAP5 Panda board also has been done. 

The FIFO is enabled for SPI transfers in DMA mode. The largest possible FIFO
buffer size will be calculated and set up. The FIFO won't be used for the SPI
transfers in DMA mode if: calculated FIFO buffer size is less then 2 bytes or
the FIFO buffer size isn't multiple of the SPI word length.

The MCSPI FIFO constraints are:
* FIFO depth size defined as a multiple of the SPI word length;
* transfer's data size is a multiple of FIFO depth;
* transfer's words count less or equal 65535.

Also FIFO buffer with 1 byte size is insignificant, so driver will setup FIFO if
calculated size is within the 2 to 64 bytes range.

--------------------
v3:
* FIFO enadled for all SPI transfers in DMA mode.

--------------------
v2:
* driver calculate and setup optimal FIFO size for each SPI transfer;
* "ti,spi-fifo-enabled" parameter in MCSPI DT node to enable FIFO;
* no FIFO settings in SPI slaves nodes in DT;
* Matthias Brugger patch was excluded from patch set.

Illia Smyrnov (2):
  spi: omap2-mcspi: Move bytes per word calculation to the function
  spi: omap2-mcspi: Add FIFO buffer support

 drivers/spi/spi-omap2-mcspi.c |  166 +++++++++++++++++++++++++++++++++++------
 1 files changed, 143 insertions(+), 23 deletions(-)


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
