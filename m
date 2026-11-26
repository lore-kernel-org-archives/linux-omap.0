Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707946;
	b=m6y17ieiMJEIsRcsvG/bCpupLbaagc482eIELoPn5mylKLoryEYD7nFOmumHZ5DcbNKk
	 2ZlEbOphNQUxD1LJwhxn5K1K9K+RzFrKD0P1QWQ5kpfmD4csdpXfbA/8PFj63kHWJ/52y
	 inpxXFXHJGGgSt1XUTaZ/LzPwgjU00+OChzzTKgbz39J+1VTXkIHNQGybJrm850d5TjWF
	 WbSGh4LdtnF+IYsScS75/3IDwkNHnGemn6RGrhrOq9DbJ6leYQlsLIwY8XC80CChaeOwN
	 MEbFWlvha+dq65y/cWBjbRFFQF6rEm/+HDeuJ0t4tKdAwsuOEPcvbC4dpjUPu6NPM7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707946;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=PwFIKKz2y8o67G3ho/5uV17TqwfSzdRIlKLB5lCSaiU=;
	b=vt5OAgOW4PkEFTD34WDadjnDysAFej84cfWcGjFyBOB6N3ZazivndpehwnRhPadT7uWR
	 DXrmg73c/euZZ9EJsqp9UEOnSDv59Y/1Oc0Oh+qhjCPxJa63JbzwBtuTREAkCnN0Z1/+z
	 jq0CN9pEkZLKDEkl/sPiYcIJGvV//V1bEmXctZHd+VEL6M4LV56XUOK/c3yxTh8a/wOMN
	 aSXgKewV+I2uWT3MShyLDe61lrzSrjIWq7J+MJs+c6D8ei4IkxtgL+AueQ8fOCSmrMQ0L
	 JfBei95X5XNTLjYqbOU3+4CC66nJuBTbmp1gmhDnapf7gtMP7wCbcxF1SrmJnCwITPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=SE7nzdeu;
	arc=none smtp.remote-ip=185.136.65.226
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797C606A681
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2026 15:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6797C606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=SE7nzdeu
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026112615453531bd911d0c000207e8
        for <linux-omap@vger.kernel.org>;
        Thu, 26 Nov 2026 16:45:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PwFIKKz2y8o67G3ho/5uV17TqwfSzdRIlKLB5lCSaiU=;
 b=SE7nzdeuQnGTNL7AVbj8uWe8INuBujuA0BQdmMPl3FMwxkybIlsNdHvBvIQAfnLT11eUun
 I25RoOyN9dhZRpvzBJ6jPJxuGAh7LibcphY6FS94ojXNe9+qLg+32oocjKZ43grS4W/vBgcN
 QYRBnv77tTQQSD8xDNmHpdzAqOyqniPKweTxRaHk3m7X00YW7Vhuqxe+jO5XgarFJH0GA89i
 gHFgIU24WOnCJQTyFIsOYRCxctLZyXm/7WNThL0nAfXKDj/hgWWrXL8aDX1d1xbPOt5nLbB0
 RVbCJZlCl0H1T4Re/P4X8IUzxcOLMLhnGxiP+SwFH5bl5ueopfHL24jQ==;
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
Subject: [PATCH v2 2/4] pinctrl: single: Don't remove deduplicated groups and functions on error
Date: Thu, 26 Nov 2026 16:45:23 +0100
Message-ID: <20261126154529.1599568-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20261126154529.1599568-1-alexander.sverdlin@siemens.com>
References: <20261126154529.1599568-1-alexander.sverdlin@siemens.com>
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

