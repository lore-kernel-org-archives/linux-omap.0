Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F739A068
	for <linux-omap@vger.kernel.org>; Tue,  5 May 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981553; cv=none; b=RIGOMI1g3hpE6Majx9BnqXcCToBI+cZiwgDh0KvqQ8dp3BIhyyiQhdYK6E8t5hhRgAKh8c224HYuzHnwDNS0/GsvJR0d66D3WWMt4Gq19tQ/j8T218g7a0tN8DvZAYg/BcwCYQXvU+IEiX5hcT5rZCeGGX1v+VaOyqvXogMwMFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981553; c=relaxed/simple;
	bh=VdASHSn9x3wsZRCY61FDZy1+BJmDlscq4TBBUBpuQV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/dpxNdsmeRh173SAFxQN3jJZR/xP29O68kFu+32N4mnUXsm1JgYogZjxd36+uks8ulaZfnIDdvwFwc9OmwwLq7G/x6e5ohTLq+FZFBI7UPUlE9WhAGJQrHAgLs4XDRsbe9GUgL9OxIz7011y10+NZ1ZF0aIbVMwMfXO9qs20lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WrDdDO50; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WrDdDO50"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777981547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rwB1hbJqft5DrtbiB1QOT9V7QfLSFSkYYI/qjzrre4o=;
	b=WrDdDO50lE4LpkeQt15fLwlA72bw1GSTjr+eHtgsku8DA8/bChpMrnn/wgAtxsuF8P7+k/
	qZNax0gUxgi+oNfgsVzI3AMqTI2+iNOIkt4ZDjOrJXlFG1r9p6tgLrFrKTD2pwHBOl2Tt1
	z7I7VAI/VXpeG8bltzubG7TtJ+6EVxg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: twl-core: use i2c_check_functionality as boolean value
Date: Tue,  5 May 2026 13:45:43 +0200
Message-ID: <20260505114543.159381-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=thorsten.blum@linux.dev; h=from:subject; bh=VdASHSn9x3wsZRCY61FDZy1+BJmDlscq4TBBUBpuQV8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk/b6Rbzj2seIhBOfBzy/wfnOntCyKfeUzN2DmhcU7xe wHVOxv8O0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiCxcw/M/JbLouFHZQb42n R5TVM85kzaVi8uu+LzhYldq98M/Ts9kMf6VZZjr1Td/54MDP3hxhU+kw2eiG+WeuPXjsf/eMiHz 6OQ4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

i2c_check_functionality() returns a boolean status rather than an error
code - directly use it as a boolean value.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f89eda4a17fe..c024a28b057e 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -754,7 +754,7 @@ twl_probe(struct i2c_client *client)
 		return status;
 	}
 
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
 		goto free;
