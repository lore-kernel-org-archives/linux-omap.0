From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 0/2] TSC2046 toucscreen support
Date: Fri, 04 May 2007 14:40:28 -0700
Message-ID: <20070504214028.649198901@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Here is support for the TSC2046 touchscreen controller which is on the
OMAP2430SDP board.  It also includes a patch to add debounce support
to the GPIO layer.

Note that SPI driver-model hook-ups are done in the touchscreen driver
instead of a separate tsc2046 layer in drivers/spi.  It seemed
overkill to have drivers/spi/tsc2046.c with only a probe and remove
function, so I included them in drivers/input/touchscreen/tsc2046_ts.c.

Kevin

--
