From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] remoteproc fixes
Date: Sun, 17 Jun 2012 15:59:24 +0300
Message-ID: <CAK=WgbZ20XZKauhn98ncMYupCrLv_mGo-bhPV7L93NLpWGrC=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf=
2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/rproc-fixes-for-3.5

for you to fetch changes up to 6b03976288538a94e072bbfcd12d69a20daea8aa=
:

  remoteproc/omap: fix dev_err typo (2012-06-17 10:31:03 +0300)

----------------------------------------------------------------
A few relatively-small remoteproc fixes for 3.5: two error path fixes,
and one -Wformat warning fix.

----------------------------------------------------------------
Ohad Ben-Cohen (1):
      remoteproc/omap: fix dev_err typo

Sjur Br=E6ndeland (2):
      remoteproc: fix print format warnings
      remoteproc: fix missing fault indication in error-path

 drivers/remoteproc/omap_remoteproc.c |  2 +-
 drivers/remoteproc/remoteproc_core.c | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c
b/drivers/remoteproc/omap_remoteproc.c
index 69425c4..de138e30 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -182,7 +182,7 @@ static int __devinit omap_rproc_probe(struct
platform_device *pdev)

 	ret =3D dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
-		dev_err(pdev->dev.parent, "dma_set_coherent_mask: %d\n", ret);
+		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n", ret);
 		return ret;
 	}

diff --git a/drivers/remoteproc/remoteproc_core.c
b/drivers/remoteproc/remoteproc_core.c
index 8ea7bcc..66324ee 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -247,7 +247,7 @@ rproc_load_segments(struct rproc *rproc, const u8
*elf_data, size_t len)
 		}

 		if (offset + filesz > len) {
-			dev_err(dev, "truncated fw: need 0x%x avail 0x%x\n",
+			dev_err(dev, "truncated fw: need 0x%x avail 0x%zx\n",
 					offset + filesz, len);
 			ret =3D -EINVAL;
 			break;
@@ -934,7 +934,7 @@ static void rproc_resource_cleanup(struct rproc *rp=
roc)
 		unmapped =3D iommu_unmap(rproc->domain, entry->da, entry->len);
 		if (unmapped !=3D entry->len) {
 			/* nothing much to do besides complaining */
-			dev_err(dev, "failed to unmap %u/%u\n", entry->len,
+			dev_err(dev, "failed to unmap %u/%zu\n", entry->len,
 								unmapped);
 		}

@@ -1020,7 +1020,7 @@ static int rproc_fw_boot(struct rproc *rproc,
const struct firmware *fw)

 	ehdr =3D (struct elf32_hdr *)fw->data;

-	dev_info(dev, "Booting fw image %s, size %d\n", name, fw->size);
+	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);

 	/*
 	 * if enabling an IOMMU isn't relevant for this rproc, this is
@@ -1041,8 +1041,10 @@ static int rproc_fw_boot(struct rproc *rproc,
const struct firmware *fw)

 	/* look for the resource table */
 	table =3D rproc_find_rsc_table(rproc, fw->data, fw->size, &tablesz);
-	if (!table)
+	if (!table) {
+		ret =3D -EINVAL;
 		goto clean_up;
+	}

 	/* handle fw resources which are required to boot rproc */
 	ret =3D rproc_handle_boot_rsc(rproc, table, tablesz);
