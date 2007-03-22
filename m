From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 0/4] TSC2301 update
Date: Thu, 22 Mar 2007 11:14:39 +0200
Message-ID: <20070322111439.00980a3c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

I remodified my previous TSC2301 monster update:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009368.html

I decided to separate only touchscreen and keyboard modules until
better place or conversion to SoC driver takes place for the audio part
of it.

So for an immediate step the tsc2301-core.c is still named as it is and
tsc2301-mixer.c is kept under drivers/spi. Short summary:

PATCH 1/4: Imre's fix to touchscreen
PATCH 2/4: Keypad and touchscreen separation including some minor fixes
PATCH 3/4: Unused code removal from tsc2301-mixer.c
PATCH 4/4: TSC2301 touchscreen config name update in board-n800.c


-- 
Jarkko
