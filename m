From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 00/19] Runtime PM fixes for omap-ssi
Date: Sat, 18 Jun 2016 18:26:50 +0200
Message-ID: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series fixes runtime PM for omap-ssi, so that
the OMAP SoC can idle correctly. After applying the
series, the SSI module correctly goes into idle if
phonet0 interface is not configured or if it's
used by ofono (*). Apart from me Pavel Machek did
some testing of my devel branch [0] and reported,
that he was able to get the phone into full idle.

Note: I did my testing with kernel flashing over USB, so
idle is broken. But I found the bit in cm_idlest1_core,
that stands for SSI blocking status: 0x00800000 (documented
as "reserved" in the public TRM).

(*) "ifconfig phonet0 up" will result in blocking ssi module
    until modem setup has finished (data communication via
	phonet0 device), since it enables ssi wakelines.

[0] https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=runtime-pm-fixes

-- Sebastian

Sebastian Reichel (19):
  HSI: omap_ssi_port: remove useless newline
  HSI: omap_ssi: do not reset module
  HSI: ssi_protocol: avoid ssi_waketest call with held spinlock
  HSI: ssi_protocol: replace spin_lock with spin_lock_bh
  HSI: ssi_protocol: fix ssip_xmit invocation
  HSI: omap_ssi: convert cawake irq handler to thread
  HSI: omap_ssi_port: replace wkin_cken with atomic bitmap operations
  HSI: core: switch port event notifier from atomic to blocking
  HSI: omap_ssi_port: prepare start_tx/stop_tx for blocking pm_runtime
    calls
  HSI: omap_ssi_core: use pm_runtime_put instead of pm_runtime_put_sync
  HSI: omap_ssi_core: remove pm_runtime_get_sync call from tasklet
  HSI: omap_ssi_port: switch to threaded pio irq
  HSI: omap_ssi_port: avoid pm_runtime_get_sync in ssi_start_dma and
    ssi_start_pio
  HSI: omap_ssi_port: avoid calling runtime_pm_*_sync inside spinlock
  HSI: omap_ssi_port: replace pm_runtime_put_sync with non-sync variant
  HSI: omap_ssi_port: ensure clocks are kept enabled during transfer
  HSI: omap_ssi: call msg->complete() from process context
  HSI: omap_ssi_port: use rpm autosuspend API
  HSI: omap_ssi: drop pm_runtime_irq_safe

 drivers/hsi/clients/ssi_protocol.c      | 110 +++++++++-------
 drivers/hsi/controllers/omap_ssi.h      |  18 +--
 drivers/hsi/controllers/omap_ssi_core.c |  46 +++----
 drivers/hsi/controllers/omap_ssi_port.c | 226 ++++++++++++++++++--------------
 drivers/hsi/hsi_core.c                  |   8 +-
 include/linux/hsi/hsi.h                 |   2 +-
 6 files changed, 229 insertions(+), 181 deletions(-)

-- 
2.8.1
