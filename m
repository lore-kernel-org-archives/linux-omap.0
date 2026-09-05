Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32F3DB31D
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591846; cv=none; b=qhCFior24d3YqQ8qfSqxvvy70iadk1sOdBu0Xa+fS+RA3SQQgEjLcCFCeXGyq7o0SSXmwgb561vc+suMl+8f7wsgOB3fkSGxJq2907XOBgLH4Q9f+Hd6FuMiSAuX7f9gyVAYHi6Ctj6jMnDYcjr0CXZSVhNfHgh/i7OSBTfaBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591846; c=relaxed/simple;
	bh=BaEoG/6SLaF+j+PN5tp7+Wdp37OedR46Vcq2/qxVkD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOsqcZGADc2nqFVm2YmI8SxjG++Jv1hXUZSzLTj2CsWkP4SrQeFggNS2N9Hn84MY/LmVp816LYPAiP6R56zBq6qmzOZlN3cGWC2TXhyoHWzd6htM3GF/suLUrHpa6nmLNhvH1Hf73RovxJfQLOIeEIeXd93vlI7xSYOcrFG26Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIx+trdc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIx+trdc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b8f86c6deso12329935e9.0
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591839; x=1789196639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=lIx+trdcRt2pQULZ5/n9dD2iOS0yGRRAHuCceCVwmRYV/HUKsmUlcV7b6lzXN/2Apv
         rWORf0iEuCSu+L3tYPFEjViUH0ILeYxFwQ40v+E+V0DLWGoHZMr4P1cNOXjaxyfuF97+
         GyylPMJc/BvCIcMXHugYqJh7R3Jt2WsfZAOGOeAJOjDXgDYCW6l9JIb6/5cA3dFVqgGk
         t4D4vdEXiaGe47rTWC2b5aD2I0c0nUUWEABhMUgp59xSkA3N2NesPgVXMP49Gj0yAbqr
         y44Dgohz/0e9GfoVh5RrYTmwLvIvkQNzzfklYmrbLM7piIFlzTgS4XbLRe/Zsyr1coxE
         AhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591839; x=1789196639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=Jn4LZ28NMDf+BFVv0QfUvyZot744FXHLGxnDacYcv5zR7/WYK+T+EEX/YmddjYH/0L
         6em3B2V1p0S3sLgPPmvlkuKrv1XGYRk5ZJ0hjjZdUgyDGrzQjZdoGHuDmlscAq+9yFi+
         oVwiwAjGpf5jky+5eSXl/Hraa/88A0mOo10GQuJPyyK4VITGzMLkleFl9puwZNbAaObb
         DJ53oqr32pYwSuGXe+YCA1VRGH2J5fQRueLt3+HUjot5ypb5Efg7PsFu189UN02+RAtQ
         0MICa1xZUIFREMhUFWRnGkZh1NJJMWObL40FM2+0ix5sO5aGDNk5T0enLJoPTK3a5G9s
         9F8g==
X-Forwarded-Encrypted: i=1; AKwUvBztRaXukW40cAPN2lzRFXZRMh4OTQ35jqcKd7FIfCetTMFYK+kzTQkspQ7YoXF3mQGd2sGwwyyhA+qj@vger.kernel.org
X-Gm-Message-State: AFuF++ntzkxXG/Z/AVi20uE2rKywVcXzobo/zIuGTZRYh7eGSdcFM4b9
	QQu7ts4LeLhl9JtwEeTqvkUZWEzy/UpsSrluTFwSI+A5aeMdtANQHsKr
X-Gm-Gg: AYBFou0B+xjhtaGKCMJpTytKIDpaLKyFOE5OPieIX3iS+icq/GusYvGoGpO59os/ZXs
	W1BHJYi/OSFtQUYkb80vynncFjHQuj9IHcs5oLc8kuGndidSNq2PKtMaRFJikKTGLn3wDwd5j3l
	7kazre7fBd3Ibyoz1mRm/qaDiPRdFEqLV8bva4+MQ3JKXQoPDph83dO/+NmaVSKmhClMQ5q/I2N
	JUkRP11pQupHznl/F6BkM8LKM2nsjOONmexEdksoCdzQj0Bb57DCVygW3ufPFGEwkmzesvXsrKZ
	2lAHnubylCSOYXp00dVF58gdd/Y0UqwdE4JPfmBHzDvSzZbmjCpbLStAbpCGhjXXyfnpiMdFdTi
	eAPlzLZaGNm1NuY4Y//G/gACYDu/UgAd6fdbRyuqU8aK7s9L90T47See6XuUGtS/a0xQysEQH1D
	2XLzPqq5gKnj8I1W37pgpsapRwep3xZ0YZNYKVO00eXcOkEs+B/uwsLEB8qOz9L8RkAGWAaEGe4
	OFsX61vXfDY8V+8gJu/e99YO14WirGcKAxzBGs3lgL5ESfnX35QKu2V+cx4f/v6WwjxaYjlnVV6
	YvT1ujgdYLhVqq2iuJkS1j+P/9eiAlTpoxGxn7XySVK/FsQkgv8VSktj3LGO9bC0WJfGh0fR
X-Received: by 2002:a05:600c:c168:b0:49c:edfa:15a with SMTP id 5b1f17b1804b1-49cf826c5f5mr97941975e9.13.1788591838387;
        Sat, 05 Sep 2026 00:03:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
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
	linux-ide@vger.kernel.org
Subject: [PATCH 2/9] docs: kernel-parameters: Drop the bau= entry
Date: Sat,  5 Sep 2026 09:03:40 +0200
Message-Id: <20260905070347.25902-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905070347.25902-1-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bau= went away with commit 39297dde7390 ("x86/platform/uv: Remove UV
BAU TLB Shootdown Handler"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown Handler")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c8d96de4c00d..99d5bb68968a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -624,13 +624,6 @@ Kernel parameters
 			Format: <int> (must be >=0)
 			Default: 64
 
-	bau=		[X86_UV] Enable the BAU on SGI UV.  The default
-			behavior is to disable the BAU (i.e. bau=0).
-			Format: { "0" | "1" }
-			0 - Disable the BAU.
-			1 - Enable the BAU.
-			unset - Disable the BAU.
-
 	bdev_allow_write_mounted=
 			Format: <bool>
 			Control the ability to open a mounted block device
-- 
2.53.0

