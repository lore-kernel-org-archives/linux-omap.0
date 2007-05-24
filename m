From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 0/2] 2430SDP touchscreen: use ads7846 instead of tsc2046
Date: Thu, 24 May 2007 10:21:43 -0700
Message-ID: <20070524172143.809836878@mvista.com>
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

The tsc2046 is just updated silicon of ads7846, so instead of having a
new driver for the tsc2046, use the ads7846 instead.

These also depend on David Brownell's recent McSPI cleanups.

Kevin
