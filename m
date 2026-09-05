Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF6360EC3
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601643; cv=none; b=sYYpEyzKQN8+/k+RPLL8qmyxDt5/2T+jED5qPS5KFoGQvSZTUz24SpBP4oB19o2YXEdkb3Uofa4gLiiQ53BDcqwN2nfNhMDjOQf267iyJnI5xmn9ptS5QpB7qTnYEROng8npmd2y73PIiHYb2R4Kpmd1IBxiPNbZW1Gw0AFJexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601643; c=relaxed/simple;
	bh=iIEWAYVGI2FzX5iZTyH81lDATptMQacAG0wTPy+abXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4CwOBxQKA1oWMmSBTaNOOc4woAFrxbH6qFBF7UdU7bi1Tver4kz2rDnSgYbuW/gr6wKafoRNQa4SPFQ+3d8qLV5T1gTkFYluOUsNuyNIYW/28GLuIFeVXJg5T/nfZWxmz4e4dif4fVTV00ctGLdyaA+KWFmIZJudLuG4/WeRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyvrpKrH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyvrpKrH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4843e397f74so2283215f8f.1
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601635; x=1789206435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=WyvrpKrHJwVM/8ZcX1GSWFju4g14O4oDahiOI0OS+wcnypQuvsomCZxxoNsngGdcpS
         iMNMMyLbpjtmvW/EWl4iZ53rr0WuVL50Je9Pi/ewScX5oXjVlbyTy66vsM00pKJDHekp
         zbXJPoTpg2PVAHDnNeCDSEqB6+IXMYfMRVEYlxkySrV1FIftT3xdeKrCHXTmz2dCvBqi
         G7Nx24hz/S/2cGB8bDg0xlI/4JzXD2cIxs27X9WE+cEHW97xbSD60x2O4TuuUiiEtmMN
         gLz7tKdUexx74iuFiJ5OWz548lW326b3vnw9JZ0uUDJlkfikeabOhE0wjsV0JZs8aZoF
         EjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601635; x=1789206435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=TiZI6BruAhDkIgfzjs3qDWot0Walm1ha9oHBfO0QK2fC0ofIyxB2oy7XE/neFL3aSj
         Ktn79OF3xY61D9EZSS+E7//GnWuREMSccxFKE/ZFqPPr7jTF2rFjPfcjQq/l3STxQ3o4
         uUxmFnqdOF/1J5DnLORtOoViXNcVH44mX56jzPXA+YM0wJ2mt4ElbROz2i2voBLmokPY
         RhHtODNMECM+iDZR7PFIhKqien2AzyD4I8dFFzoop9vhVj0EVtjUUocj3de4HyBusTaN
         2BbhybMdwSTx2FJZp8Rys/eHqvxMEyPMiuqywOebNa4mCeuT4haDlL6sriyS3biYdREl
         cGiw==
X-Forwarded-Encrypted: i=1; AKwUvBwH0nG36sK3BllrOd80+BpjjJuvVKZNqVrKvrX8eOWIPXlyIIVsFfnMt9cXktITPX8eZiJFQNHpHNTN@vger.kernel.org
X-Gm-Message-State: AFuF++mA8E0+3Cq4VpKCb1XcfDUocgl4IQ7JeJ+nUg3XGgcxtu+JAbx2
	gj7LuSlP7E0Ta/RK9urQasHZ8SqofseV8J7R46MJ7UISd5uHiFnEvW8o
X-Gm-Gg: AYBFou31vZYXsnKV2s06tXtX1xPhwUYg4XLSs13qSP9fg1T0Etb4AjiRSv0hcybsIiq
	/hNhl4Di42JdPyx7TvDTEkXEW1aKeBy/b7/XsBv2Y182Bm8X8zAjVCrcO+cDlVqNhmXsrLRRmwj
	/sRJh3udQwdrtSP0jz1HldnQjoZ4K543b+kZPYtszN7Undw3/d0Q3FjXNv48GP9VIwQoJxSSVDj
	bbGiy2GlFInDZc14+uSxi+NWhXhJxWRpmuIGatOJzlejPiZEr/XerRz1yrqEnr//j0ghwkcMog1
	cBS2/JPGPiOcJXAYvetGoSO3IQQuyeDTLbR5EdzUuAS3VHS7p94JW8W5EPMICtWJ5vRiFRqhIUR
	hwBGeCHDpGGI2cr75D9OYViYPY+dvg2ZRHTeHY665s5jQdk1cUGLCtOsAljNiIR4dpQ3Pvtqxz4
	rmCis0uJW3JflIcjNQYpKdq4nE2avHEonKSTjcd1dX11l4/O1LcERto2dJ50tqqxCnIHIhzJiVN
	xVxZ1ysrWrqQR+2K+BjdkszMJgiRql4e8UwIRIbDG6tVpUAdkxJdtWcVWIowhhuteomX+wyR7gT
	Lq1Q2LL5BCj9u+H0oYaRJFGfdltktfZJ7itlSTLu6+25EgS79T/jWfahN4g0J9mK8fI=
X-Received: by 2002:adf:ecc6:0:b0:484:49f8:b56a with SMTP id ffacd0b85a97d-4857e4f4adamr18253955f8f.8.1788601634554;
        Sat, 05 Sep 2026 02:47:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:14 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 8/9] docs: kernel-parameters: Drop the pcmv= entry
Date: Sat,  5 Sep 2026 11:46:48 +0200
Message-Id: <20260905094649.41996-9-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905094649.41996-1-kmehltretter@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcmv= went away with commit 7aeffbf2ddec ("pcmcia: remove unused
pxa/sa1100 drivers"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 7aeffbf2ddec ("pcmcia: remove unused pxa/sa1100 drivers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 48dd273eaf6c..4864e37005be 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5311,8 +5311,6 @@ Kernel parameters
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
-	pcmv=		[HW,PCMCIA] BadgePAD 4
-
 	pd_ignore_unused
 			[PM]
 			Keep all power-domains already enabled by bootloader on,
-- 
2.53.0

