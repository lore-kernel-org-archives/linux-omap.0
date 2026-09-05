Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5723D45F7
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591860; cv=none; b=lC0TOHyNx0LsPkOaFwq4qjNK/jhRwCxzplYi3ASNsXLo6K9WK+12Jg9F1bKtAvxIzXjs5wZrzYlL08u2DozRqUPA+epBGgDKHNdd6NrJuYLbBhVvh1PJzojsdO0l9O5C48aBhv2stJWAR6FEc71PFyFRiDVXsBsnKKFAwnqrtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591860; c=relaxed/simple;
	bh=pPxPTNpM/nAKvWxY9H5AEsCMADngEkeEEOle128cyr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KL1OACxq9bWUIfryqPMQN86EuSLJ6lobM7APVTLVO6BiUeXQNRU0+wXfvhp3J4VrSkYoy9CkwZ1b4DNF/ufAhuIzZbzAtysgKdRwcaWBOB4lYcUAfn/3V9IpKkg60AtHxcqfmvyWviECSP3c8agB5vWEXp0DRm3+Bts6/T9+v90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufys3Hf4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufys3Hf4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-482e067e908so1572126f8f.2
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591851; x=1789196651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r0TEPPXgHP97qr/cFTbi2WII06m9YnzLfHQVRRK4PYs=;
        b=Ufys3Hf40M0EzhImnoudR3WSMUwBOrbN7Taboome5GjqVtxwI5tiMndrMjUZtrzb0u
         tK6f+gTpLgllMJq0uTRIdVUM2ba7tKqF+hT6HsioTq1CslyQk1sgjTW7fogCc0Aavtrn
         B28WJP153FbCtnjpSgK4GIYtwAAKNOI8b3qfrR8lBeoGtsPx2WrNMM+iS21NEvcrdJ+Y
         koxzHGYZxc+KDRfoCxwoW3zmi7MOUoLxcLyZNLQR5L8Q4I+VMXuUOVbI5gKB2VgJyFXw
         0+LanghEEKkSJWdgoQB2B4+HX5qgLUjnIKBD8aqa7MWY8nQgLLnNj5vzsTFRCVEtpd2r
         C7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591851; x=1789196651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r0TEPPXgHP97qr/cFTbi2WII06m9YnzLfHQVRRK4PYs=;
        b=gieGPAM7GXr4pRgW/7/F+RzKD9rUh0SQQUpf+uVnSS/xUUr9N2ddfV/8pFocHg3Vjl
         z75F+nelJ3XyadRGIRVcMHHXs1CYZels5HSCGbD/kSc46dGeBBCvwMQ1kh1q2HZBSS5J
         Y0/z91d5XKeql127nmHNDG5vZ48iFTMDMddNGaBXeaIErMMMt8p7itkBC3AK33yil29o
         aAZ+DLtWV1mS2bShbLaBSHNcUmE0rNpTb+5DVFn6PPcsIl01twZjvWdRAcf4KEn9vLgM
         zZuVLvzPpJwzyecHMg/N2hbfFzJJ+BsgFUAwl6UnwcyBZd9pk+ZPA5FrxQ14EC93oTUq
         3bmg==
X-Forwarded-Encrypted: i=1; AKwUvBxD0IWZq9Z/UDwGJtIYLYuEWGnhQQ/pSEwK03ruoNdl8zOKxMHvkmEBo8RS5L3UFYF3YTdKOG8MDMxo@vger.kernel.org
X-Gm-Message-State: AFuF++ngj0qfwu5DL3AUQqDtEFEo78Prqz7uNukvqJ9W3qcP1+SLg2nj
	eHbmPLpUrFZmaUHSUMLR2s7k/SfBf8XZr/uwoZ/UmXn0XC7bJcg42cZU
X-Gm-Gg: AYBFou1H1p8mkAPsqcXAjKAYujfGKvBGclJXnO8p6m1wd1AIotiY8NanhpSMB6IfXX4
	WW+SW2JzUlPrJepqEMsWmX7q4CgAxHWr8J2vmhzp3oJVzjQKPL1J+bviJTDxk7D7+YThRtbg4ZH
	a8h0mYqVcMikfcdzA5gsLu7MAoVV4/xaYHbENQznUMEPQuZofJCvawZsaNhCCf4oQz34SrQEgMN
	bF5FYhuwDqtpGjsBo7uSchKEDjdptcI9JXa2J8HCQ/igp8QkJxj/8DOtKCYP4CugoOVEr6oC2uH
	K5dDS1WqzdFy2VM4ckiYNPivhZzzLI6YeV2oWbScAwtBrnNeB9vDQRzr6kQjbQ3lkvy610ExECL
	IcqiDD4iXqjbFLUuPxAAogZeVtui0YtSCs4UVLVyIUc0GvIquWVBrKHgdmV/UW8izUWP2tinzTW
	GBMAnUyclRXjC08a2XWB3zYGGiNNMKt9WdzxGtIQQf0vh1/bDBYsUEbJoT5sdnSjBOidPupMzoG
	vCiuVuzLyjO5fbWdq7E29B3mc2+jFEa4X13ELbsG+8SSqEa5BXtc6fP+2QiUuUP6JJoKy2LcmOD
	7+uzKKvv260l9S1pKwVfBW5JXbqCzHKJncHyyD/+5CEHlu/scGW6ocyO9aXo1eFgXntBv0hm
X-Received: by 2002:a05:6000:24c4:b0:485:8a46:7053 with SMTP id ffacd0b85a97d-4858a467176mr9452131f8f.37.1788591850939;
        Sat, 05 Sep 2026 00:04:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:10 -0700 (PDT)
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
Subject: [PATCH 9/9] docs: kernel-parameters: Drop the pata_legacy.qdi and pata_legacy.winbond entries
Date: Sat,  5 Sep 2026 09:03:47 +0200
Message-Id: <20260905070347.25902-10-kmehltretter@gmail.com>
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

pata_legacy no longer has qdi or winbond module parameters. The QDI
support went away with commit 0dcd0a76370a ("libata: remove no longer
needed pata_qdi driver") and the Winbond VLB support with commit
3c4d783f6922 ("ata: pata_legacy: remove VLB support"). The entries also
refer to CONFIG_PATA_QDI_MODULE and CONFIG_PATA_WINBOND_VLB_MODULE,
which do not exist either.

Drop both entries.

Fixes: 0dcd0a76370a ("libata: remove no longer needed pata_qdi driver")
Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4864e37005be..33298da28b55 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4994,19 +4994,6 @@ Kernel parameters
 			the first port in the list above (0x1f0), and so on.
 			By default all supported ports are probed.
 
-	pata_legacy.qdi=	[HW,LIBATA]
-			Format: <int>
-			Set to non-zero to probe QDI controllers.  By default
-			set to 1 if CONFIG_PATA_QDI_MODULE, 0 otherwise.
-
-	pata_legacy.winbond=	[HW,LIBATA]
-			Format: <int>
-			Set to non-zero to probe Winbond controllers.  Use
-			the standard I/O port (0x130) if 1, otherwise the
-			value given is the I/O port to use (typically 0x1b0).
-			By default set to 1 if CONFIG_PATA_WINBOND_VLB_MODULE,
-			0 otherwise.
-
 	pata_platform.pio_mask=	[HW,LIBATA]
 			Format: <int>
 			Supported PIO mode mask.  Set individual bits to allow
-- 
2.53.0

