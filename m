From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 2/4] omap: voltage: added mapping from voltagedomains to processor devices
Date: Wed, 31 Aug 2011 18:11:16 +0300
Message-ID: <1314803478-15634-3-git-send-email-t-kristo@ti.com>
References: <1314803478-15634-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41194 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab1HaPLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 11:11:50 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7VFBorl005021
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:50 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7VFBomj025330
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:50 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7VFBm4E023878
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:49 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1314803478-15634-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is needed so that SMPS regulators can be properly mapped to corresponding
processor devices.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.h                 |    2 ++
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 ++
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index b4c6259..bcbf0c0 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -53,6 +53,7 @@ struct omap_vfsm_instance {
 /**
  * struct voltagedomain - omap voltage domain global structure.
  * @name: Name of the voltage domain which can be used as a unique identifier.
+ * @proc_dev: Name of the associated processor device / hwmod.
  * @scalable: Whether or not this voltage domain is scalable
  * @node: list_head linking all voltage domains
  * @pwrdm_node: list_head linking all powerdomains in this voltagedomain
@@ -63,6 +64,7 @@ struct omap_vfsm_instance {
  */
 struct voltagedomain {
 	char *name;
+	char *proc_dev;
 	bool scalable;
 	struct list_head node;
 	struct list_head pwrdm_list;
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index b0d0ae1..28f1908 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -45,6 +45,7 @@ static const struct omap_vfsm_instance omap3_vdd2_vfsm = {
 
 static struct voltagedomain omap3_voltdm_mpu = {
 	.name = "mpu_iva",
+	.proc_dev = "mpu.0",
 	.scalable = true,
 	.read = omap3_prm_vcvp_read,
 	.write = omap3_prm_vcvp_write,
@@ -56,6 +57,7 @@ static struct voltagedomain omap3_voltdm_mpu = {
 
 static struct voltagedomain omap3_voltdm_core = {
 	.name = "core",
+	.proc_dev = "l3_main.0",
 	.scalable = true,
 	.read = omap3_prm_vcvp_read,
 	.write = omap3_prm_vcvp_write,
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index c4584e9..10c1d66 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -46,6 +46,7 @@ static const struct omap_vfsm_instance omap4_vdd_core_vfsm = {
 
 static struct voltagedomain omap4_voltdm_mpu = {
 	.name = "mpu",
+	.proc_dev = "mpu.0",
 	.scalable = true,
 	.read = omap4_prm_vcvp_read,
 	.write = omap4_prm_vcvp_write,
@@ -57,6 +58,7 @@ static struct voltagedomain omap4_voltdm_mpu = {
 
 static struct voltagedomain omap4_voltdm_iva = {
 	.name = "iva",
+	.proc_dev = "iva.0",
 	.scalable = true,
 	.read = omap4_prm_vcvp_read,
 	.write = omap4_prm_vcvp_write,
@@ -68,6 +70,7 @@ static struct voltagedomain omap4_voltdm_iva = {
 
 static struct voltagedomain omap4_voltdm_core = {
 	.name = "core",
+	.proc_dev = "l3_main_1.0",
 	.scalable = true,
 	.read = omap4_prm_vcvp_read,
 	.write = omap4_prm_vcvp_write,
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

