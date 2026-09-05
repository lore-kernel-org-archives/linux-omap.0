Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A983DB31E
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591843; cv=none; b=bi1HwfAi8GsaMXbwu11IrXoi5m70JTGf5TJTYv7OVnhdhq3vMR6Dsd0LNup79VxMu6PAyvPB117WXuL+wJVMyGMADG2L6H0WbUKMG6UX2yzTnFGuTP5SaOfZ3zr/NXcN1ycvvhyhmFJgdBaIf6HTLohf9waev0UbgKe9v0ZKiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591843; c=relaxed/simple;
	bh=mhOUqwN3oOeKlzw4AsIblKh3dvC9P48S/odFVVFSApM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPQ5/dgiv8nB80aLNgQ6/00rCy6z1/5IH0f4JaKmPMd2y1akZJKgJACM2HdzW9dhpXhhZuPKoOmSziEFNdkNuP7tGyAXpShRBC3dDvEGcK2HW5gkPJRr5rj/qZRLE6cdVaY0o0uZjtWabTlHekLEDCCyZcBW8Jw6n+dS+fg120I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTtTkvs6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTtTkvs6"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so1208045f8f.1
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591837; x=1789196637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqbG77xAuC4eDU7XlaYrFKEyC2xRrttTZAEX6ejP9/I=;
        b=rTtTkvs6rM4NMcTBt8xaHA01lBlWiXX3jY40M7exjflP2eSuk0fXtdEIVw962mYre4
         Ppkhcmkyfiy99qBQIutIEDXPYrNbMzpER24nQZGdCVpycjI6q5KVdpUKf7835Z626bmN
         0XYU9d3/pG6cwOndupi0QvQi6RdAnlwn51MBcM8TP+BCx+Oj6nw5Wy1oefcXyYw/RX8U
         PlSdHcYzEtkmipy9uv6trEmsh6UITF6Equj/68D50/aotKv+wmjg3xY5J4LrzFrWl1pv
         4ATLBMbxQZg0lwHvXoZGKMF5rEB138MBB7DThJYARD28T63bmsjfq9M9mDodqWNgAR6p
         vVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591837; x=1789196637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqbG77xAuC4eDU7XlaYrFKEyC2xRrttTZAEX6ejP9/I=;
        b=eldJuihEW2c/fqhxMP6gQqT9wLiFHVr+Ttpff2l1oDgh7ZOlntRRcS8bZwIRNYUt0a
         ArLZH9pluy840wg8T8cqYe35JZMpm/7KyELAA9QUf9uHbxYVTRELdWhYGMB4ovQZQXAM
         4mkNzRaa8LbU8oDpAl69uqnRKPWGN0vlP2tvLoTySy2YEIQVdl4L/cf3ofxrtI6yvekW
         Whe36+xGq8ugtFtvQcSDOgl9ANJG9PSbPQ0jHNpK2Nlv/llMbw5ZRO3KDeurCBHOQvuN
         qqn9TU7fC75F4LyHgIPewcZKDan/9VTPI4cT0gHPpGlCq9cIuYL08OKDpAHCq0DpCa2M
         4Azw==
X-Forwarded-Encrypted: i=1; AKwUvBxcncWDr1m93RNtVZQnkHNsYeuqcFGCm6wBa8zsDDGcbV8V3ISrJxYKXWu824+KHtXAhXbnxXPEerBP@vger.kernel.org
X-Gm-Message-State: AFuF++nsvoMhWT0Afoshsz5k8oYuuiTxV6Z3bd6Dv2k3rjzc6BOIBeEH
	n+/+9MZ/eK7XU225PH5Qs3S/1PMlo4fC9fTYnh5ONDZcb2rQ6oBteBGZ
X-Gm-Gg: AYBFou31o+P+Yjscj8PKkOiOwPQ98AVJzzcgsLl2rt5Qu+9espVkbfzIuDusxjawv+i
	+pGVyVKyHbrCQ+9YK9aJzu9p43NbEUG0ULxhFLESWXIZ+oofbN7OFlPiHhlU3FM202Cxap1bkeC
	yoQFnfNNeP0MjKVABGv9ebeMSwpkgQ9062qOyG/AmwvEjMAltFF1hxewI7VsqspXJIBUyL+Q6rx
	c1sLyPkocS2tovCC8YNnBzbYiqgTv/MgnKn6TeCp4XHMb9psZVaeYiJX+V1AAudfaiHu/B/7DZT
	lKEsdkGgYlA0kj88BrnPPlL27kJYo1ljIPRczsRbnXf33B7Asb4rlnvG01Hf9GJLtUfIN6T1rzD
	KX68/JIRQfAQG9oB75NSuu1R5Fs96kXQ5v7CvseBEIlWAFLurOT2wPckJeBaKSmKGbIHiyd2MVJ
	Cxw7pnalRzdx3yXFr+Rezk/D2ZbgQzFEpHy3Ioazg+0BCnvtq3LIkemG3xPS7fMCQX4earXEsnm
	nrhqCU4fxYbJ6q0tqxuta0qfBhHQWIB77AM31Dm7S778A7773C7cJ2cpbySL2K6CCxuzWPyZp95
	oDe6SGL47U5Nzy0eB6JKPk6jQqZaRRxIwaQQhVxMWrf2IMBu8hg6N3PGnwZFDfjdXmLXW9Zb
X-Received: by 2002:a05:6000:1a85:b0:485:8c17:9775 with SMTP id ffacd0b85a97d-4858c179a0emr7751270f8f.55.1788591836769;
        Sat, 05 Sep 2026 00:03:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:56 -0700 (PDT)
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
Subject: [PATCH 1/9] docs: kernel-parameters: Drop the atarimouse= entry
Date: Sat,  5 Sep 2026 09:03:39 +0200
Message-Id: <20260905070347.25902-2-kmehltretter@gmail.com>
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

Nothing in the tree parses atarimouse=. drivers/input/mouse/atarimouse.c
only takes a module parameter, and git log -S finds no __setup() for the
boot parameter anywhere in the git history, so the entry has been stale
since before it.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..c8d96de4c00d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -591,8 +591,6 @@ Kernel parameters
 
 	ataflop=	[HW,M68k]
 
-	atarimouse=	[HW,MOUSE] Atari Mouse
-
 	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
 			EzKey and similar keyboards
 
-- 
2.53.0

