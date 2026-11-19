Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130898;
	b=4kcHJ7iyKe9xzVOipJh3Z++NFWCWFhC2KIS1Fcl5v6fU9JjZLPhzk2iWw961YPrDB1iF
	 0N9Lcxk/ktFRurLIVkVDN0654zHPyfuPbK2LibGcERufNrfW6cRjAOBTq2USTALu6h90S
	 omb72mljjE4kypKZm6AcUPHmS4wwVJSQy4dEe06QP6UiHLP65jPkm293/MFQ3ImhcNADJ
	 lnlquNhVhUfp/LMndmmABgZxJsnCU6fLX/zOSwBHrmOoTZBWQt5PBzWbzI2e6+g05n7G3
	 5yklN0DdW92EhNq9KmZtrdWuzsr2U3SxFt1eejBLJySu4Ey5YPpo4NcPDyhqUeKRBtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130898;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=PwFIKKz2y8o67G3ho/5uV17TqwfSzdRIlKLB5lCSaiU=;
	b=EvLNKGYEHTjn4eZgYMi8tqunECkQ89YTpkMci0eU5Ka82o6VmFq4N6U/cMjDmkq0T1UO
	 69eTyH2KTmmJdYCJFiht++T0utTI+gdbBUEduWYvvr0PBG55pAQyuxPi5zuN8l9xfA60e
	 lDhE6QgIW0UJH8UYutQJ5RTwDmze836ZnKvbUyrDK+ZlAl8DypBZAC0YU4YdEFc8IW4DE
	 xTGt/iTHXHYF/qns6Bh8iox9mbWKOTfjTxhoFcDCAjhoVZQ7bQ5y70/3pbh+TXhJ+0dvY
	 JQjO6ZRh//XnMQBAvayiOTdKEN9xCX6RTvXPjYcCrRnUvuuzkyG/8pIt113/hh5DedQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=HYxldIoX;
	arc=none smtp.remote-ip=185.136.65.225
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AB60A262E
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 23:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5AB60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=HYxldIoX
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026111923281067472d7ff40002077b
        for <linux-omap@vger.kernel.org>;
        Fri, 20 Nov 2026 00:28:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PwFIKKz2y8o67G3ho/5uV17TqwfSzdRIlKLB5lCSaiU=;
 b=HYxldIoXg+7andR2pdzZTPfbtAva6hOQI8vuq9L4AUnhuizEo1DibuO6PDqhvP2dyhVM06
 QWBkE95eo6+XzkciLfpB1rV1jJEDCq1U5aghnpF74CieyFoZv0eZwVYI5N2Ee3AIRC9cCzgA
 aSueLRcsfIZaHfRwfxOlxW2SaBRSn68ywpzeHsPp0FoiMfRch0VOLoJSF4T48Q8E1Aq8+441
 TpeKjtV7QdHDuAhTBQSQyC954Jr2JRPf/RPd1PHNCJuaEfAL7D5c/d4JJhCxFFssBEoD9FGQ
 xGntl+jC3gadQoH1rG865YGgyEBnCWw+7dvLD2gqz+CMTuBdDFkOtIhg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-gpio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 2/3] pinctrl: single: Don't remove deduplicated groups and functions on error
Date: Fri, 20 Nov 2026 00:28:04 +0100
Message-ID: <20261119232806.4093754-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20261119232806.4093754-1-alexander.sverdlin@siemens.com>
References: <20261119232806.4093754-1-alexander.sverdlin@siemens.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

pinctrl_generic_add_group() and pinmux_generic_add_function() return the
selector of an existing entry with the same name instead of adding a new
one. This is the normal case when a node is mapped again, e.g. on
consumer re-probe. If parsing then fails, the error paths of
pcs_parse_one_pinctrl_entry() and pcs_parse_bits_in_pinctrl_entry()
remove the group and function by that selector anyway, i.e. the entries
an earlier mapping is still using.

Besides breaking that mapping, this corrupts the selector space: the
selectors are allocated from num_groups/num_functions, which the removal
decrements, so the last entry is no longer found by name and the next new
entry collides with it in the radix tree (-EEXIST).

Only remove them if this call actually added them, i.e. if the core's
function refers to our pcs_function. As in the success path, testing the
function is enough: the group has the same name and is always added and
removed together with it.

Fixes: a4ab10860723 ("pinctrl: single: Fix group and function selector use")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 64472465800c4..f5f0b95dc4282 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1116,10 +1116,16 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	return 0;
 
 free_pingroups:
-	pinctrl_generic_remove_group(pcs->pctl, gsel);
+	/*
+	 * Only remove what we added, not an in-use deduplicated instance. The
+	 * group is deduplicated together with the function.
+	 */
+	if (pinmux_generic_get_function(pcs->pctl, fsel)->data == function)
+		pinctrl_generic_remove_group(pcs->pctl, gsel);
 	*num_maps = 1;
 free_function:
-	pinmux_generic_remove_function(pcs->pctl, fsel);
+	if (pinmux_generic_get_function(pcs->pctl, fsel)->data == function)
+		pinmux_generic_remove_function(pcs->pctl, fsel);
 free_pins:
 	mutex_unlock(&pcs->mutex);
 	devm_kfree(pcs->dev, pins);
@@ -1262,7 +1268,9 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 	return 0;
 
 free_function:
-	pinmux_generic_remove_function(pcs->pctl, fsel);
+	/* See pcs_parse_one_pinctrl_entry() */
+	if (pinmux_generic_get_function(pcs->pctl, fsel)->data == function)
+		pinmux_generic_remove_function(pcs->pctl, fsel);
 free_pins:
 	mutex_unlock(&pcs->mutex);
 	devm_kfree(pcs->dev, pins);
-- 
2.56.1

