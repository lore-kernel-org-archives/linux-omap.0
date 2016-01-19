From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] omap assembly fixes for CONFIG_DEBUG_RODATA
Date: Tue, 19 Jan 2016 09:48:49 -0800
Message-ID: <1453225734-16993-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Richard Woodruff <r-woodruff2@ti.com>, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are read-only data fixes for omaps discovered few weeks ago
with "[PATCH v2] ARM: mm: flip priority of CONFIG_DEBUG_RODATA"
that caused issues during deeper idle states on omaps [0].

Please review and test if possible. I'd like to merge these fixes
during v4.5-rc cycle to remove these blockers for making it possible
to have CONFIG_DEBUG_RODATA enabled by default.

Regards,

Tony


[0] https://lkml.org/lkml/2015/12/2/908

Tony Lindgren (5):
  ARM: OMAP2+: Fix wait_dll_lock_timed for rodata
  ARM: OMAP2+: Fix l2dis_3630 for rodata
  ARM: OMAP2+: Fix save_secure_ram_context for rodata
  ARM: OMAP2+: Fix l2_inv_api_params for rodata
  ARM: OMAP2+: Fix ppa_zero_params and ppa_por_params for rodata

 arch/arm/mach-omap2/sleep34xx.S | 60 ++++++++++++++++++++---------------------
 arch/arm/mach-omap2/sleep44xx.S | 25 +++++++++++------
 2 files changed, 47 insertions(+), 38 deletions(-)

-- 
2.7.0.rc3
