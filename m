Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266735C687;
	Fri, 14 Aug 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693935; cv=none; b=o7p9FRCmvXv1Gk3kNxDP5kLLw3a5HNpRPr2GZmFvmU/fGwCTuLkJfy1Z7CZALR7+JreUGlNz+QtYORDQ+iC85Clxag9629AhILxETLiWvH/b3jJm7rmCM7Nv9YR5KFT51LLZtR0m33iP+lG7S94SdtYD+X7Qn4S69jVOsbeKl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693935; c=relaxed/simple;
	bh=kMZWrHg+qIZgzVYtSGrLvRHZIfU2WQbM0McwGmdX8AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BOxgov1t3XaBMR0KC9SeR/xc2cDvH42XPutbFy+EhNFSk9/FAhb36RO51jY6KHLXqi9t0sjjMpR5Mux+j5b+X5HWjFdpxLBnRHZGkrVWiiPfNLDefnR3jeCWdICoG2ndH9C/B5o0gkkXgO78ZuRR24oOpO+oO4kYrPdOixeQVGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAC3ie0lyX5qaGieBQ--.63431S2;
	Fri, 14 Aug 2026 15:52:05 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Tony Lindgren <tony@atomide.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] bus: ti-pwmss: unwind child devices and runtime PM
Date: Fri, 14 Aug 2026 15:52:04 +0800
Message-ID: <20260814075204.10983-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3ie0lyX5qaGieBQ--.63431S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xuryktr1rXF43JryDGFg_yoW8AryUpF
	WxXa4Syr40g3y0kaykGr1fu3W5Way3ta48Ka4rGw4rZ34aqr1Utr1rtF1jvF4rJFWvkw4x
	Zrs8tFs7Ar45CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU0VbkUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

pwmss_probe() enables runtime PM before populating child devices. If
population partially succeeds and then fails, probe leaves both the
children and runtime PM state behind. The remove path likewise lacks
the matching child depopulation.

Depopulate partial children and disable runtime PM on probe failure.
Depopulate children before disabling runtime PM during removal.

Fixes: af0ba001d208 ("pwm: Add TI PWM subsystem driver")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260616151946.53001-1-pengpeng@iscas.ac.cn/
- route the orphaned driver change to OMAP maintainers and lists
- depopulate partially created children on probe failure
- depopulate children before runtime-PM teardown on remove

The child/runtime-PM unwind order was reviewed statically; no AM33xx
bind/unbind test was performed.

 drivers/bus/ti-pwmss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-pwmss.c b/drivers/bus/ti-pwmss.c
index 1f2cab91e438..0c92968b8d25 100644
--- a/drivers/bus/ti-pwmss.c
+++ b/drivers/bus/ti-pwmss.c
@@ -27,14 +27,18 @@ static int pwmss_probe(struct platform_device *pdev)
 
 	/* Populate all the child nodes here... */
 	ret = of_platform_populate(node, NULL, NULL, &pdev->dev);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "no child node found\n");
+		of_platform_depopulate(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 
 	return ret;
 }
 
 static void pwmss_remove(struct platform_device *pdev)
 {
+	of_platform_depopulate(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.50.1 (Apple Git-155)

