Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039690;
	b=oAnts7/2AeK3/Xzrjgc92Sy9zroMZpeAWa83uPyawcpbtJlb3eE8WGDdlk4FZ8NmRkkw
	 VtaU+wrNcsesIVYBk8dVQllTi5OBX0KRS0ufWIHRvSss0znBzecxcowMDXeNblvgqLhUI
	 XK9eEeHouB2C9OmbD7DJXui3c9MeOqEjd7a+xanGsCmsuRtQOW6P3neAreCRoDSS3EV3w
	 +Nds2xtE/He54Gb3XhUh6dY99G9zORw5duOEpvgYxe4zsqVFgHClE8grOj5H3dZG/jfj0
	 VOTaqQsjyCI9SXsLIR47w7ygpxR3iVDIT5hfukVY96GrRu+15ozKPhUqSA5P4Ek09pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039690;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=3HfUD5ft+3FV3KBYBx8e7YafxGrVlmoQBUcbJDZvVg4=;
	b=CQKJ406UdGvX6Kwrc4YBhZOd/80PUydLCpBkhgUnjDkt+bK+m8c8uK0YeD2WQdBhjIaJ
	 gBjaWRs+HQRoSHpw4Hma3sE1FWgsTOSbEPQNLLlQNElgrLYdOhzvkNeiz6qNu+h8HBhvY
	 KdPLLXSqjfoL5BHfyh6pZDesOkXcPvvoofVo6I6QrTXUSM7kaXivhoqFnmnZUZdDz+sAM
	 vyT0Dx/dlFbYi/6brh90c7SAqNqt5/JbG5P0f7XLax4LsJDfzoZqVLwn3tIMosj0VxCVb
	 ssCgNp/wQb0EZhdPvQmJ/aZK5xxpCWtNCMCBJBykTm7X1WRaFvDaQhqm4ozcbps51FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E1606A32E;
	Sat,  7 Nov 2026 08:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023E1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jM8CD5xbkz5B137;
	Sat, 07 Nov 2026 16:21:28 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A78LMUY029929;
	Sat, 7 Nov 2026 16:21:22 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:21:25 +0800 (CST)
X-Zmail-TransId: 2afa6aeedf85234-a2dc2
X-Mailer: Zmail v1.0
Message-ID: <20261107162125044ldKkwYPQxZOTWg6IDe_LX@zte.com.cn>
In-Reply-To: <202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn>
References: 202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn
Date: Sat, 7 Nov 2026 16:21:25 +0800 (CST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <lee@kernel.org>, <mfd@lists.linux.dev>
Cc: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <tharvey@gateworks.com>,
        <support.opensource@diasemi.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCA1LzVdIG1mZDogZ2F0ZXdvcmtzLWdzYzogQ2hlY2sgZmlybXdhcmUgQ1JDIHJlYWRzIGZvciBlcnJvcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A78LMUY029929
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 16:21:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDF88.001/4jM8CD5xbkz5B137

From: Shao Mingyin <shao.mingyin@zte.com.cn>

gsc_probe() checks the return value of the GSC_FW_VER regmap_read() but
the two reads of GSC_FW_CRC just below it are not checked.  On an I2C
error regmap_read() leaves "reg" holding the value of the previous
successful read (the firmware version, or the CRC low byte), so
gsc->fwcrc ends up with a wrong value that is later printed as the
firmware revision, and the error is silently ignored.

Check both CRC reads and fail the probe with -EIO, matching the handling
of the version read above.

Fixes: d85234994b2f ("mfd: Add Gateworks System Controller core driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
index a3301502ce6a..1d697e82ea29 100644
--- a/drivers/mfd/gateworks-gsc.c
+++ b/drivers/mfd/gateworks-gsc.c
@@ -219,9 +219,11 @@ static int gsc_probe(struct i2c_client *client)
 		return -EIO;
 	gsc->fwver = reg;
 
-	regmap_read(gsc->regmap, GSC_FW_CRC, &reg);
+	if (regmap_read(gsc->regmap, GSC_FW_CRC, &reg))
+		return -EIO;
 	gsc->fwcrc = reg;
-	regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg);
+	if (regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg))
+		return -EIO;
 	gsc->fwcrc |= reg << 8;
 
 	gsc->i2c_hwmon = devm_i2c_new_dummy_device(dev, client->adapter,
-- 
2.47.0
