From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 0/4] spi: omap2-mcspi: Fixes for recent updates
Date: Sat, 23 May 2015 21:13:41 -0500
Message-ID: <1432433625-23407-1-git-send-email-mwelling@ieee.org>
References: <20150522122544.GL21391@sirena.org.uk>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20150522122544.GL21391@sirena.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>
List-Id: linux-omap@vger.kernel.org

The recent update of the OMAP2 McSPI driver left some unresolved issues.
These patches should take care them and again allow for GPIO chip selects
and native chip selects.

Michael Welling (4):
  spi: omap2-mcspi: Remove unnecessary delay
  spi: omap2-mcspi: Fix set_cs function for active high
  spi: omap2-mcspi: Fix GPIO chip select support
  spi: omap2-mcspi: Handle error on gpio_request

 drivers/spi/spi-omap2-mcspi.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
1.7.9.5
