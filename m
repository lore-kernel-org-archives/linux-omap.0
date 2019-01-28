From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 054/304] ARM: OMAP2+: hwmod: Fix some section annotations
Date: Mon, 28 Jan 2019 10:39:31 -0500
Message-ID: <20190128154341.47195-54-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Nathan Chancellor <natechancellor@gmail.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit c10b26abeb53cabc1e6271a167d3f3d396ce0218 ]

When building the kernel with Clang, the following section mismatch
warnings appears:

WARNING: vmlinux.o(.text+0x2d398): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_iclk_autoidle()
The function _setup() references
the function __init _setup_iclk_autoidle().
This is often because _setup lacks a __init
annotation or the annotation of _setup_iclk_autoidle is wrong.

WARNING: vmlinux.o(.text+0x2d3a0): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_reset()
The function _setup() references
the function __init _setup_reset().
This is often because _setup lacks a __init
annotation or the annotation of _setup_reset is wrong.

WARNING: vmlinux.o(.text+0x2d408): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_postsetup()
The function _setup() references
the function __init _setup_postsetup().
This is often because _setup lacks a __init
annotation or the annotation of _setup_postsetup is wrong.

_setup is used in omap_hwmod_allocate_module, which isn't marked __init
and looks like it shouldn't be, meaning to fix these warnings, those
functions must be moved out of the init section, which this patch does.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 083dcd9942ce..921c9aaee63f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2413,7 +2413,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
  * a stub; implementing this properly requires iclk autoidle usecounting in
  * the clock code.   No return value.
  */
-static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
+static void _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
 
@@ -2444,7 +2444,7 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
  * reset.  Returns 0 upon success or a negative error code upon
  * failure.
  */
-static int __init _setup_reset(struct omap_hwmod *oh)
+static int _setup_reset(struct omap_hwmod *oh)
 {
 	int r;
 
@@ -2505,7 +2505,7 @@ static int __init _setup_reset(struct omap_hwmod *oh)
  *
  * No return value.
  */
-static void __init _setup_postsetup(struct omap_hwmod *oh)
+static void _setup_postsetup(struct omap_hwmod *oh)
 {
 	u8 postsetup_state;
 
-- 
2.19.1
