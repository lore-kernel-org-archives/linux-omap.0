Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA43DB339
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591840; cv=none; b=GX1/31xG7FjzUcslJHGO5SlL95MWw/d0Thw3bEFgnZpGQBck8a8Dl3IUGbr7yjmvVa3rQPeHZaxCjeaBppt9cmNdfPM0uP1blYOxAgr9ixuAOx4NOhsNWpomPFN+5UFypMjlvdCHQgaR3JhdsBghx5DzZpY60P6PgMSEONsSB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591840; c=relaxed/simple;
	bh=cYocdUbY67Nl4dIpxLMGG57akBMxyeedBoJqIxiyUr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k5NhUemAOgESe4KWdf52LarN7k96mb0T8cPTZTafrKsHawdP+LwLewOCPD4DN+Kv8mAjDML+tj4ACluemvmefd4hHpB6qeVomES+2SqonSn6Zu6cMA2qC7gT/rT0o+Z9crDV6HJpcVGyysa78fJP4MRyw04h7euWerJcLfOsRj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sS8A+LZv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS8A+LZv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso20115455e9.1
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591835; x=1789196635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mRF2sj6EV0Dui3NmrAkRlrIYgvCUUxE0IVt3jvr9R7k=;
        b=sS8A+LZvQz0V8qLYy+YYcWwHbpnZThCjCqaGdb+U5pTUuv/j6+Ede4J+MgzUfU5LHR
         v2veE+CpAN1YERMqnENv5lKtWGG+uq6h2NDD0TZLbbS7Zg6avN94OJLTqaWF4NhjBDhF
         I6ler63uYLrzlFTb0je0e6QqxXwrhCuRkJPv68i451b13VPxF3teoU8nzot1PvfEgcJ4
         cVuoZA/mRtCVDwtkUYWqtuceSXlAj3AHCyNBogBMHvvcu+9YAM6nlbSexzN5R+M4Z2Pq
         qtJycT6ELRz6UTCJk2t/COvlSHbNjwqfI4bV6Et01e2yyhUAoWzmVCRKv4sI9vWsLhXr
         vf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591835; x=1789196635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mRF2sj6EV0Dui3NmrAkRlrIYgvCUUxE0IVt3jvr9R7k=;
        b=jskPAkheIfbl2j1b22k1abvPQPqrtIh6PR44OMpTeFOq6Jhm0cCL7PpfcBc2dRj8Eo
         y90xrXKIrf0V/iqsx2Ef9MnafYfQKjpQsCba2Iu4E6UjYoSPR+MqQkUidtiW94Wxp+TC
         oh0dvZTo2ivUPGRXgQ33BI1p7ktnPhlyj2fI4C+vBfLKk6GQLcPdIoxWSWb7SBP3bQSN
         baQCNP2/tJR0nfcqjmtnHRNuR5GZMl1TaoNMuvrXKzWcY1bQqpQKX/+8KmdhXXpAuuO4
         st04u/iV0AXTrNYvVSCc5cFKMaubJcNIs0lLlMlC3vSQXckNUiXb1Msu6JatRrnd/5Pg
         1Lcw==
X-Forwarded-Encrypted: i=1; AKwUvBx3s/3B1zW1L5t+/iN26mgXEXmi/t2LirV6hA/uyQ0vbGtLV2G5QpszAyKj9AtM+KES+lnfkcPVU4L2@vger.kernel.org
X-Gm-Message-State: AFuF++lZLs+Xkle4N+9Q3CwyJXD5JyFVqcd/TTrye1seKRwoMCO16eZx
	ThoX6rvzXjC53cz8ZNnXwMpvhg2lYNssLseSHKBZ2/Wxevcpiz3BfmP7
X-Gm-Gg: AYBFou1gB+7kDCoal71DCeMKB5xH8qBfUxHaDV4yB9pSkEUjzQkR/ZcBVEIL9sT2fqr
	LCANkYUsLrbFxGz//r5268fYDX6J2YvfsQ/iGrY2qnw/APmjVHh6frofvY7CkuCp8WrHZOnWvqP
	hJqmXQpOPM4iqA+ubGBDVXNo+gl41d7a2RI6V7bPdrcBOIuu0W8cs84VxVzsv5YZMChPfE3q5PA
	kSh5+t6dbePbxoLy/SWyBxrxi9mrgMC1p0/MjroGXwOvKcbdXWWhB8Fp5cJIrFE7TZI4BdTmbMa
	doAn0ZC+0sdNNyykRVfB7/iq0NPQjz9sMx357zZ2keb/h3CtVxyd7DKmUIxkwAQ2XaH23D7YyFv
	9wDFcwyUg1RjKi46Ce4HXKrZJVC/AOGF8vUoeZ46aOdBhvVTQ49L8uTyaW5jokAsGWqupulPxk0
	Qoe5L1klqn0RpRV3LL3kNKXvUYhhYd627wMPpC0/fuhSQRcxAUt1bGEAjRzROm1nbO4WQijbzmr
	IHLbf+/UR8XqG4gjagEro06QCm0Y1i9IPK/QR2yw+g3chnVFMww+sdVUPkaz5lOFrDakHoDtmFn
	yabW6nUGIqALUMOGt3SfGiYHUx3sAcXhxMA5ewnuCRymnESQj8GbzSbTTZaoFfdxS14X/1MH
X-Received: by 2002:a05:600d:864f:20b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49cfc6e8ed8mr59365875e9.33.1788591835143;
        Sat, 05 Sep 2026 00:03:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:54 -0700 (PDT)
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
Subject: [PATCH 0/9] docs: kernel-parameters: Remove ten entries for parameters that no longer exist
Date: Sat,  5 Sep 2026 09:03:38 +0200
Message-Id: <20260905070347.25902-1-kmehltretter@gmail.com>
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

