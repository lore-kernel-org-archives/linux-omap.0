From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC, PATCH 0/7] ARM support for hrtimers, dyntick
Date: Mon, 19 Feb 2007 13:47:19 -0800
Message-ID: <20070219214719.379287000@mvista.com>
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
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: tglx@linutronix.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Here is support for hrtimers and dyntick on a few ARM platforms:
ixp4xx, versatile and OMAP.  Patches are against today's Linus git
tree.

For the time being, LED support is missing as the ARM-specific
do_leds() is no longer used.  Based on feedback from my previous RFC,
I think the right thing to do is to migrate any LED drivers to the new
drivers/led framework.

Kevin
