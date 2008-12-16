From: Jean Pihet <jpihet@mvista.com>
Subject: [RFC/PATCH] OMAP: MMC: recover from transfer failures
Date: Tue, 16 Dec 2008 19:57:37 +0100
Message-ID: <200812161957.37854.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ho/RJoRbX6hc/88"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:46920 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYLPS5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 13:57:39 -0500
Received: from ip6-localhost (asshur.mvista.com [10.0.0.11])
	by hermes.mvista.com (Postfix) with ESMTP id D819618741
	for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2008 10:57:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--Boundary-00=_ho/RJoRbX6hc/88
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Here is a patch that fixes a MMC host controller deadlock. The problem happ=
ens=20
when removing the MMC/SD device when a transfer is on-going.

It has been tested on OMAP3430 but this fix should apply to OMAP2 chips as=
=20
well, as seen from the TRMs.

    OMAP: MMC: recover from transfer failures

    Timeouts during a command that has a data phase can result in the
    next command issued after the command that failed not being processed,
    i.e. no interrupt ever occurs to indicate the command has completed.
    This failure can result in a deadlock.

    The indication that the mmc host controller is in this error state is
    that the DATI bit is set in the PSTATE register.  This patch checks
    to see if the DATI bit is set before starting a new command, and if it
    is set it resets the data state machine to clear the error.

    Tested on OMAP3430 chip and intensive MMC/SD device removal while
    transferring data.

Regards,
Jean


=46rom 48a40925a4d57f6e7e45809a4b5c09b20f9314d7 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Tue, 16 Dec 2008 19:44:12 +0100
Subject: [PATCH] OMAP: MMC: recover from transfer failures

Timeouts during a command that has a data phase can result in the
next command issued after the command that failed not being processed,
i.e. no interrupt ever occurs to indicate the command has completed.
This failure can result in a deadlock.

The indication that the mmc host controller is in this error state is
that the DATI bit is set in the PSTATE register.  This patch checks
to see if the DATI bit is set before starting a new command, and if it
is set it resets the data state machine to clear the error.

Tested on OMAP3430 chip and intensive MMC/SD device removal while
transferring data.

Signed-off-by: Andy Lowe <alowe@mvista.com>
Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 drivers/mmc/host/omap_hsmmc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1fcc544..b7d111e 100644
=2D-- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -44,6 +44,7 @@
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -89,6 +90,7 @@
 #define DUAL_VOLT_OCR_BIT	7
 #define SRC			(1 << 25)
 #define SRD			(1 << 26)
+#define DATI			(1 << 1)
=20
 /*
  * FIXME: Most likely all the data using these _DEVID defines should come
@@ -273,6 +275,15 @@ mmc_omap_start_command(struct mmc_omap_host *host, str=
uct=20
mmc_command *cmd,
 		mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
 	host->cmd =3D cmd;
=20
+	if (OMAP_HSMMC_READ(host->base, PSTATE) & DATI) {
+		dev_dbg(mmc_dev(host->mmc), "mmc_omap_start_command: "
+			" resetting data state machine\n");
+		OMAP_HSMMC_WRITE(host->base, SYSCTL,
+			OMAP_HSMMC_READ(host->base, SYSCTL) | SRD);
+		while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD)
+			;
+	}
+
 	/*
 	 * Clear status bits and enable interrupts
 	 */
=2D-=20
1.5.4.4.21.gc4a6c


--Boundary-00=_ho/RJoRbX6hc/88
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="OMAP-MMC-recover-from-transfer-failures.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="OMAP-MMC-recover-from-transfer-failures.patch"

=46rom 48a40925a4d57f6e7e45809a4b5c09b20f9314d7 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Tue, 16 Dec 2008 19:44:12 +0100
Subject: [PATCH] OMAP: MMC: recover from transfer failures

Timeouts during a command that has a data phase can result in the
next command issued after the command that failed not being processed,
i.e. no interrupt ever occurs to indicate the command has completed.
This failure can result in a deadlock.

The indication that the mmc host controller is in this error state is
that the DATI bit is set in the PSTATE register.  This patch checks
to see if the DATI bit is set before starting a new command, and if it
is set it resets the data state machine to clear the error.

Tested on OMAP3430 chip and intensive MMC/SD device removal while
transferring data.

Signed-off-by: Andy Lowe <alowe@mvista.com>
Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 drivers/mmc/host/omap_hsmmc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1fcc544..b7d111e 100644
=2D-- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -44,6 +44,7 @@
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -89,6 +90,7 @@
 #define DUAL_VOLT_OCR_BIT	7
 #define SRC			(1 << 25)
 #define SRD			(1 << 26)
+#define DATI			(1 << 1)
=20
 /*
  * FIXME: Most likely all the data using these _DEVID defines should come
@@ -273,6 +275,15 @@ mmc_omap_start_command(struct mmc_omap_host *host, str=
uct mmc_command *cmd,
 		mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
 	host->cmd =3D cmd;
=20
+	if (OMAP_HSMMC_READ(host->base, PSTATE) & DATI) {
+		dev_dbg(mmc_dev(host->mmc), "mmc_omap_start_command: "
+			" resetting data state machine\n");
+		OMAP_HSMMC_WRITE(host->base, SYSCTL,
+			OMAP_HSMMC_READ(host->base, SYSCTL) | SRD);
+		while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD)
+			;
+	}
+
 	/*
 	 * Clear status bits and enable interrupts
 	 */
=2D-=20
1.5.4.4.21.gc4a6c


--Boundary-00=_ho/RJoRbX6hc/88--
