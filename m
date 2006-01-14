From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] fix linking
Date: Sat, 14 Jan 2006 02:12:15 -0800 (PST)
Message-ID: <20060114101215.50266.qmail@web32914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-270908975-1137233535=:48290"
Content-Transfer-Encoding: 8bit
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

--0-270908975-1137233535=:48290
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Patch fixes following error, which gets generated if you don't select
IrDA driver for H4.

arch/arm/mach-omap2/built-in.o(.text+0x1844): In function `$a':
: undefined reference to `read_gpio_expa'
arch/arm/mach-omap2/built-in.o(.text+0x186c): In function `$a':
: undefined reference to `write_gpio_expa'
arch/arm/mach-omap2/built-in.o(.text+0x18ac): In function `$a':
: undefined reference to `read_gpio_expa'
arch/arm/mach-omap2/built-in.o(.text+0x18e4): In function `$a':
: undefined reference to `write_gpio_expa'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-270908975-1137233535=:48290
Content-Type: text/plain; name="fix-linking.patch"
Content-Description: 1216354423-fix-linking.patch
Content-Disposition: inline; filename="fix-linking.patch"

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5788809..85cc78b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -19,4 +19,5 @@ config MACH_OMAP_GENERIC
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	select GPIOEXPANDER_OMAP	
 

--0-270908975-1137233535=:48290
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-270908975-1137233535=:48290--
