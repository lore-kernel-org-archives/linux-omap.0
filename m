Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A531618B
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2026 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003976; cv=none; b=spFFcFu8jGMCLM4DDUD+wvscLQKH3ivU8XuXeB2wf2dCF1LUyltc3NZj6nLlR3x56plJswCU5iQ9+tX6FEzu0evuD5G2/q+m55TfyHqPWcc3sf3/aFKpN+OAcWzaaA1iBYYMtZuRziQf2jrvRI4P/t41chJMg9axDklQ7UlztZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003976; c=relaxed/simple;
	bh=XsI6Y/1sSLQp0adjnMZsyD3THyVMp5IicuC5nSeg3go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZuKqkmy0Vo+F4yMVhVDQSVk79Jc2E68puI01ibXUZxzrKsX7sOZF6QxcmBs7Ywe8K1ON0UvrNt15e0X5Ip+nZ7ZpMsmcZ/+3NjjMwyxmdeL1XQkAL4Iz4oGRtOkqutCsz1J0BX5xGnLZLTrXIwzI1qOxkGoi3f+9hQ/NsBjSnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3/zSNQH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3/zSNQH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so51258115e9.3
        for <linux-omap@vger.kernel.org>; Wed, 09 Sep 2026 18:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003971; x=1789608771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrhRS/M7q7pkTrLXrhmPne9tuf4NOHwrkARE6eFwxWk=;
        b=I3/zSNQHQXeB8cN8Wwdu7tgpm0DIv77z8BL8iakzEHX/aunQ9Aw1ymGqcisbz7I44r
         AmrhDnkhRnxwOe2nRq82G9aTLqH5PKybIWDSrtt2l/oOTuUckZz/HVgwFVqwFnJhonk/
         KbcrASX8VriPzIaNWBxPPyIwLQa6J1aSLOI6+UfnTRQvhgIYFJS8Lk4uIzt9XuKdk86t
         IDuYkMM8gAIceb4+l/GtrGeE8CNgE4cfPc4CKtExerkOlBut/kwHE4lo2aoRGcYiHCFg
         Kmg2iypyC1oQ02prBHKYBJmPDU65cPy+qakEPhe1I5zyqJS6K1WUzJY3LdjU8EwjXHLG
         ghVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003971; x=1789608771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrhRS/M7q7pkTrLXrhmPne9tuf4NOHwrkARE6eFwxWk=;
        b=K1NXeb1B0YeU/Lu0gjsymRgcNHfYv8D/1AIkZi2ukj6wuvf+dXocwMWTMYbvfQaqC9
         aae6p8jZFocsi3PZh5Z3bOxCwf4Ss80SO40WNsISliKaQ/vlxKNkK+LLvuHslDlrw9C6
         QBsTcMgAcU8k2icsASfAnjKI94rrQ1niXA/yh1/LQosE18LzycR+2/ULKJNnseUerux8
         mjTsCcOqVyHykj7lJZU1OodgwUlSlbOqn73CozyUQNj6wYipPv7776F2vBvAqkOpPVq2
         Mb3C5tKboN1e1VG1t+zH2uLqqznOaBu+r+qz0eKXuQAAPw4s9x2uXaZINddB5HVY3jx4
         iB9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxZEn1dRRJZmG3a0usSM/OBxwDaCVQCRHEYNDP/R9j3bs/AFrAAM+WuEaKncF+W4YZ4VQz3fGpYeFtL@vger.kernel.org
X-Gm-Message-State: AFuF++n7oEhiub9Za+bDGbEUtgpmsoyvxcVKvkcg6siexavVvOY/WXf5
	LhvWlknnEjKdGGqS1tyLX7zOLI+GKAKVO1o2IsPgmW8lkYWshUBDDIon
