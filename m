From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Compiler warning in omap-twl4030keypad.c
Date: Sun, 20 May 2007 09:51:50 +0200
Message-ID: <464FFE16.8020303@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Khasim,

we have a compiler warning in omap-twl4030keypad.c:

drivers/input/keyboard/omap-twl4030keypad.c: In function 'omap_kp_probe':
drivers/input/keyboard/omap-twl4030keypad.c:257: warning: assignment
from incompatible pointer type

Do you have a fix for this?

Cheers

Dirk
