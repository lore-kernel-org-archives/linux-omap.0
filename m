From: Komal Shah <komal_shah802003@yahoo.com>
Subject: old gpmc.h
Date: Tue, 8 Aug 2006 03:35:03 -0700 (PDT)
Message-ID: <20060808103503.98907.qmail@web37901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Tony,

It seems that gpmc.h is not updated after Imre patch about dynamic
allocator for GPMC. It gives me following error for h4 build.

arch/arm/mach-omap2/built-in.o(.init.text+0xae4): In function `$a':
: undefined reference to `gpmc_cs_request'
arch/arm/mach-omap2/built-in.o(.init.text+0xb48): In function `$a':
: undefined reference to `gpmc_cs_free'
arch/arm/mach-omap2/built-in.o(.init.text+0xb68): In function `$a':
: undefined reference to `gpmc_cs_request'
make: *** [.tmp_vmlinux1] Error 1

Please update gpmc.h as per Imre's patch. Thanx.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
