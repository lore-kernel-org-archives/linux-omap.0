Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201192;
	b=3YB5xVK/+rJY1kfN3NU4vLwMnTObF2wXTuzfv4kK/ZU+LiwNjsxn19HltviXOEWitxPB
	 +e55iEDLOvYU/mbvYDOiQ4yG5t9Ffsy0lzbBFymiMrxO+iRLWKOsVLJ4pX3rdIuyyybVT
	 XspDrUiQV4k2cQ6k3QQ4I6ef0FK+LBvOkTA7BBGuFsw2G+d7QA2bGIH4rZEecQtDprjEy
	 7POF5GG7i7UlpQJBDJ+EinhdIQgTgcj5EWVYcmgc+i4o4t+U+D7fMMg8h8fXANj6G4Tgv
	 +zEJv8Ybp0y57ONzNnDvRzi+G2bMRSLAmX/HR9AostPxiUnBBnwTuF/PQJhpQ7RlxKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=y+xG+koXTgpyKRztQQCKLUQgqoHofBaalUCYpzlKwFk=;
	b=XQ1wiz4t0O/3DdG3YQ+RIzCqjCu2tJPPrifIL4oe62t6gRCxDgBbXoedzifNY8GGFjUI
	 iSVphHqTrqOek2ZO043LviO9mMFKKGwumkBSc26lNw9rIqd70kuKxQf6sOthctKQMvzfs
	 pGC2chvcWB8XKz+VwTUD4U0tXcQ1a4AbtNkq3I4L1y/RZo/YQSQh9PQ1fhc/zcWeSshJB
	 enL6ddrUZuC2S2dBSdm6zgVeptoKW8/pgDp5gg2zAE6w8qyuL3DxMVIPuUeb5Q0oEy/ia
	 pjFUqM9Vvg2M2kIPErinxMIBaM+NeLHXZla3XiiuPP2i2xKsttQxDiqFQ2tQIFQCEKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZwJ3I/gf";
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4960A2601
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 18:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED4960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZwJ3I/gf
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so492711466b.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201186; x=1795805986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+xG+koXTgpyKRztQQCKLUQgqoHofBaalUCYpzlKwFk=;
        b=ZwJ3I/gfafwZiWA5aZDcO+609t3J7/x+kBEjaZHwXFdrLDUlZmBT8ZKqFYEwEX7Ob8
         ykNW7FobzosPR+C6Sz0Fdw5qJiQq/GIeyyFcKZxvMxXR+Mka6M74WbVWT45oTZIUatIV
         8qtng2vGdvk7OiLUYXL9BKQD8WEfaxScKpXsHREyR1kMEYzXCPF0d4vlUq426eD23JQO
         UtO4CDbwI/qfXZaOZoj9CxO3BVYjizp3+kddEc0R8JHtenCT8+yKt+elCXEWaNirbrEE
         03HYg0t7D/tzdeAPq1IF2ALgqzNFdFwBod+xSdSg0rTQRrJPksXrmsInAitjjot9hPYn
         cC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201186; x=1795805986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+xG+koXTgpyKRztQQCKLUQgqoHofBaalUCYpzlKwFk=;
        b=16CEABFa3SdR0CwRYo8WCMMdyXlfwFTYKnfDXzbJ28TX1TprZ8/xnvCe3CHpdobLPH
         3+brwMVU9yHakMgZ0tQZCJX929EAwRS9RX+tmS//QYuL9IcAJsD62DevEWLp3VACYKcg
         Oxujol7yuhhVLZg0kh5U03sT/mBvJJtJXoLE7l4Pw957l2MwcOMSzxwirD9osgDsfmP7
         jlocIFkUvwt6iifPSjMK3JEag57GCoUrrY7cmYeNncKUcLUBKS/dnv6RnmhbvpMaWLWL
         ARUit17+WAtBvFq0IduIh1HGfMa2rMjCbDufsvyUWPV8nf4NNvucsvAoXMOi9m38vHVs
         XM2A==
