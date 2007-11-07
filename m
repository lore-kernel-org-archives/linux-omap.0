From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH/RFC 0/3 rev 3] I2C bus registration helper
Date: Wed,  7 Nov 2007 12:54:30 +0200
Message-ID: <1194432873-5209-1-git-send-email-jarkko.nikula@nokia.com>
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

Third version of I2C bus registration helper. Now omap_i2c_mux_pins
is supposed to stay here for doing pin muxing for I2C as suggested by David

http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/011906.html

Patch 2 differs only in board-h4.c where omap_cfg_reg calls are removed.
Patch 3 is the same than previously.

-- 
Jarkko
