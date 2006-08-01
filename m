From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Pending July patches
Date: Tue, 01 Aug 2006 18:44:38 +0200
Message-ID: <44CF84F6.1000207@gmail.com>
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

my list of pending OMAP patches from July. Maybe its useful 
for someone.

Start:                07/01/2006
Last updated: 07/31/2006

1. [PATCH] fix PWL macro names
http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007503.html

2. [PATCH] ARM: OMAP: Fix missing channel using 
omap_set_dma_priority()
http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007508.html

Note: Needs check if channel 0 is really okay for OMAP24xx.

3. ARM: OMAP: omapfb: Fix 444 mode after recent LCD changes
http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007525.html

4. [PATCH] ARM: OMAP: omapfb: Add Amstrad Delta LCD driver
http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007526.html

5. 2420 boot BUG(): failure to map SRAM
http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007578.html

6.[PATCH] ARM: OMAP: mux: add config for 16xx SPI pins
http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007596.html

Please add, correct, comment if anything is wrong or 
missing. Are there any older patches pending?

Note that some patches from July were already applied to git 
by Imre (especially the omapfb/ads7846 stuff)

Cheers

Dirk
