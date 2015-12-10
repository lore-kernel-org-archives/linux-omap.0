From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3] PCI: hosts: mark pcie/pci (msi) irq cascade handler as IRQF_NO_THREAD
Date: Thu, 10 Dec 2015 21:18:20 +0200
Message-ID: <1449775100-30877-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Richard Zhu <Richard.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Pratyush Anand <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On -RT and if kernel is booting with "threadirqs" cmd line parameter
pcie/pci (msi) irq cascade handlers (like dra7xx_pcie_msi_irq_handler()=
)
will be forced threaded and, as result, will generate warnings like:

WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_per=
cpu+0x14c/0x174()
irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts
Backtrace:
 (warn_slowpath_common) from [<c0043758>] (warn_slowpath_fmt+0x38/0x40)
 (warn_slowpath_fmt) from [<c0085fd0>] (handle_irq_event_percpu+0x14c/0=
x174)
 (handle_irq_event_percpu) from [<c008607c>] (handle_irq_event+0x84/0xb=
8)
 (handle_irq_event) from [<c0089240>] (handle_simple_irq+0x90/0x118)
 (handle_simple_irq) from [<c0085514>] (generic_handle_irq+0x30/0x44)
 (generic_handle_irq) from [<c034a7d4>] (dra7xx_pcie_msi_irq_handler+0x=
7c/0x8c)
 (dra7xx_pcie_msi_irq_handler) from [<c0086f08>] (irq_forced_thread_fn+=
0x28/0x5c)
 (irq_forced_thread_fn) from [<c00871dc>] (irq_thread+0x128/0x204)

This happens because all of them invoke generic_handle_irq() from the
requsted handler. generic_handle_irq grabs raw_locks and this needs to
run in raw-irq context.

This issue was originally reproduced on TI dra7-evem, but, as was
identified during dicussion [1], other PCI(e) hosts can also suffer
from this issue. So let's fix all them at once and mark pcie/pci (msi)
irq cascade handlers IRQF_NO_THREAD explicitly.

[1] https://lkml.org/lkml/2015/11/20/356

Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Richard Zhu <Richard.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Pratyush Anand <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: "S=C3=B6ren Brinkmann" <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
Changes in v3:
 - change applied to all affected pci(e) host drivers in drivers/pci/ho=
sts.
   After some invsetigation I've decided to not touch arch code - it is=
 not easy
   to identify all places which need to be fixed.=20
   if it's still required - i can send separate patches for=20
   arch/mips/pci/msi-octeon.c and arch/sparc/kernel/pci_msi.c.
Links
v2: https://lkml.org/lkml/2015/11/20/356
v1: https://lkml.org/lkml/2015/11/5/593
ref: https://lkml.org/lkml/2015/11/3/660

 drivers/pci/host/pci-dra7xx.c     | 13 ++++++++++++-
 drivers/pci/host/pci-exynos.c     |  3 ++-
 drivers/pci/host/pci-imx6.c       |  3 ++-
 drivers/pci/host/pci-tegra.c      |  2 +-
 drivers/pci/host/pcie-rcar.c      |  6 ++++--
 drivers/pci/host/pcie-spear13xx.c |  3 ++-
 drivers/pci/host/pcie-xilinx.c    |  3 ++-
 7 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7x=
x.c
index 8c36880..0415192 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -301,8 +301,19 @@ static int __init dra7xx_add_pcie_port(struct dra7=
xx_pcie *dra7xx,
 		return -EINVAL;
 	}
=20
+	/*
+	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
+	 * On -RT and if kernel is booting with "threadirqs" cmd line paramet=
er
+	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
+	 * in the same time, it's IRQ dispatcher and calls generic_handle_irq=
(),
+	 * which, in turn, will be resolved to handle_simple_irq() call.
+	 * The handle_simple_irq() expected to be called with IRQ disabled, a=
s
+	 * result kernle will display warning:
+	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
+	 */
 	ret =3D devm_request_irq(&pdev->dev, pp->irq,
-			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
+			       dra7xx_pcie_msi_irq_handler,
+			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "dra7-pcie-msi",	pp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exyno=
s.c
index 01095e1..d997d22 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -522,7 +522,8 @@ static int __init exynos_add_pcie_port(struct pcie_=
port *pp,
=20
 		ret =3D devm_request_irq(&pdev->dev, pp->msi_irq,
 					exynos_pcie_msi_irq_handler,
-					IRQF_SHARED, "exynos-pcie", pp);
+					IRQF_SHARED | IRQF_NO_THREAD,
+					"exynos-pcie", pp);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request msi irq\n");
 			return ret;
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 22e8224..9ce7cd1 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -537,7 +537,8 @@ static int __init imx6_add_pcie_port(struct pcie_po=
rt *pp,
=20
 		ret =3D devm_request_irq(&pdev->dev, pp->msi_irq,
 				       imx6_pcie_msi_handler,
-				       IRQF_SHARED, "mx6-pcie-msi", pp);
+				       IRQF_SHARED | IRQF_NO_THREAD,
+				       "mx6-pcie-msi", pp);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request MSI irq\n");
 			return ret;
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.=
c
index 3018ae5..3032311 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1288,7 +1288,7 @@ static int tegra_pcie_enable_msi(struct tegra_pci=
e *pcie)
=20
 	msi->irq =3D err;
=20
-	err =3D request_irq(msi->irq, tegra_pcie_msi_irq, 0,
+	err =3D request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
 			  tegra_msi_irq_chip.name, pcie);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.=
c
index f4fa6c5..414c336 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -720,14 +720,16 @@ static int rcar_pcie_enable_msi(struct rcar_pcie =
*pcie)
=20
 	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
 	err =3D devm_request_irq(&pdev->dev, msi->irq1, rcar_pcie_msi_irq,
-			       IRQF_SHARED, rcar_msi_irq_chip.name, pcie);
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       rcar_msi_irq_chip.name, pcie);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
 		goto err;
 	}
=20
 	err =3D devm_request_irq(&pdev->dev, msi->irq2, rcar_pcie_msi_irq,
-			       IRQF_SHARED, rcar_msi_irq_chip.name, pcie);
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       rcar_msi_irq_chip.name, pcie);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
 		goto err;
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-=
spear13xx.c
index b95b756..a6cd823 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -279,7 +279,8 @@ static int spear13xx_add_pcie_port(struct pcie_port=
 *pp,
 		return -ENODEV;
 	}
 	ret =3D devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
-			       IRQF_SHARED, "spear1340-pcie", pp);
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       "spear1340-pcie", pp);
 	if (ret) {
 		dev_err(dev, "failed to request irq %d\n", pp->irq);
 		return ret;
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xil=
inx.c
index 3c7a0d5..4cfa463 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -781,7 +781,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_=
port *port)
=20
 	port->irq =3D irq_of_parse_and_map(node, 0);
 	err =3D devm_request_irq(dev, port->irq, xilinx_pcie_intr_handler,
-			       IRQF_SHARED, "xilinx-pcie", port);
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       "xilinx-pcie", port);
 	if (err) {
 		dev_err(dev, "unable to request irq %d\n", port->irq);
 		return err;
--=20
2.6.4
