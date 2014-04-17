From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 15/19] bus: omap_l3_noc: add information about the type of operation
Date: Thu, 17 Apr 2014 15:49:31 -0500
Message-ID: <1397767775-10965-16-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397767775-10965-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Today we get error such as
L3 Custom Error: MASTER MPU TARGET L4PER2

But since the actual instruction triggerring the error Vs the point
at which we report error may not be aligned, it makes sense to try
and provide additional information - example the type of operation
that was attempted to being performed can help narrow the debug down
further.

This helps provide log such as:
L3 Custom Error: MASTER MPU TARGET L4PER2 (Read)

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---

New patch

 drivers/bus/omap_l3_noc.c |    9 ++++++++-
 drivers/bus/omap_l3_noc.h |   13 +++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index e45b960..0beefb3 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -60,8 +60,10 @@ static int l3_handle_target(struct omap_l3 *l3, void __iomem *base,
 {
 	int k;
 	u32 std_err_main, clear, masterid;
+	u8 op_code;
 	void __iomem *l3_targ_base;
 	void __iomem *l3_targ_stderr, *l3_targ_slvofslsb, *l3_targ_mstaddr;
+	void __iomem *l3_targ_hdr;
 	struct l3_target_data *l3_targ_inst;
 	struct l3_masters_data *master;
 	char *target_name, *master_name = "UN IDENTIFIED";
@@ -96,6 +98,7 @@ static int l3_handle_target(struct omap_l3 *l3, void __iomem *base,
 			 readl_relaxed(l3_targ_slvofslsb));
 
 		l3_targ_mstaddr = l3_targ_base + L3_TARG_STDERRLOG_MSTADDR;
+		l3_targ_hdr = l3_targ_base + L3_TARG_STDERRLOG_HDR;
 		break;
 
 	case CUSTOM_ERROR:
@@ -103,6 +106,7 @@ static int l3_handle_target(struct omap_l3 *l3, void __iomem *base,
 
 		l3_targ_mstaddr = l3_targ_base +
 				  L3_TARG_STDERRLOG_CINFO_MSTADDR;
+		l3_targ_hdr = l3_targ_base + L3_TARG_STDERRLOG_CINFO_OPCODE;
 		break;
 
 	default:
@@ -126,11 +130,14 @@ static int l3_handle_target(struct omap_l3 *l3, void __iomem *base,
 		}
 	}
 
+	op_code = readl_relaxed(l3_targ_hdr) & 0x7;
+
 	WARN(true,
-	     "%s:L3 %s Error: MASTER %s TARGET %s%s\n",
+	     "%s:L3 %s Error: MASTER %s TARGET %s (%s)%s\n",
 	     dev_name(l3->dev),
 	     err_description,
 	     master_name, target_name,
+	     l3_transaction_type[op_code],
 	     err_string);
 
 	/* clear the std error log*/
diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
index 18cdc25..8efde7f 100644
--- a/drivers/bus/omap_l3_noc.h
+++ b/drivers/bus/omap_l3_noc.h
@@ -29,14 +29,27 @@
 
 /* L3 TARG register offsets */
 #define L3_TARG_STDERRLOG_MAIN		0x48
+#define L3_TARG_STDERRLOG_HDR		0x4c
 #define L3_TARG_STDERRLOG_MSTADDR	0x50
 #define L3_TARG_STDERRLOG_SLVOFSLSB	0x5c
 #define L3_TARG_STDERRLOG_CINFO_MSTADDR	0x68
+#define L3_TARG_STDERRLOG_CINFO_OPCODE	0x6c
 #define L3_FLAGMUX_REGERR0		0xc
 #define L3_FLAGMUX_MASK0		0x8
 
 #define L3_TARGET_NOT_SUPPORTED		NULL
 
+static const char * const l3_transaction_type[] = {
+	/* 0 0 0 */ "Idle",
+	/* 0 0 1 */ "Write",
+	/* 0 1 0 */ "Read",
+	/* 0 1 1 */ "ReadEx",
+	/* 1 0 0 */ "Read Link",
+	/* 1 0 1 */ "Write Non-Posted",
+	/* 1 1 0 */ "Write Conditional",
+	/* 1 1 1 */ "Write Broadcast",
+};
+
 /**
  * struct l3_masters_data - L3 Master information
  * @id:		ID of the L3 Master
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
