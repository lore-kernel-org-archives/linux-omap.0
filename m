Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFA2EBBB4
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062653; cv=none; b=obYk4SoUBXEth0QCJmv2atk54l6R/2ynx/gwtmJsz5p1v0pTLpKhJEIxZ5xF2+E5sTX93tXHl+jNTiFU6cTmR3dOzFJAgSVb+REHY3rrFp7wC0cxXRfuXL++8TBKr+z9xgjU3lDDtig6pa9a/ovkhGJS+vKZ39ox8iPCD1Y1lHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062653; c=relaxed/simple;
	bh=HwQQ/e13d2XeVp13BFe2FpMedQM5DZhp8KcD4K71ego=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QBxqEdF9KYLQ8J2PtvtXrPkS/nn1N2HZBd1kGLwyuMu1cYiGzBJdJzqau9sHYbYOeol1WA2RWKUqqHjEacOtSiKoExVWqCsQLPDa01siDA89wRwDqQrwi4LXnkH0v9YN8/PyNlwegnOAvUJUbYoS2y/59+cpjzOjwO9+YraV6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cCEo8lZK; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCEo8lZK"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so6101235e9.2
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2026 22:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769062644; x=1769667444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFWxi+AFltNFDVpcrpAcnDmVTxmCRVFES1AkiIw22SY=;
        b=cCEo8lZKAs1wr4lfPYM6lISHc7OyocCVXHgQM1twwkXLb2NuRB1HERaaxW76fYKOgR
         Kv9d/riU2OCb5wtfxfGlcANv57LjTxWKE/VrxnT/EMzxLh+ZAtT99J00GtjHh/KR8S4H
         7MHMP7DnxML999Bi32tWLzr9OZISoLZDdJd9644F++z6At/8GHg3JQEG5GpMQKOJrnyh
         c7/vuVQ9CMDAM2UjiUYpfX5tnOaHhPIn/ynUJ6NfW1bsDsxriBKfbdNSnKcZL100q8a3
         81xHngoT8wYXu4xVfTTg0hCauJDEExfpnclEk4qxnchsokJMNLy6sERO2HSZVj1o8xbb
         bTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769062644; x=1769667444;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFWxi+AFltNFDVpcrpAcnDmVTxmCRVFES1AkiIw22SY=;
        b=Y19UGEqV5bWvmmZachWa2aTMT2l31d/hdzJvo2+J3DTuebQBygPsW22/cryxTUy6EO
         /sdbWOXrz+y4vAul/gXCsSQbSqVRZBYgJuoTxY7nFWgO5sB450s5/q0SGBF2F3m4VoQC
         AA2JkeQb0uwntFQkUSy+jtCbAg7A9ViivkGoxCFgIxj+lu1/N5aOB4NyDTZknn5oqj7a
         wz55/F0kbr7C21pDoGcx5yhVOn64qOizHmMri471RJJnOfnrXAIin+KB/S/jt40xz7wu
         q1wSz1qgVuWS+OiboQiEw4YQBqCWE2XRrYsBo3fHdkmYB6kXIFkvQ/mcaG9ytXq+bHtH
         V/ug==
X-Forwarded-Encrypted: i=1; AJvYcCXv5Kmf172KoRpzxbBtnusxGOqkYTfaW+kcOALfVyai7KjqHc5D/bEjr0P/wLmQ9pL4Nqaumr+AmzB8@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnpCC1cO2hQsAe1pOvSWXcmZ8s5REaOjAVRlMTQ8EVs5bfvHt
	dPjkn4usqkisMrhtqNWvc6WtUKtgEjIvlNMd4IMOWOdASnmsPkL4wgG3wgpkFCgdue0=
X-Gm-Gg: AZuq6aLrd/jB5nI1bb3VhSVmYjivNoWB4eOADyBPFofseCX8Lobt0lZUokVAKUv6cLa
	yaoJBIXQ7ymD+RBpanFYPn7pbAphw0Gax7eYl8Rlr0CQRjck6WfF8QJ/AlXcaijhucLaLd6XR5G
	jbZbyZsn+UmCxa3wrpXc8BEpPdHsjwLLx+LL8gSD5wKbgMo/p5bPfb5RIkDPhe6s1GawOCqFhJH
	Sch5TcqTFbmN4NDzG1vioVxF5RoH+Szv/EAq/kTuwGNu4Z5mnwzWcH6vTVyrlmVS5D8k9p4ZBKP
	JueddYSaeBwd47erIYEQv0iMSDWyEzkOJNY1SqHgsxE0kLsWENFilpKWStYmqJwMrt2Q0oVB0Fb
	0HZtjK8f2wPYWmWKYiz/JU5zrTdIVO12HDMXxlPasluRf/T8Lm0jajqK2VgJYQAjg9SFjMNm8FC
	W+fsLbjo6gucMRtzfS