X-Gm-Gg: AYBFou2qZeGNnJvxy4RS3n3eT4aX2wpD8FK+Jvtxug2p2zv4TxUP22Z+ZgKJdJrg3Zl
	NRD9vQx669uZvu5U3YWL7hdRzUPje07BRHohZNJmBwSXLwySGqlXYIu7IWfQ0qK58NUCxFOEPhy
	QbZNlF23IFQCJFxt2fYxYtdtuGgR4dGYM3pcbQqSM6p9BWr4om317GA0zJp8JQUoDqgzeaJoTLK
	9wu+NmFWRtRjHPPa12nlFA3E6JRbTtGjJmO0rh4OguSV4LpxYZrYH3DMVivb0ap67/VRIumR0wR
	iz9rnxmlssqRZU4++S51r93/O5k+mrsb7lMUX8vkCu+v+b2ikT3wK5c7vc8RF5PrzAk51xOxQEm
	SaFZlxr8fFC14l/uGUeHv8Li1GHg1OPUt6vG+GmTSStbEGzuL1rwL66LUxUaUHsiW3fA2cPkgno
	/oUO35ap289SPk4cBjg2tC2zQ4T+pkNSqS2ir5JXx9zQMmuTp2OLtwqaUsnuA3WFKFjc+p88SWI
	1XK6SAYySyZmfCdrdOMDTKkQcu2iAGcJ+NzmN8uCm11ZiUrEJVO8TVBi4EIdHpasKBBfFvppSK+
	woiQH9jEoDvWIYZmD7nAgdV//078IiQK/XFGfCXzHgOXLpd0F59DvFdRlXBDnoRYjTIFAccTfbd
	mXQ==
X-Received: by 2002:a05:600c:4e0e:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49cf81e6063mr368280035e9.2.1789003970778;
        Wed, 09 Sep 2026 18:32:50 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:32:50 -0700 (PDT)
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
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/8] docs: kernel-parameters: Remove eight entries for parameters that no longer exist
Date: Thu, 10 Sep 2026 03:32:37 +0200
Message-Id: <20260910013245.8619-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-parameters.txt still documents eight boot parameters whose parsing
code was removed with the drivers or platforms that used them, one of
them (atarimouse=) since before the git history. There is one patch per
parameter, with a Fixes: tag where the removal is in git history.
Each entry was checked with git grep for its __setup(), early_param()
and module_param() handler and with git log -S for the removing commit,
and the name is absent from the whole tree at that commit.

Changes in v3:
- patch 3: name the commit that turned edac_report= into a module
  parameter (fee27d7d9788) and the one that removed it (7fc0b9b995f2),
  Fixes: tag moved to the latter (Boris)
- the pata_legacy patch is dropped, Ethan's patch from June covers all
  six parameters that commit 3c4d783f6922 removed:
  https://lore.kernel.org/r/20260607064053.195166-1-enelsonmoore@gmail.com/
- collect Reviewed-by and Acked-by tags
- the "Found by cross-checking ..." paragraph dropped from the messages

The remaining eight patch diffs are unchanged since v2.

Changes in v2:
- patch 9: drop the Fixes: tag for 0dcd0a76370a, which removed the
  separate pata_qdi driver and not the pata_legacy parameter; both
  parameters went away in 3c4d783f6922 alone
- collect the Reviewed-by and Acked-by tags from v1

v2: https://lore.kernel.org/r/20260905094649.41996-1-kmehltretter@gmail.com/
v1: https://lore.kernel.org/r/20260905070347.25902-1-kmehltretter@gmail.com/

Karl Mehltretter (8):
  docs: kernel-parameters: Drop the atarimouse= entry
  docs: kernel-parameters: Drop the bau= entry
  docs: kernel-parameters: Drop the edac_report= entry
  docs: kernel-parameters: Drop the enable_timer_pin_1 entry
  docs: kernel-parameters: Drop the mini2440= entry
  docs: kernel-parameters: Drop the nomfgpt entry
  docs: kernel-parameters: Drop the omap_mux= entry
  docs: kernel-parameters: Drop the pcmv= entry

 .../admin-guide/kernel-parameters.txt         | 54 -------------------
 1 file changed, 54 deletions(-)


base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0
