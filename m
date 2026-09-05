Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDB440A1F
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601639; cv=none; b=S/s2bzHk8/sWl/voPKA3jE+UAfTgrFQIGcybDclTVZd/iCLTC5mVYKPoXHy5P1CnOQmbyy8bE9Ty+wwFClczlVOX96UczW+oLZwxFghrLzPq9I6EwV4gk0X+1lu1W6czbIeDgbXzt4yE4lYk6pIC2Mzdf6IFLl/MABmYrb2uIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601639; c=relaxed/simple;
	bh=YsfDHjDKsIWAkoUgaj1imFKWTfOFfJnvMXwuV6H0pgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7c5kaHYmXbDxMCXXEBWNaeySeLjQwTPHaSsOe6yTrTLJ31NyO3F3KxnzEKoGc/TXYp4uAc8z3zCmFnyCjQS8q/he0B6v4a3gIFa2ThH11TytUdnNJEAbF2saZGjqfRAQv+KA7ZifDF8+FcwGWalBFXGU81s7JawgqHR0k45luY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF6eznBR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF6eznBR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4843e397f74so2283131f8f.1
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601628; x=1789206428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9h3cyhQ1bY0apuRrAImVycgRtlSF3vYdx1yKBS/SgnI=;
        b=WF6eznBRtkwHGPWcdSI5zmE6nOZXyfhdN2pXXayZzx0BbgJPuw+KlFuKyGt+oPL4Gn
         x5Fdmar1PYKUgTWNQMERUPVz0nv7Mxix0vYmZEYWQJJOKq2IhCwllLS0NUlGI53+Sb5v
         5/bNjxfGOVPTwMCDRyEgg8niqb1POYfm+DvWwohpgMrPJQpIvHANwiBLbEd1TEAyWkB6
         Yk0kGOVhMD6W24IF/0oUwz3EPVKNZvvniPgnF/EmaNhO2oDa4d3jzD/DgSjSYE1SDRdD
         eJVT5P/AMMCz+8MsEccoS5fKN9eLm8DUge+M/Pg7OhsbQTmPGElHSKeWCxs9g7wuy/tx
         Kv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601628; x=1789206428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9h3cyhQ1bY0apuRrAImVycgRtlSF3vYdx1yKBS/SgnI=;
        b=SCULnsuwKnvQUgm3XveNTCKgOsnHFBuUUdA6xYtqoBfT/eZeDemxz/9bLuZUSk3xct
         /ZiLZc7wa2Mb/x3zrJkkGmHHfFXodLwvaQix5fJWQZlpnUiPSkDyBDVnwfueViv6fO0c
         50oMaH8hSj33lXqax1hfc8t+F5aax6J5LpGtIM9VgR+lx4aJA5miMqlKdQ302HyMQ0Oc
         XpVYWjXvvI46hJ1Cz3CNrOYyT95DOaXgeTj/916Ws6iTiJeLbMXLSjNT65JdDMi6m+Rz
         hi/xLK+3+dljCpFIpOqvaRw/WH+dNJammaEf3ZGrofXaVg6AMoDQfmZ3TAYXwOv2K8BS
         +Qbw==
X-Forwarded-Encrypted: i=1; AKwUvBx83MWE3tuOgpjEOeBPFOIqmNKPz3ZUMjd29RzJuAAkCNpUTyHq1sNN/g/EUwRDoJ2Zw9Mewd56b+wJ@vger.kernel.org
X-Gm-Message-State: AFuF++mSzjxSF5rJKIxo2vBWLFR22jFSlvOkgFWmvoqpAMGI/6S5hiA/
	6l5KC71hfvOwyQoyaD6eh4G+juQ9zwFZqiN+tpZw5H8mctGmUNQZclnm
X-Gm-Gg: AYBFou1MxcljhJ9S8ZOmMJToVvVH8VF/vTvOXg6E8J4FwqB7FhKsAzwMTziRUVIR0r0
	Lu3akvS60XMuCc3ND+mzd2ps95x0kfaJXcV7QuoQnPSZgfaUmbZK6GgWpTwZlqW4GjE9xrRuOrY
	9N1Yipf5tP1Xj8xsiC2ME/3ExhyPl+RFESUX/T5TepcFiO3JOCeKwyTeCiVGdksVIWNQJk3jgf0
	IBX3NYsWskkk/M4FYK0/FNQ3dJ6gliLmu9rGqMPZ9fHQTlgXK590PRDUsrMA5o37euhHQkHaxgr
	UCWapeCbwSQYU518oh8y2HBAgkAfXSacu/XOrRcg914kfum6TQngMwAsO7xL7NOXzbw73HXwQ/4
	a1fgxQKqwchcNxW4qweQXcINoADHDYFWx7FLAq+JmZoqcNdePSCQ6VFe9xSC0onv91QRPPI3qeS
	PQzpzWF0F7uk7QD5xD7fFRuiwL1dI9vbqC1NnKSv4pxJfLfIlnvwExeyIxl0UgMnP0PW+5HMOQp
	Fwf0H3FeK8jCIGMC87S+FFece5EyVPYh/ZGF4oFpGXFNpt85HYbrrR0Nl8UNj3mXlXt1jL4+Egb
	T22aw6jk/HOx4nxPEh91aIGDdu/TpvjDXdDBpCNXiBwd64R/z7ccJqAzB7IyPHYXYJ5+bcF3740
	9Hg==
X-Received: by 2002:a05:600c:a307:b0:49c:f13d:ffea with SMTP id 5b1f17b1804b1-49cf13e05c2mr154976805e9.14.1788601627485;
        Sat, 05 Sep 2026 02:47:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:06 -0700 (PDT)
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
Subject: [PATCH v2 4/9] docs: kernel-parameters: Drop the enable_timer_pin_1 entry
Date: Sat,  5 Sep 2026 11:46:44 +0200
Message-Id: <20260905094649.41996-5-kmehltretter@gmail.com>
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

enable_timer_pin_1 lost its early_param() in commit efa2559f6516 ("x86:
order variables in io_apic_xx.c"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: efa2559f6516 ("x86: order variables in io_apic_xx.c")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2a8d862ef30f..f4314492953d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1647,12 +1647,6 @@ Kernel parameters
 			to discrete, to make X server driver able to add WB
 			entry later. This parameter enables that.
 
-	enable_timer_pin_1 [X86]
-			Enable PIN 1 of APIC timer
-			Can be useful to work around chipset bugs
-			(in particular on some ATI chipsets).
-			The kernel tries to set a reasonable default.
-
 	enforcing=	[SELINUX] Set initial enforcing status.
 			Format: {"0" | "1"}
 			See security/selinux/Kconfig help text.
-- 
2.53.0

