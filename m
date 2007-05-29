From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: RFC PATCH
Date: Tue, 29 May 2007 15:02:31 +0300
Message-ID: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
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

The following patch series is a work in progress and we have a lot to fix.
But still, it fixes some issues and implement some nice features.

TODO:
SRP should be automatic
Vbus should be turned off if we're not using the bus.
mdelay() should be fixed
0008-*.diff shouldn't be applied is just a way to run the HSET tests from linux
0010-*.diff leave GPIO[7:6] pullups enabled as they're the default wake-up source for tusb6010
            Without this patch we can't turn on Vbus if there's any load between Vbus and GND

I think that's all. Hope anyone can test/comment on this patch series.



felipebalbi@users.sourceforge.net
