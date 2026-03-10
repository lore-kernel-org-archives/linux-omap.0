Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15840759B;
	Tue, 10 Mar 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133296; cv=none; b=OpoWwKjeiUaavHopmwnujFnGoZ6NJBQCZ65Cmj9eSr414aYVvhN26xw9f+oVeUzXA5IKrrJBVOebrSzF/3sD784dOTfiK2hJ8j38qJC/P4A9jRpCZIAJUHSgGVEbY6MtDeW3LxlpJJP8Q0+CBQ2nM9ZR54Cu5BSuwPImp6lb3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133296; c=relaxed/simple;
	bh=+ZtddYTfxK4iy32tnlSe9dFpGEJUP8yEVRuq3mkv7P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UC1s7osRpT1nuXQ2eC3K2hnPdLwBdSkTpq62wbmRJrnjaCmsgsZKJWyKHn9o/QBLXm0h0bSbEQ+c79b3dJEjgWz2fj+BtRTzZgDCxzC1CN9AhGlEI2mc8+bRd364wNz982EROBE6cD8MOOGkvN4jNXsr3zC5fALh61oXYUbfZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACHGw_i3a9pWDQLCg--.28450S2;
	Tue, 10 Mar 2026 17:01:22 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: linux-fbdev@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: deller@gmx.de,
	tglx@kernel.org,
	mingo@kernel.org,
	dri-devel@lists.freedesktop.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] video: fbdev: omapfb: Add missing error check for clk_get()
Date: Tue, 10 Mar 2026 16:56:25 +0800
Message-Id: <20260310085625.2648545-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHGw_i3a9pWDQLCg--.28450S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWUXr4kCw13Xr1DArW5ZFb_yoW8GF1DpF
	4UJayFy3y7JFWvya1DGr4qqFyUK3W0yFWfuryvkwnYgF4Yvr4DWryxGFyUXF1fA3yfA3W2
	qryjya1ktFya9aDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	CFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3b1nUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The hwa742_init() function did not check the return value of clk_get().
This could lead to dereferencing an error pointer in subsequent clock
operations, potentially causing a kernel crash.

Fix this by adding a missing error check and ensuring proper clock
resource cleanup on failure and driver removal.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/video/fbdev/omap/hwa742.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/omap/hwa742.c b/drivers/video/fbdev/omap/hwa742.c
index 64e76e1f5388..68a677f824e9 100644
--- a/drivers/video/fbdev/omap/hwa742.c
+++ b/drivers/video/fbdev/omap/hwa742.c
@@ -950,6 +950,8 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 	omapfb_conf = dev_get_platdata(fbdev->dev);
 
 	hwa742.sys_ck = clk_get(NULL, "hwa_sys_ck");
+	if (IS_ERR(hwa742.sys_ck))
+		return PTR_ERR(hwa742.sys_ck);
 
 	spin_lock_init(&hwa742.req_lock);
 
@@ -1028,6 +1030,7 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 err2:
 	hwa742.int_ctrl->cleanup();
 err1:
+	clk_put(hwa742.sys_ck);
 	return r;
 }
 
@@ -1037,6 +1040,7 @@ static void hwa742_cleanup(void)
 	hwa742.extif->cleanup();
 	hwa742.int_ctrl->cleanup();
 	clk_disable_unprepare(hwa742.sys_ck);
+	clk_put(hwa742.sys_ck);
 }
 
 struct lcd_ctrl hwa742_ctrl = {
-- 
2.25.1

