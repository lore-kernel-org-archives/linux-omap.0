From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] 3430 clock: minor cleanup patches
Date: Tue, 04 Dec 2007 02:26:05 -0700
Message-ID: <20071204092605.831497615@pwsan.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

These patches clean up a few minor issues with the OMAP3430 clock
framework.  They:

- ensure that the System Control Module is enabled at clock framework init;

- combine some redundant clksel_rate structures;

- add the ICR clock, present on both 3430ES versions in chassis mode; and

- resolve the "Enable for xxx without enable code" warnings that
  appear in 3430 bootlog.


Boot-tested on 3430ES1 SDP.  Comments welcome.


- Paul


diffstat:

 arch/arm/mach-omap2/clock34xx.h |  128 +++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 52 deletions(-)

size:

   text    data     bss     dec     hex filename
2885268  147008   96280 3128556  2fbcec vmlinux.3430sdp.orig
2885164  147088   96280 3128532  2fbcd4 vmlinux.3430sdp.patched
