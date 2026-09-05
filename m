Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FED3DAAC2
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591863; cv=none; b=kNqLshEd+On9oISm8KdC8fFtqHBaKJ+lNvYbo7JcwhLuD7vEMhkimVXQRvvBc9jUeNRQ2jCtQLjar6Qi1VENp8TqXOXz7MsuKydrq0DWMsI7xr86ds0MaRGlvGAxc3IDa/JSGF8yF5YKZDLZCuA/di27YqOb5zij8OE6iXOnW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591863; c=relaxed/simple;
	bh=iIEWAYVGI2FzX5iZTyH81lDATptMQacAG0wTPy+abXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zd+7cHuLB+vigrzXVKkg9yAtNBSpXs+48X3XebNocH4fvx/EpvTmUrksOo9Bx8XCCvRoB31/UT/eonlC7h+EKmutInd29dYBkqyu0hEfvCPKL/uqYkxEPEQwYr8mFYi9P89Fa58FsppdgQ3BV2PmgJja+KYCbgpTRs420cCx6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/VnKgEw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/VnKgEw"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so939707f8f.2
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591849; x=1789196649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=n/VnKgEwCzZzuUfJUOeRE+oKzjhVOyufVIm6bkaulaLPTDQm2Udno1JesGrfw+QtXz
         rtm2HC9oekj6emqCHGdjmj8Tg7GtyOqUaLYn/RB0+FVYHZ+4xb5I8BszVLSoWQKWnUOz
         ykiTBqE6hq7UgsTha8RD7CuhFhhy5kDjFQBiQCgcgB3RGwGNRMX3Pg7/TRuIJqfw2a9F
         EpjIsiNmxO6bXgxOyi0EgzQ+9+XnRBpbp+/MkKVQI+xT0XzSfP9iUXr4eIb3HBe1Orv8
         BHqNJmEGTo7OOeFNbie58dyBfFSSmVSCeP0DGssZQo3HSLtGpMSaveVk3WFXlSZhC0II
         gtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591849; x=1789196649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=RfbNvy38k6mtGFYQ0H7QyKg8BHx2D+dI5StPrUyXN6XztTofuLUr4vGAEUJGtyezim
         vk1fcc53H5rji7qToGZd/Mqo/NZ1X1y/KytWZ8GbG+5XxY8J4GiydwmWtTL2ziiQocf+
         nPIfWKZtD6l5X+iA2ub4GpmgTJ912sAn98MrQlst/e1JHeLZhTc/cXhwaNwp1Q/PIzD3
         jzwVH1/t1xYx7lKXIV2uS6/hMreM1PQkGuANeZkwncSOejralu9dK8GLbxB7wsSqpaNq
         DXoHIFt0jOH2EbfDm+C1vzbdlyaVac7C6PvfmKzfuK0BtDtrDsYRDn5nw5QuggguadLG
         ZK+A==
X-Forwarded-Encrypted: i=1; AKwUvBymxiIZTgXORnqGexn9ED6QqKsF66xKpTUcSfB4KBMQji4TRcwYxV2yF/sVNvbVc3uoIyjSNNZ2kBDk@vger.kernel.org
X-Gm-Message-State: AFuF++knHmx/6s8JVoWl0ZFj5zD4QXuGm5xzrarDqH173cEVDRRXUe/s
	uZyN0Msv0JDRsAcamd9J6ODL8f6EwKQYmwza2ae95Le7heVKCdeBCJNa
X-Gm-Gg: AYBFou3Py0fbGX86Hypv6AhwI9QCZ5pxutyUNAncc4RnBjvN9a5syZzRk55mAT04kBk
	XW7uApdlfz49HgRoRftNzrb/fz1oCVdwwRiqNzRED8J9bmvQmxpBuM49W23hY8GYaT2CWwToWki
	Oq049liBqcXB2MmuCFW9/kUHwC64xqczGaZtnpY8BRzx3DqK9fVs9wufWbunzgsEIIvU027d16r
	uss+9MaIdT3V2Lb4hlaODdiuuDKAk2PZ/twrpbZQLTMpi0jC1Y/WtP8FYt+N3O37QTNly0l+eet
	ID6EFM4Ze5v3u4XzzRtMHFcvS5hky2FzRyxGKM3hiEp0YmFjuKMaXsIcyEQXxVyeCFoH9gMQ3nC
	bBxL3SUa5AKmPR5iIXXa9Wc8lSuVe31CJFH0PgNP8bBMHMXPNdM4ob8ZbfA58ZjK/6aKKH7/LHr
	1eXawKT4mDvTT1GITMeEWrB3IJOHh2k3oCI9NR5hZ2ERR2/z9mV4R4pdz4i7EKA/BCVYjx/OguJ
	eON3f7xqikR2dx2o/3xJwSUtlhrzNmgrh2mZ+VdXm4G/o86o5JfgixATd/+WlCzsnGwdjOzVxB4
	PJM6k/LK9dP+Ue4CHQNdc0QVip7lyFbnd4NygBw6pcLzVLLcLPDN3ZTB2VphlgO0rP0fCXmD
X-Received: by 2002:a05:6000:46c8:b0:484:3f43:4914 with SMTP id ffacd0b85a97d-485872a6622mr9310761f8f.20.1788591849363;
        Sat, 05 Sep 2026 00:04:09 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:08 -0700 (PDT)
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
Subject: [PATCH 8/9] docs: kernel-parameters: Drop the pcmv= entry
Date: Sat,  5 Sep 2026 09:03:46 +0200
Message-Id: <20260905070347.25902-9-kmehltretter@gmail.com>
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

