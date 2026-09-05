Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03BE3EC69C
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601629; cv=none; b=ao0vT2qGbGASPuICvZFSLBJZEDLuY6AN+1G2DgiUTU2GYnliN79Oeh77ISVDfQmpZGOwumQn/ua0aUrAwO237z+xP2wcvIIEp8wSjn5m1nOm9tFwOn2y+fzF+fKWLtdxpPhhYy/TMFgrzIS27iFLjLFhN+ENdtEAKNWkwIqvbZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601629; c=relaxed/simple;
	bh=r1zTAstGx+IQRZSz2V3LqeUHrdmsIckPyGpER4pVwcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNPVWm8+vvU2iAFIEIM6GiFB7rhvIH44T5njE+W4l2kkS0eFVyyiU/wKC3R1QwqsVKI+EgCS2M37oSxb5HOlaDRomLv9bC60sW5ul/TexzO7PNxMRvTtpe69atKJ4GSXwD38kU12eKkJc9GaVxuQaJ+ck1xy6c2uz84rPk4LaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqzc5uFI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqzc5uFI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so16379315e9.2
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601620; x=1789206420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rL+/iAM/i65sRrJdGWBjEYqO95wvZ81bUVdK7eRsAk=;
        b=Mqzc5uFIvQMGJH/Qvx9JF0IzrPctKlDeb9yowyBBnvUHbJf5jBARJGIOZJ45uNB28k
         8Z4q/bv2SqU25SFGtZ61Xd7F777i2Dq9EaTA/Zrj/rZFEXnioKAWjArU0Qu7i5h7gHXF
         Ner24Ov6fTQNGs33qhIXnkra+vE1dBm7taglV8UME4MALkC9WK/JVUhq9u+mXQj+o59b
         wKASP4FMp090Fsvh9lvAmn3il43ycNJs1EMS0myNTLfxMK+UoErDjiHTKDGPBw0vwUq3
         KnFQWL1E5SlZeG2rkKaJMNU9CyAE4Ob48i9+WHPenGupCpxuQvAs1KuJ5+jSwkCkwIDA
         +G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601620; x=1789206420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rL+/iAM/i65sRrJdGWBjEYqO95wvZ81bUVdK7eRsAk=;
        b=T1SajGv3mVOZF3n15RumgAdGFysxf6s7Xoidjzs7f6HUK1Uo6S3Eh4RAh3frPlGMC0
         JNpl8TuYD0x1N9pMuX8vauXt6NES7JqZYaIugibiVJOqKerTubuekYxW0ApaHdQGJCdm
         Mem1xQG+ZYjO6t2Ir4Qpt+B1CLvb9+bEeXGKjaxLJazDbepRcTAJYKz6Z1tMJEZ0cG+c
         FEm3+IJY7VeUJcZH9IbRkX2tgBW8dqVXoveghsdsVDbVeOi3Ry1OCQQjsXIafI3dtiGw
         Th/EjmTOXxX+TSpk0Fb6DZkYK8HciO8tAXfjbUxNJvntHjFEiyjrk35mlqWZgy0BoMrE
         dGgw==
X-Forwarded-Encrypted: i=1; AKwUvBxtOqxZnTjuvivQi2Weh9yvyaQqa92u/v/q/M2b4aw4zBfdsO810eLH/RX6aLzZRSZtzVxRks3AqRIT@vger.kernel.org
X-Gm-Message-State: AFuF++mc3y4dyyY3MvVttw7uJu7gBHoqrfDHWmG8CDGqgvBLzvlfjMzJ
	S6OUAkb+jtRgKUe8mHjoQrVCNqp7vMiqKdbHe43xWgkkJ836VfYvTXo8
X-Gm-Gg: AYBFou0gmcNocAmIA7XdGHVOxEizPrYwF98nPKs3zzOwG9X9x34vIVCluwRZqHPtHQB
	DS48Jb0+T0jt9tcXnj5PxTfFHhcMTQLx/rUpfW4y41GuTuekKdxZLyK5qGYZLboROhyW3ZpoyF9
	B+jXR6QMUQnIBXjvud0XiJwx0dR6DG78BUsYafw4iZbCbaZnX97vEAWkCzXikoCv0dNOTRmjta1
	RoysuRtY3F25DrnGvUXu1yCE/my5Ba9UZD4ro0Wxc9DrCSXUTzUDLpKEhHtJRB/c34c9/2igfTw
	b/m56lD7NNwOv5jLCjo4UFrvLxUsoBu19wf3fczFJN/bR+0wLMboEkkv6iJg3dcnly0Io3k25bx
	3avYnJY0xQr/QjfWztHFheVi89OHIV4Er7FdQgqo5KReeQ/ovh2R+o0BzhaZK1TIBPaq/mWksyU
	ik/JUjlqRLY5jSiryZt3rCogW2aMKlomLhqf9SKk7R67OcJ95d784rmcExXa4vZNiBiJx/nC1zh
	bAmarv6ilFa6mvvD+RTEON3FdZfHq/i2dNVRCe/iQsqHJdYj7Pa/KD0AF/s5eKBBFhc00OFhJIK
	T9A2nAwwTUZDXCmj3Mf2xLeuTWNb0FwrMhIY2F2chdbtnPJbdLDhboiXnIUJ8b4tD6c=
X-Received: by 2002:a05:600c:3e0a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49cf8267a36mr138818915e9.12.1788601620145;
        Sat, 05 Sep 2026 02:47:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.46.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:46:59 -0700 (PDT)
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
Subject: [PATCH v2 0/9] docs: kernel-parameters: Remove ten entries for parameters that no longer exist
Date: Sat,  5 Sep 2026 11:46:40 +0200
Message-Id: <20260905094649.41996-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-parameters.txt still documents ten boot parameters whose parsing
code was removed with the drivers or platforms that used them, one of
them (atarimouse=) since before the git history. One patch per
parameter, each with a Fixes: tag for the commit that removed the
parser, so the maintainers of that area are on their own patch only;
the two pata_legacy module parameters share the last one. Each entry
was checked with git grep for its __setup(), early_param() and
module_param() handler and with git log -S for the removing commit.

Changes in v2:
- patch 9: drop the Fixes: tag for 0dcd0a76370a, which removed the
  separate pata_qdi driver and not the pata_legacy parameter; both
  parameters went away in 3c4d783f6922 alone
- collect the Reviewed-by and Acked-by tags from v1

v1: https://lore.kernel.org/all/20260905070347.25902-1-kmehltretter@gmail.com/

Karl Mehltretter (9):
  docs: kernel-parameters: Drop the atarimouse= entry
  docs: kernel-parameters: Drop the bau= entry
  docs: kernel-parameters: Drop the edac_report= entry
  docs: kernel-parameters: Drop the enable_timer_pin_1 entry
  docs: kernel-parameters: Drop the mini2440= entry
  docs: kernel-parameters: Drop the nomfgpt entry
  docs: kernel-parameters: Drop the omap_mux= entry
  docs: kernel-parameters: Drop the pcmv= entry
  docs: kernel-parameters: Drop the pata_legacy.qdi and
    pata_legacy.winbond entries

 .../admin-guide/kernel-parameters.txt         | 67 -------------------
 1 file changed, 67 deletions(-)

-- 
2.53.0