X-Received: by 2002:a05:600c:83c8:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-48028360726mr235733975e9.7.1769062643924;
        Wed, 21 Jan 2026 22:17:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704b89bsm40122255e9.9.2026.01.21.22.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 22:17:23 -0800 (PST)
Date: Thu, 22 Jan 2026 09:17:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Josua Mayer <josua@solid-run.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Message-ID: <202601221036.J0kR78Uw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-rz-sdio-mux-v6-2-38aa39527928@solid-run.com>

Hi Josua,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Josua-Mayer/phy-can-transceiver-rename-temporary-helper-function-to-avoid-conflict/20260121-173607
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-2-38aa39527928%40solid-run.com
patch subject: [PATCH v6 2/7] mux: Add helper functions for getting optional and selected mux-state
config: arm64-randconfig-r073-20260121 (https://download.01.org/0day-ci/archive/20260122/202601221036.J0kR78Uw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601221036.J0kR78Uw-lkp@intel.com/

New smatch warnings:
drivers/mux/core.c:776 __devm_mux_state_get() warn: passing zero to 'PTR_ERR'
drivers/mux/core.c:796 __devm_mux_state_get() warn: passing zero to 'ERR_PTR'

Old smatch warnings:
drivers/mux/core.c:722 mux_state_get() warn: passing zero to 'ERR_CAST'

vim +/PTR_ERR +776 drivers/mux/core.c

0610cc3159b786 Josua Mayer       2026-01-21  761  static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
0610cc3159b786 Josua Mayer       2026-01-21  762  					      bool optional,
0610cc3159b786 Josua Mayer       2026-01-21  763  					      int (*init)(struct mux_state *mstate),
0610cc3159b786 Josua Mayer       2026-01-21  764  					      int (*exit)(struct mux_state *mstate))
0610cc3159b786 Josua Mayer       2026-01-21  765  {
0610cc3159b786 Josua Mayer       2026-01-21  766  	struct devm_mux_state_state *devm_state;
0610cc3159b786 Josua Mayer       2026-01-21  767  	struct mux_state *mstate;
0610cc3159b786 Josua Mayer       2026-01-21  768  	int ret;
84564481bc4520 Aswath Govindraju 2022-01-07  769  
0610cc3159b786 Josua Mayer       2026-01-21  770  	devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
0610cc3159b786 Josua Mayer       2026-01-21  771  	if (!devm_state)
0610cc3159b786 Josua Mayer       2026-01-21  772  		return ERR_PTR(-ENOMEM);
0610cc3159b786 Josua Mayer       2026-01-21  773  
0610cc3159b786 Josua Mayer       2026-01-21  774  	mstate = mux_state_get(dev, mux_name, optional);
0610cc3159b786 Josua Mayer       2026-01-21  775  	if (IS_ERR_OR_NULL(mstate)) {

Please, change this to if (IS_ERR(mstate)) {.  The mux_state_get() never
returns NULL.  I have written a blog about functions which return both
error pointers and NULL.

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

0610cc3159b786 Josua Mayer       2026-01-21 @776  		ret = PTR_ERR(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  777  		goto err_mux_state_get;
0610cc3159b786 Josua Mayer       2026-01-21  778  	}
0610cc3159b786 Josua Mayer       2026-01-21  779  
0610cc3159b786 Josua Mayer       2026-01-21  780  	if (init) {
0610cc3159b786 Josua Mayer       2026-01-21  781  		ret = init(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  782  		if (ret)
0610cc3159b786 Josua Mayer       2026-01-21  783  			goto err_mux_state_init;
0610cc3159b786 Josua Mayer       2026-01-21  784  	}
0610cc3159b786 Josua Mayer       2026-01-21  785  
0610cc3159b786 Josua Mayer       2026-01-21  786  	devm_state->mstate = mstate;
0610cc3159b786 Josua Mayer       2026-01-21  787  	devm_state->exit = exit;
0610cc3159b786 Josua Mayer       2026-01-21  788  	devres_add(dev, devm_state);
0610cc3159b786 Josua Mayer       2026-01-21  789  
0610cc3159b786 Josua Mayer       2026-01-21  790  	return mstate;
0610cc3159b786 Josua Mayer       2026-01-21  791  
0610cc3159b786 Josua Mayer       2026-01-21  792  err_mux_state_init:
84564481bc4520 Aswath Govindraju 2022-01-07  793  	mux_state_put(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  794  err_mux_state_get:
0610cc3159b786 Josua Mayer       2026-01-21  795  	devres_free(devm_state);
0610cc3159b786 Josua Mayer       2026-01-21 @796  	return ERR_PTR(ret);
84564481bc4520 Aswath Govindraju 2022-01-07  797  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

