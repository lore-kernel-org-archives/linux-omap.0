From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] ARM: OMAP2: remove useless variable 'ret'
Date: Wed, 21 Aug 2013 16:31:02 +0800
Message-ID: <52147AC6.9040300@asianux.com>
References: <521479B4.8030604@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <521479B4.8030604@asianux.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Remove useless variable 'ret', the related warning:

  arch/arm/mach-omap2/board-am3517crane.c:113:6: warning: unused variable =
=91ret=92 [-Wunused-variable]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/=
board-am3517crane.c
index fc53911..0d499a1 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -110,8 +110,6 @@ static void __init am3517_crane_i2c_init(void)
 =

 static void __init am3517_crane_init(void)
 {
-	int ret;
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-- =

1.7.7.6
