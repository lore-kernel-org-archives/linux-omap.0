From: jarkko.nikula@nokia.com
Subject: [PATCH 0/3] CBUS: retu-headset updates
Date: Wed, 31 Oct 2007 14:04:39 +0200
Message-ID: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
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

Some updates to retu-headset driver picked from internal tree. That's the only
reason why feature implemented in patch 2 is before fix in patch 3 :-)

Note about bias voltage: external mic doesn't need it while device is in
suspend (hard with sales HW due the watchdogs...) and this can save mA or so
the suspend current. However, button detection is kept active since it can
wake-up the system.

-- 
Jarkko