X-Gm-Message-State: APuU4Z+coHT/x3HER1W5PjAYsN+9gxZ8aFXS4N7QekqSZO+2Lhcy6inC
	lFWWdvnqfdhhQ208ZFh7GIHhY1hpgbgEG4DEJeRh1SrcxJyDoz+gQ+YT
X-Gm-Gg: AYBFou1NiTJKFxMVc3y5tLeOwExuSeyFIpFwBvaTcnp34DVl+RLYHOmJ9zV6VrLJ3il
	UuI4bmKYo3YhlGUJqvraP+LxIJoivr3SYXvS8xbHa175PNfKBdlKbYuNr68QmRxcOe2sPoIE0KJ
	p4pq+Omr/TAza3f8sK0SneDtjE0bHoBk5cV2aLu6EzPkD75ehaVwUOKVmjkcVaqZcI5nTpYyE50
	yiH/D8h/iJywiNa3aSMyJi+mv7rN/dP2WUQhcyBxm6EJw2krzqFmO2gdJTM4HNaTruI9O9U0umL
	Skmh0bpKCmjH4GqkHBRQK7tlEMqiCFuGWrCAQDagy6lg7Kh2mq3QfosmGVgejTLmnVkGHCWIUyl
	jiIFHiyGzfFvJ87s6FWE1RiUlaKUr8WK38ZsE/81GZQ2igJNI5FhyJ5SyNZfmJOCPWVWw7vRCc/
	hKqyhuK+eUx4LLJq5D2j0Ss+ViGm5XQ1jzSKkeRJfS8WeVuiyjQqM2Ux3sSBr1u6Rvtwys6Y4ts
	wsobr8xTlxkJ+3UTNv2GUPovCKg65sZ6CQVMEmwzdhUFWIPc2PzMxuZCCpoY3wRnudugIzs9dfU
	jLQM6SgRFSh0muf42EJZKtjfzr/tlx6S9tzoNLCKBwyTKDF1VD9YuhWPrBSRXpw=
X-Received: by 2002:a17:907:2d23:b0:c40:2439:4d9a with SMTP id a640c23a62f3a-c51319c24fcmr565365066b.28.1795201186217;
        Fri, 20 Nov 2026 10:59:46 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:45 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 0/3] i2c: omap: add support for DMA
Date: Fri, 20 Nov 2026 19:59:10 +0100
Message-ID: <20261120185915.150228-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This patchset introduces support for the TX & RX DMA transfers in the
am335x/omap I2C controller. I tested this implementation on AM335x 
(Beaglebone Black) and things seem to work fine.

Kind regards,
Antoni Pokusinski

---
Changes since v2:
* dropped patch "i2c: omap: remove unused is_rdr and is_xdr function arguments"
* added `omap_i2c_disable/enable_pio_irqs()` helper functions
* probe: added `if (omap->dma)` before the DMA free
* xfer_data: signal DMA completion in the case of NACK interrupt
* complete_cmd: signal DMA completion in the case of bus error (e.g. AL)
* xfer_msg: removed incorrect checks `if (!omap->cmd_err)`
* xfer_msg: added handling of DMA/IRQ cleanup in the `b_hw && stop` path

Changes since v1:
* new patch "i2c: omap: remove unused is_rdr and is_xdr ..."
* probe: added `goto err_dma_free` instead of `return`
         in the case of failed `i2c_add_numbered_adapter()`
* changes in XRDY/RRDY, XDR/RDR interrupts management:
  - init: do not enable the above-mentioned intrerupts
  - xfer_msg: enable the interrupts before any non-DMA transfer
  - xfer_msg: disable the interrupts after any non-DMA transfer
* xfer_msg: added checks on `omap->cmd_err` to catch
            NACK or AL error occured during DMA transfers
* general: moved scheme-related macros to the top of the file

Antoni Pokusinski (3):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 373 +++++++++++++++++-
 3 files changed, 368 insertions(+), 21 deletions(-)

-- 
2.56.1

