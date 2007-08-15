From: Hingkwan Huen <hkh@cypress.com>
Subject: OMAP5912 OSK Boot
Date: Wed, 15 Aug 2007 12:47:31 -0700
Message-ID: <1187207251.8228.11.camel@debian.mis.cypress.com>
References: <1187186887430-git-send-email-felipe.lima@indt.org.br>
	<200708150913.58968.david-b@pacbell.net>
	<31e679430708150929v794b4a64h71e096f9f7c044e4@mail.gmail.com>
	<200708150944.28365.david-b@pacbell.net>
Reply-To: hkh@cypress.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200708150944.28365.david-b@pacbell.net>
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

Hi All,

I am having problem starting u-boot correctly for the OSK5912 whenever
it is connected to an external module on connector A (EMIFS) using the
nCS3. I've tried pulling MPU_BOOT to vcc and GPIO1 to gnd manually but
don't seem to help. Without plugging anything on connector A u-boot
starts correctly and it detects the flash correctly. Any ideas will be
very appreciated.

U-Boot 1.2.0 (Aug  7 2007 - 12:52:58)

CPU:   OMAP162123 at 96.0 MHz (DPLL1=96.0 MHz)
Board: OSK5912
DRAM:  32 MB
## Unknown FLASH on Bank 1 - Size = 0x00000000 = 0 MB
## Unknown FLASH on Bank 2 - Size = 0x00000000 = 0 MB
Flash:  0 kB
In:    serial
Out:   serial
Err:   serial
OMAP5912 OSK # 

Thanks,
kwan
