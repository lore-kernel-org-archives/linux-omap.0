Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C43806A9
	for <linux-omap@vger.kernel.org>; Wed,  1 Apr 2026 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078913; cv=none; b=CKWYsh2FMgpAW7dUc3670Cv1bWZmXOB4DdgTXLbErrEelibQnPHix/ckgArplcFItfW66MouFnsxvE6vW8jj9FRdgiFrOOeFH0/01a5roASESVRh4XNn89BDQYwHRJjTIDj+Ui2YSnQj/lHW1IPalUb54+VlLYmdIZ8Z4751BHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078913; c=relaxed/simple;
	bh=WEsLWV4qR6UWZvDqunL5H7vXZXLI1MjhtyEZ4X3JaQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mATD12Z8xYs1wdtQgYid/HRDoTpMwwVSWYEKZ+pHr/Lh8N2zb7zMyXVxv1lPq03O2rauugEHTaK4FGkRtD7DNL3YAvR39eKo3jx3wwt64J1Ii20x1RSUp4vAF77AJDuYgMqO/e1sQXRhnmO5ZEC4vveOtxdwvcShYo5glW+7OJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iCCMWfFJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iCCMWfFJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so83601a91.3
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2026 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775078910; x=1775683710; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYPEpP1b00lX0zsw7xL3leAQo4zY3t6/Feqga7nFICY=;
        b=iCCMWfFJAqhrwmDZG550oLyOIlJPY6RD542oBH+N6AXJ2WFkG9THtjU9YSI/T3wP0O
         kvuL9JlVCoGEdWmz+rQzcIfH0D4KYcJchxzzu4KMfXkEnZYhmzuM1gc2FEomE6Fdw0ns
         dUnzjhHCMlbQsGajioD3lXjlHuuVnNGguy3zi+jybGMSBdBmzLoe8lwu5q802/LStx9q
         aZtr1zkmUpRj62yoCnoEuJspss5/2bZ9HA6XAtvyXxzmn576dlgFUGO5sQl0QEXUxA0t
         MEpnlkcn/HGQVIO0kzgQrlmp9ub04qM6KiShDgSWQ7L9qpiXNbPw8AoMc1C1GGLVu2Xx
         m9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078910; x=1775683710;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYPEpP1b00lX0zsw7xL3leAQo4zY3t6/Feqga7nFICY=;
        b=m4QWX+wnrQGRDWEkglqPUyIYFMU+C7KCyB6Np4hXLv4DNb+vz8lsBz7eXpnFsIYj3L
         cb7UVSLNA3DibDSqBSbLv97ckPw+/tPyepEO+euqImHGKjZ7idIEXtaPx4toNRP5BWj4
         +9Tvq+y3Z78fFUsBNq/Yr1QaiDoiFsNsm4ET15WehsO2Fn1ZfK+pr+kQ9UhtCPgNImEf
         fvZqPzMlOG34PTPxDCUD0RcZWpp8832X0B8/LtF4dWbPqukgkBd8eaq0R1+Ck21JlXrp
         /dQAW0FpGhzEkmDlfqI9sSB0GOYaDZM7DUZpn1YaIpO5g1L3mEGO65FzMEDe8++Rm89O
         qtWA==
X-Gm-Message-State: AOJu0YyeehrFnLruZbmc56dYQvXB+eu+519ocaB2RRVxeUAYTIA+wo8J
	LDNi7R+vW/14Ied8vTOSvVE/zVZpzLaIU2zWO6bPWZdW2ueZ7jhHdvtA+7+2qQ2c6Xs=
X-Gm-Gg: ATEYQzxioc175u4Yrdfyb1qEswsAiZl2IcMhSI/kGD1mGZybdVvdo6psrlmmYYnamZr
	3RaAO1JFQgLiy5CsKQ2MGvezwpUSzbqTgiCcPex8ZT6HxzQA+XBbmBGcrE5Pkar7ZJuzrAo0nWj
	My9hEMDVNcl/20aO04wqdt1Dl+eXUQlO4WOpJueQgCNXg9KqkNlDDs4WBALLmZeJWTouv6u689N
	Y1Tzy7wKdDbOcsXI/GCcjAXaWcE4z4ReNSLtdhFiGwVWqrDB++73Fjnh3Jo0Sp/Ng9b4n2DPoAx
	bOWJxs3uXNMMZqHcZlyx/HVbSsJr0m60d2sznnhzyXv57RlzevC4ybEWuT+fP4IsjC/c8AoGT0Y
	OpobOSUVxQovk6+TZAJePWC9NIQMdN7tTE9EaJqCgdvY9MrPxg2nS5zQSJdHujCbA+850IukWzu
	ukBtsb/cikPCGyufDgfVSxRW8Hr9NCOQ==
X-Received: by 2002:a17:90b:3f0b:b0:35d:9f7c:142c with SMTP id 98e67ed59e1d1-35dc7052e98mr4367414a91.26.1775078910328;
        Wed, 01 Apr 2026 14:28:30 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e519dsm5918706a91.2.2026.04.01.14.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:28:29 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: soc/omap updates for v7.1
Date: Wed, 01 Apr 2026 14:28:29 -0700
Message-ID: <7hzf3mtloi.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.1/soc-signed

for you to fetch changes up to 9ceb17ccd15ea32f19c9066f5f1b340d8340bd0b:

  ARM: omap2: dead code cleanup in kconfig for ARCH_OMAP4 (2026-03-30 14:21:20 -0700)

----------------------------------------------------------------
ARM: soc/omap updates for v7.1

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: Fix DEBUG_LL and earlyprintk on OMAP16XX

Julian Braha (1):
      ARM: omap2: dead code cleanup in kconfig for ARCH_OMAP4

Randy Dunlap (1):
      ARM: omap: fix all kernel-doc warnings

Thorsten Blum (1):
      ARM: omap2: Replace scnprintf with strscpy in omap3_cpuinfo

 arch/arm/mach-omap1/clock_data.c           | 4 ++--
 arch/arm/mach-omap2/Kconfig                | 1 -
 arch/arm/mach-omap2/id.c                   | 3 ++-
 include/linux/platform_data/voltage-omap.h | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)
