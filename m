Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707945;
	b=RYvVI2fJ3UynGFN81Usjx231szKkQor0SruIA9tCdgpHW5tOaChY48XuKUJ4Op3uQLWn
	 Y9isMNo9DpDmSvApNEdAmHxJEoHhOUKLL/wo/hhM4GMznwve02f8NeilvafdWZx5+d3/l
	 bB8XtKsue+Yi9UwyjPvaFnP8O++dUZwXP1/2sn+V1Ncilm0/PVe4Pe/tJ+lJ9z8pmhvEI
	 q35B9leYmVQRkpMNsiLfyngRGaSE4wduM+ZH14nt7HJIGeVql130K27aBWg0Z5ZfVPis1
	 2e6GqNu6hwFDwMVypRx5wXzcxUpxxeYWnEipQyk41bJbjCDBmrupfT08WEHq2EXfd/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707945;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=Zqe81CUvl0CetbkbGMnAV9O0XTNAJxsTRcckQyPgzXA=;
	b=YSXoPVz1huxoCJwvf2QsEtoVB99ZGeHaIMfGy6Tjql8jMXJTPr56N5SIfD2Kebhrsn3Z
	 mGrMZgIongUjSYYgSQUavKGvRLZbIjODO6k6pkwx0qPcJo8AADaD+VSoDKD1s7NYHFTiH
	 wigR1vEk8Q2wOqXqa9iqON/24w2liSBM6dH+dII0U9g5hJXHQJniOI9DdPjGP2T0wbybR
	 Zsa4JueepuTDXWg+szZpZ5JB1+wB5OsX0wBb/2aDo5NzLNOCrzTFh2zU9iRY4slyNnl5z
	 JxBIWfe+Np0rqfjET4czxz2V35qhc1wzcmeGaInI3ZT5G/YkvNhockmxxAMg63FP+Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Kz7GrG4l;
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61288606A337
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2026 15:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61288606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Kz7GrG4l
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20261126154535a2e810438000020760
        for <linux-omap@vger.kernel.org>;
        Thu, 26 Nov 2026 16:45:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Zqe81CUvl0CetbkbGMnAV9O0XTNAJxsTRcckQyPgzXA=;
 b=Kz7GrG4l+IPMRASsQ52hEw7hdl/YxyNPX4Th5GEcrg2x8Fv/cgTXMICYKDFyFLRyBgSpK+
 eQ+cuaOusrCZt3aNofOMfERfSFO/RxIWqIwA0GjJiur71P0DHt94jN3kWlnBpA/3SeMWKl3r
 WtBPI9cZ50l0MLDP1NOtRIz5DYCw4DLwAjcP3oOBeuvis9fiPkperbsuamDg1tvdJGjJFIDm
 HJJNTVzhqxYQlIadIqoaOpyxV3AvbpQHsGoIdzPn+X/dA73sE4C71qItt0H41WlYR+SGJPrW
 LdU8MRKToj1Op6ZAfFsYeNgQJAb9bogXe9Ro+rFDzA+6CYD15RUR46Pg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-gpio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] pinctrl: single: Also free the pinconf table of a duplicate function
Date: Thu, 26 Nov 2026 16:45:22 +0100
Message-ID: <20261126154529.1599568-2-alexander.sverdlin@siemens.com>
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

pcs_parse_pinconf() attaches a devm-allocated pcs_conf_vals array to the
function pcs_add_function() has just allocated. When a node is mapped
again, e.g. on consumer re-probe, that function is a duplicate of the one
the core keeps and is freed since commit ad2093840ca3 ("pinctrl: single:
don't leak group/function tables on consumer re-probe"), but its conf
array stays on the controller's devres list. It accumulates with every
re-probe of a consumer whose pin group has pinconf properties, until the
controller is unbound.

Free it together with the function.

Fixes: 9dddb4df90d1 ("pinctrl: single: support generic pinconf")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/pinctrl/pinctrl-single.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index d72ebb186b894..64472465800c4 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1107,6 +1107,7 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	if (pinmux_generic_get_function(pcs->pctl, fsel)->data != function) {
 		devm_kfree(pcs->dev, pins);
 		devm_kfree(pcs->dev, vals);
+		devm_kfree(pcs->dev, function->conf);
 		devm_kfree(pcs->dev, function);
 		devm_kfree(pcs->dev, pgnames);
 	}
-- 
2.56.1

