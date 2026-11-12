Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467815;
	b=yEYTK3PowDltvHvpARwHsnzDyUdqtSwG3GZximz4w9Wm2iNo39AK1paOTbnShSVHDb7O
	 cbE1FV9BG1PeKyE4dG8/A6xr7FvZmnGFCrC1fHR+UyGC8Ku3hqxwT5OoQwVPF4wgq+zbu
	 tI6+xjJyS7bfufSoNgxQ15r79Hel2/TiFpJINslW5LxVxvM5QK5FYXs36zwCeCu8GRHVV
	 SR1lrvXEhebkLphxMNHD4sown+/sInvwOmvcWKcDQDk3qIfZffHta2v+SJoqt9BuGe3k4
	 53oIpwr7oTjj2tdfZ5d0r84dl0pyKbdk0OyijQpUPsCz0vKadOqSoG0mqOcLeqtt8pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467815;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WcRV36NFkCjxfLCPISz2CD6YEZ2b8XviU1c6pmYrMKs=;
	b=ltdC4WPN/RZNONi571Mgpzh+6+/DaTxLYcP1t2oQUfD1c/CoNdH4um/IheEdZ2SJfJTD
	 35JUdXqI2KYjX4NX+tWefXtbFfTLmi8aGqY3CdvA5ouXqocrCwcTvZY0Yyxk/CbVtqGIW
	 1QIjveapgUOjLGEFRGCX4JrqTYh1c/rUzvnDQB2Q9GDYoVBAn9P6x6y9Cwq3Lor0bAqfo
	 mh1VkGfWYaI2ZMXarr4RLAZDWdDxMRnGInT17lNGFhQmIlTtTI2QGXUOeaCITsM8BGx7b
	 TPc6tSVav695WXlMmPuZpN46WFSmLRW87pxHRpENc3HFxrlAzKZixpW1gyqEMMl5yHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PsbOPF9n;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134EB606A8A6;
	Thu, 12 Nov 2026 07:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 134EB606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PsbOPF9n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PsbOPF9n3Rax8Pc5vexTXd/P4qqoh+quhndKZClCNgt0dJ8InN2CbtOtsH/Qah0h7l9n8Vlczr2nG
	 ENVHQuuqjhVm9AAw3N6HP2eKhVN1G/hyvOl5/G3621xtMWmENUFdXCRTuwrOg+tvCXbqiI1LzslSR1
	 9DqfDqTigAm7VRk4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af567e4373-e47cf;
	Thu, 12 Nov 2026 15:16:52 +0800 (CST)
X-RM-TRANSID:2ee96af567e4373-e47cf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af567e32b7-f6819;
	Thu, 12 Nov 2026 15:16:52 +0800 (CST)
X-RM-TRANSID:2eea6af567e32b7-f6819
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: aaro.koskinen@iki.fi
Cc: andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] bus: ti-sysc: Put the OCP node after checking compatibility
Date: Thu, 12 Nov 2026 15:16:51 +0800
Message-ID: <20261112071651.154465-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

sysc_init_static_data() looks up the /ocp node to warn about an old
device tree, but does not release the lookup reference. The node is
not retained in the driver state.

Put the node after the compatibility check.

Fixes: 5f7259a578e9 ("bus: ti-sysc: Check for old incomplete dtb")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/bus/ti-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 12285ad9ef51..b3740f36173b 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3015,6 +3015,7 @@ static int sysc_init_static_data(struct sysc *ddata)
 		np = of_find_node_by_path("/ocp");
 		WARN_ONCE(np && of_device_is_compatible(np, "simple-bus"),
 			  "ti-sysc: Incomplete old dtb, please update\n");
+		of_node_put(np);
 		break;
 	default:
 		break;
-- 
2.51.0



