From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] remoteproc: fix off-by-one bug in __rproc_free_vrings
Date: Sun, 13 May 2012 23:14:36 +0300
Message-ID: <1336940076-6317-1-git-send-email-ohad@wizery.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>
List-Id: linux-omap@vger.kernel.org

From: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>

Fix a nasty off-by-one bug in __rproc_free_vrings which
resulted in a memory leak and (for some platforms) failures
to reload the remote processor.

Signed-off-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
[ohad@wizery.com: reword commit log, stick with the for loop]
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/remoteproc_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ee15c68..e756a0d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -354,7 +354,7 @@ static void __rproc_free_vrings(struct rproc_vdev *rvdev, int i)
 {
 	struct rproc *rproc = rvdev->rproc;
 
-	for (i--; i > 0; i--) {
+	for (i--; i >= 0; i--) {
 		struct rproc_vring *rvring = &rvdev->vring[i];
 		int size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
 
-- 
1.7.5.4
