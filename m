From: Dirk Behme <dirk.behme@googlemail.com>
Subject: innovator_ps2 broken
Date: Thu, 04 Jan 2007 18:09:29 +0100
Message-ID: <459D34C9.8060405@googlemail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

looks like innovator_ps2 is broken:

   CC [M]  drivers/input/keyboard/innovator_ps2.o
drivers/input/keyboard/innovator_ps2.c: In function 
'innovator_kbd_init':
drivers/input/keyboard/innovator_ps2.c:1225: warning: 
implicit declaration of function 'init_input_dev'
WARNING: "init_input_dev" 
[drivers/input/keyboard/innovator_ps2.ko] undefined!

Anybody with a patch for this? Or should we remove it?

Use make omap_innovator_1510_defconfig & make modules to 
reproduce.

Cheers

Dirk
