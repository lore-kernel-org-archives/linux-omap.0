From: jarkko.nikula@nokia.com
Subject: [PATCH/RFC 0/3] I2C bus registration helper
Date: Fri,  2 Nov 2007 15:46:28 +0200
Message-ID: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I was recently looking how we register I2C busses for different OMAPs &
boards and it looked somewhat confusing to me :-)

Currently registration is done in various places:
plat-omap/devices.c, mach-omap2/devices.c and also in each board file
which wants to use different I2C clock rate than 100 kHz (e.g 2430sdp).

So I came up the idea that this should be simplified and to be more flexible
related to clock rates and number of busses configured.

Idea is in patch 1, patch 2 takes it into use and modifies those board files
which are already in mainline. Helper should cover all OMAP generations
from 1 to 3.

Note that this is tested shortly on N800 only. Yep, not even compile tested
for other OMAP platforms or boards :-)

Comments and test reports are welcome.

-- 
Jarkko
