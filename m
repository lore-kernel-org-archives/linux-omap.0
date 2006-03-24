From: "andrzej zaborowski" <balrog@zabor.org>
Subject: [PATCH] fix MMC response types
Date: Fri, 24 Mar 2006 21:37:34 +0100
Message-ID: <fb249edb0603241237l5854cc04k@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4630_28572531.1143232654551"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_4630_28572531.1143232654551
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

UHJldmlvdXNseSB0aGUgTU1DL1NEIHByb3RvY29sIGxheWVyIGRpZG4ndCBwcm92aWRlIGNvbW1h
bmQgYW5kCnJlc3BvbnNlIHR5cGVzIHRvIG1tY19vbWFwX3N0YXJ0X2NvbW1hbmQoKS4gSW4gMi42
LjE2IGl0IGRvZXMgYW5kIHRoZQpoYWNrIHRoYXQgdHJpZXMgdG8gZmluZCB0aGUgY29ycmVjdCBj
b21tYW5kL3Jlc3BvbnNlIHR5cGVzIGJhc2VkIG9uCmZsYWdzIGlzIG5vIGxvbmdlciBuZWVkZWQu
ClRoaXMgbWF0dGVycyBwYXJ0aWN1bGFybHkgZm9yIHJlc3BvbnNlIHR5cGVzIGJlY2F1c2UgZm9y
IGNvbW1hbmQgdHlwZXMKdGhpcyBoYWNrIHdvcmtlZCBmaW5lLCB3aGlsZSBpdCBmYWlsZWQgdG8g
Z2l2ZSBjb3JyZWN0IHJlc3BvbnNlIHR5cGUKZm9yIHNvbWUgU0QgY29tbWFuZHMgc3VjaCBhcyBD
TUQzIChpbiBtb3N0IGNhc2VzIHRoaXMgY2F1c2VkIG5vIGJpZwpwcm9ibGVtcyBiZWNhdXNlIHRo
ZSBzaXplIG9mIHRoZSByZXNwb25zZSBtYXRjaGVkKS4KUmVnYXJkcywKQW5kcnplagotLQpiYWxy
b2cgMm9vNgoKRGVhciBPdXRsb29rIHVzZXJzOiBQbGVhc2UgcmVtb3ZlIG1lIGZyb20geW91ciBh
ZGRyZXNzIGJvb2tzCmh0dHA6Ly93d3cubmV3c2ZvcmdlLmNvbS9hcnRpY2xlLnBsP3NpZD0wMy8w
OC8yMS8xNDMyNTgK
------=_Part_4630_28572531.1143232654551
Content-Type: application/octet-stream; name=omap-mmcsd.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_el6xqnfo
Content-Disposition: attachment; filename="omap-mmcsd.patch"

diff -pNaur linux-omap-2.6-orig/drivers/mmc/omap.c linux-omap-2.6/drivers/mmc/omap.c
--- linux-omap-2.6-orig/drivers/mmc/omap.c	2006-03-22 17:44:41.000000000 +0000
+++ linux-omap-2.6/drivers/mmc/omap.c	2006-03-22 21:34:36.000000000 +0000
@@ -185,39 +185,38 @@ mmc_omap_start_command(struct mmc_omap_h
 		host->hw_bus_mode = host->bus_mode;
 	}
 
-	if (!(cmd->flags & MMC_RSP_PRESENT))
-		resptype = 0;			/* Resp 0 */
-
-	if (cmd->flags & MMC_RSP_136)
-		resptype = 2;			/* Resp 2 */
-	else {
-		if (host->bus_mode == MMC_BUSMODE_OPENDRAIN)
-			resptype = 3;		/* Resp 3 */
-		else
-			resptype = 1;		/* Resp 1, Resp 1b */
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_NONE:
+		/* Response type 0 */
+		break;
+	case MMC_RSP_R1:
+	case MMC_RSP_R1B:
+		resptype = 1;
+		break;
+	case MMC_RSP_R2:
+		resptype = 2;
+		break;
+	case MMC_RSP_R3:
+		resptype = 3;
+		break;
+	case MMC_RSP_R6:
+		resptype = 6;
+		break;
 	}
 
-	/* Protocol layer does not provide command type, but our hardware
-	 * needs it!
-	 * any data transfer means adtc type (but that information is not
-	 * in command structure, so we flagged it into host struct.)
-	 * However, telling bc, bcr and ac apart based on response is
-	 * not foolproof:
-	 * CMD0  = bc  = resp0  CMD15 = ac  = resp0
-	 * CMD2  = bcr = resp2  CMD10 = ac  = resp2
-	 *
-	 * Resolve to best guess with some exception testing:
-	 * resp0 -> bc, except CMD15 = ac
-	 * rest are ac, except if opendrain
-	 */
-	if (host->data) {
+	switch (cmd->flags & MMC_CMD_MASK) {
+	case MMC_CMD_AC:
+		cmdtype = OMAP_MMC_CMDTYPE_AC;
+		break;
+	case MMC_CMD_ADTC:
 		cmdtype = OMAP_MMC_CMDTYPE_ADTC;
-	} else if (resptype == 0 && cmd->opcode != 15) {
+		break;
+	case MMC_CMD_BC:
 		cmdtype = OMAP_MMC_CMDTYPE_BC;
-	} else if (host->bus_mode == MMC_BUSMODE_OPENDRAIN) {
+		break;
+	case MMC_CMD_BCR:
 		cmdtype = OMAP_MMC_CMDTYPE_BCR;
-	} else {
-		cmdtype = OMAP_MMC_CMDTYPE_AC;
+		break;
 	}
 
 	cmdreg = cmd->opcode | (resptype << 8) | (cmdtype << 12);







------=_Part_4630_28572531.1143232654551
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_4630_28572531.1143232654551--
