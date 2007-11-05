From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH/RFC 0/3 rev 2] I2C bus registration helper
Date: Mon,  5 Nov 2007 15:15:56 +0200
Message-ID: <1194268559-16539-1-git-send-email-jarkko.nikula@nokia.com>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
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

This is second version of I2C bus registration helper.

http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/011860.html

Does changes suggested by David. Most important is that now
omap_register_i2c_bus takes also i2c_board_info argument. Function
omap_i2c_mux_pins is still here with minor H4 related modifications and with
updated comment.

Bus clock for osk and N800 are now configured for 400 kHz.

-- 
Jarkko
