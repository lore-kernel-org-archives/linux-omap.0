From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/7] remoteproc: remoteproc_rpmsg -> remoteproc_virtio
Date: Thu,  1 Mar 2012 10:11:32 +0200
Message-ID: <1330589497-4139-3-git-send-email-ohad@wizery.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1330589497-4139-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Michal Simek <monstr@monstr.eu>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Arnd Bergmann <arnd@arndb.de>, Iliyan Malchev <malchev@google.com>, Brian Swetland <swetland@google.com>, Loic PALLARDY <loic.pallardy@stericsson.com>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic BARRE <ludovic.barre@stericsson.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Saravana Kannan <skannan@codeaurora.org>, Clark Rob <rob@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, Anna Suman <s-anna@ti.com>, Kieran Bingham <kieranbingham@gmail.com>, Mark Grosen <mgrosen@ti.com>, John Williams <john.williams@petalogix.com>, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

At this point remoteproc can only register a single VIRTIO_ID_RPMSG virtio
device.

This limitation is going away soon: remoteproc is getting support for
registering any number of virtio devices and of any type (as
published by the firmware of the remote processor).

Rename remoteproc_rpmsg.c to remoteproc_virtio.c in preparation of
this generalization work.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Brian Swetland <swetland@google.com>
Cc: Iliyan Malchev <malchev@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mark Grosen <mgrosen@ti.com>
Cc: John Williams <john.williams@petalogix.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Loic PALLARDY <loic.pallardy@stericsson.com>
Cc: Ludovic BARRE <ludovic.barre@stericsson.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Guzman Lugo Fernando <fernando.lugo@ti.com>
Cc: Anna Suman <s-anna@ti.com>
Cc: Clark Rob <rob@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Saravana Kannan <skannan@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Kieran Bingham <kieranbingham@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/remoteproc/Makefile                        |    2 +-
 .../{remoteproc_rpmsg.c => remoteproc_virtio.c}    |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename drivers/remoteproc/{remoteproc_rpmsg.c => remoteproc_virtio.c} (100%)

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index df0897f..5445d9b 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -5,5 +5,5 @@
 obj-$(CONFIG_REMOTEPROC)		+= remoteproc.o
 remoteproc-y				:= remoteproc_core.o
 remoteproc-y				+= remoteproc_debugfs.o
-remoteproc-y				+= remoteproc_rpmsg.o
+remoteproc-y				+= remoteproc_virtio.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
diff --git a/drivers/remoteproc/remoteproc_rpmsg.c b/drivers/remoteproc/remoteproc_virtio.c
similarity index 100%
rename from drivers/remoteproc/remoteproc_rpmsg.c
rename to drivers/remoteproc/remoteproc_virtio.c
-- 
1.7.5.4
