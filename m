From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Thu, 12 May 2011 12:58:41 -0700
Message-ID: <20110512195841.GA13651@google.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:40189 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975Ab1ELT6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 15:58:48 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, May 13, 2011 at 12:46:17AM +0530, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: Menon, Nishanth 
...
> > Last I tried, with Vishwa's dvfs branch on panda without voltage
> > registrations, things could crash :( if I get some time I will try to
> > port Vishwa's series onto kevin's branch as well and test and provide
> > any patches necessary.
> 
> [sp] I can try this on Panda. Will be able to get one tomorrow.

In case it helps, below is what I use for Panda.

---
ARM: OMAP2 voltage: Don't die if board does not register voltage params

This allows the DVFS patches to boot on boards not yet modified to
register voltage params.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/mach-omap2/voltage.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index dbc1cfe..8f23d95 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -617,6 +617,12 @@ static void __init omap4_vc_init(struct omap_vdd_info *vdd)
 	struct clk *sys_ck;
 	u32 sys_clk_speed;
 
+	if (!vdd->board_data) {
+		pr_warning("%s: No voltage board params registered for vdd_%s\n",
+			   __func__, vdd->voltdm.name);
+		return;
+	}
+
 	sys_ck = clk_get(NULL, "sys_clkin_ck");
 	if (IS_ERR(sys_ck)) {
 		pr_warning("%s: Could not get the sys clk to calculate"
-- 
1.7.3.1


