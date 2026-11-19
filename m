Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117784;
	b=VUZpEJjhYhttiQ8pqDwfPj7wYGFGHuHr+B/aWLNqXMbflayxAVOt1rVF8Itbvh4em9CY
	 lFAncHaKT+ukvu7AsqwZx2oqs9qx5UZS92z6ErScgWufTgzaWlXT0XxwgC9EgcwJW8yuH
	 iq/WCEKdQ4VRXisRf0kHJztyKWEK4B6zLsrIBOxjc0fsBOdyf0yNRLkAvb/G0qPU4gvD8
	 VaV2QrsSH66JGW8nh7t2vq1fpM1nwZt9TrYE+pOMoSdv8L86Zs/mEvvapN6iD7WFSmYXY
	 Nu26JF5YFIgAPYlLNdTa3vt7cAJMcB0jPPPD52je02awbm/vCHC8qThb5FtACEr47FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gDsAJvJzkxTjWKsQDYc43r0mxoSvKQLIjsKVDf45Mok=;
	b=rnpsssy9gmdpCuSWrTydbmkrqg93P/xtwtNRF+VoGUBM+L5FmLHJ8R+GXOrp0XawpGLw
	 rYav4xKfEVikjvcBnK5tnFlNJHcLUT716RekyJCxuLnt43BM5njvq9E+p/cJEEvYZ+X5H
	 SlgvH//0lctDHMImAChYEiCj+tPRN3hJTauf39TtDPVN/XLimNw8Z6jm/feZmB3iaZc9A
	 3M5hbY3PFbrEFCFn/I6VY6UmfXYwKSYEWHzTeMOrk0qp7GVWeRbulG/MdcHyJ6JyY41rX
	 0RH5jX/MxlowAC255GhMBXajwbTycmXuRUjOGY3VPZNszcbc0NV7Wy/bWPnbrIydyKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igbIo64e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403460A2611;
	Thu, 19 Nov 2026 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igbIo64e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4581F000C5;
	Thu, 19 Nov 2026 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117784;
	bh=gDsAJvJzkxTjWKsQDYc43r0mxoSvKQLIjsKVDf45Mok=;
	h=From:To:Cc:Subject:Date;
	b=igbIo64eiJnIUIW03oOk9cKCyhCAZ9rcJJMK3o1KRYPZc4X1aSSzlR+jKoRglV1VR
	 UdaM1gWRSVgeBl7JYYEPAZ+8BKKuGNhA0FzB2h8nVGkZSrxGso+2XKRJrxsnGjhkEL
	 PknXTOklzuUUbM9yVY31+LPwZKiT/Qgp0BZFFeUjWLG5s39k1Vs9x1J19OL3D3jo3A
	 kxa1YtYEDD3JUXLgjzZ6c93HmwwPhHMzgLNLL86frD+UEdS/QQV9SY33muNMyiGGIM
	 A+imCOcZcX7++H+H164IEPMm62NtKfQ5dKGuCxOLbawAhQljzfARxTCxb30hwGgx8M
	 iCMjYgcGKP5+Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kai Svahn <kai.svahn@nokia.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	syed khasim <x0khasim@ti.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH v3 0/2] mfd: twl-core: Fix dangling twl_priv on teardown and probe failure
Date: Thu, 19 Nov 2026 19:49:28 +0000
Message-ID: <20261119194939.2436337-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

Patch 1 is the minimal, Stable-suitable fix from v2 (13/27), which was
skipped when the rest of that series was applied due to a collision with
"mfd: twl-core: Unregister the auxiliary platform device on unbind".

Patch 2 is the follow-up suggested by Andreas, converting the manual
twl_priv reset to a devres action.

v2 => v3:
 - Rebased patch 1 onto for-mfd-next
 - Sent the previously standalone devres follow-up as patch 2

v2 (patch 1): https://lore.kernel.org/all/20261027093306.2812695-14-lee@kernel.org/
v1 (patch 2): https://lore.kernel.org/all/20261105110332.1874728-1-lee@kernel.org/

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kai Svahn <kai.svahn@nokia.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-omap@vger.kernel.org
Cc: mfd@lists.linux.dev
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: syed khasim <x0khasim@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

Lee Jones (2):
  mfd: twl-core: Clear twl_priv pointer on teardown and probe failure
  mfd: twl-core: Reset twl_priv using devm_add_action_or_reset()

 drivers/mfd/twl-core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

