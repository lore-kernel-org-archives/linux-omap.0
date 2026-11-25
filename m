Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632499;
	b=jYwRKsahUE8kQuj86MvK1VYsq3nvrNqMv5hSynp1zKO7Vwgw+Mpugzid9PVdc+Q/I2ad
	 1QJ9A38R+fhHC6cBEdgXf4ey6Sf4VxlKESPoz8HYRh/CnX/BwuA+HTz55x1tuZEMcnyF1
	 qyZ7ZpjbPW07NceUVb+GvjXyI7XPR5ZE5k9EiNIsk8HQgvbdtFQU+tYjYKpweTrfErC8l
	 rqtT/xEKNxraAAtctlCULv7XgmileBnEHJpq5kIxXwqklEv3GFCix1lahCojsNkJGb5C2
	 9su+dgUfmr6J0IOp1KaS/vX2bn5aSSl10XNKv+3fYT7W7sNLkf0OFUb63QzK/MDv0qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VQW/Ymb8D+uLvIjWbZ057G5GtIuukitNqjLkdiNCMvE=;
	b=O65ejCYCFbJYFbhe/X9RKDO2cpCtYR/dOO9ldKDtS3VpoLwNJ8IsX/ds+lE57SGFKYom
	 DHmQcX+gb0bO7Rd7uxCP/PjJcpXf83WmACWmYN+rrmapOGIyrysCq/c9S8G31gUZI/8De
	 nlPA0INTJx/3Y8zFYAkx5dSIu+uq980qt6bPg8wo4XUaxBfgfhVw4Lyffb+dhvUjHspA1
	 k++Wc6mVoB96k/DEToQF743UjSBea9kYyJPGUOkSYBHUtEUljbYVC23LgGcBaFnoJzvtm
	 EjPTrvlbrX1V9a71C+sUErWfgjyRhHTT9YErxX/vJeAlnybvMZbhO9y2tItCrPPWBCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNnBk9yY;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879A606A329
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 18:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C879A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNnBk9yY
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c51a02ad3acso173548866b.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 10:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632497; x=1796237297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VQW/Ymb8D+uLvIjWbZ057G5GtIuukitNqjLkdiNCMvE=;
        b=oNnBk9yYeUkh5s9pJTjawpl5to9WwX7SUukW3RYanpUXdKryi5g59gdyC013GPo5KJ
         44RoaPNMbHUir0M+Zhp87TWdQHbZM4kLUCrIT/znmwvN/7W+plDblEnJSJhJVNx59B1B
         chd0czeEamhlDzqBzlSNWAgl9RqCeMqEu6tglGhHKOhF6wrzB6GX//4va9yD4oR5ChIx
         6K6UWxCkBgpDnKlJT8uwYLnlEsvzSB8A3x8XJ6Yf8H9wGHX4cfSvnWq7kPdJ2YCYmOg7
         RA0MMU1tmW9T8fguHCAFFhimvY97TLhouhiNYSJ0/UyZSjdG48daDEwMt3AoiQ+nHBGe
         C1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632497; x=1796237297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VQW/Ymb8D+uLvIjWbZ057G5GtIuukitNqjLkdiNCMvE=;
        b=W6cv9ATpqXmNoIwZHazDFrYQbJCFEaj9tUKruM0+xIfnb0FugtygHGDLvART/W8PDZ
         ieyffvk0ur3Mm9sH4SjoKxbDiqPtSqAMCFbEzv0Y8vssX6geqkhuzDq5EZapOTnVPBLD
         SjSf60ftQ4keXrOgkeUoKnd69s1gtwEmG/WWvFnetPDl8Zg/glBhRrmfb4T1oFc8pMqh
         xSB4jvPaYqnlkCgfpRddLAH8I/6YucTnqI1kFqFHIfonGywF86gGqfWEqVGIfy+vHxDk
         eGYiqil/E7wHXbOCsXz8MOF49uRpZscB27ZzwU4i9qQ+kiWZSuC54Bf6cnjgo91uacyF
         mb7Q==
X-Gm-Message-State: APuU4Z+NScPkpctJRfs3g3DBMje1GUmOSTC4FGD3R8XJ8VJT4W/ylqU/
	IhQdcUv1c35l+awXy7HdXTgCdgPmttnROXs3lTr8SSXTrfK0ggKFhzBJ
X-Gm-Gg: AZFdTZfrWDwCknu2E+9RMmvaNyVngItAm8zhEwFvCymAOrUIqUZNHkA6Xz3DtX9jXmu
	+PWxKQcCqoq/FKIUCqwhgJcj6aX8ceQ460APFwQFwmie3WEUZqMMupTp4jSLFB1SxP5eBDbrxXG
	v2FT3peftmwMqca7O382+bqGRL0n+qtBTi/7aiQv3TCPU61vriIPHMdYRTI72pvHat9tqYwzSs+
	JnQs0lA68wjM4PRVduKgKRcqo82EoE41jYOPe6SpNlTGmn9UtAZAvZQZ5h/fXq9LbO5LQKasre6
	gJzZbn5Ut/sywMHtk8nbIYbLAxHzKGwOuEFgJd2yFe4PX1nGBhSCaslG84t46uDhL36aNaRxFxU
	aUO6njOb4jO9ImvSCkgETdTk2EN0nLPIOFRoIppjkryu9iXDk5BuxkeNjB2A6s+qqmW+OBZ+tAL
	pLT0wq7nb4Bhw/3Fax+weI7CFMaDTdN8YJy1I9kY98oLn1v+TXJccGsJLEAygMfiVWO2SfYjG4r
	Ha1UjJ97/cjwHO/UBt5spPcRABVvviHfloMgRNwLX4sJcQiVFdcIF/IeqGLb5NRx+PadE7XPpVO
	CtRCnMFQoQXH9OkeFdhKx9bHQ1uW7d7PHsV9/XRLeSCEJR98f+gbL1+rmvI=
X-Received: by 2002:a17:907:20e4:b0:c40:9b75:84af with SMTP id a640c23a62f3a-c513a5ec7cbmr1173636366b.8.1795632496938;
        Wed, 25 Nov 2026 10:48:16 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:48:16 -0800 (PST)
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
Subject: [PATCH v4 0/3] i2c: omap: add support for DMA
Date: Wed, 25 Nov 2026 19:47:45 +0100
Message-ID: <20261125184750.57866-1-apokusinski01@gmail.com>
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
Changes since v3:
Some minor changes to fix the issues reported by sashiko:
* resize_fifo: changed type of the `size` argument from u8 to u16
* xfer_msg: fixed style of the REVISIT comment
* xfer_msg: implemented fallback to PIO if DMA transfer setup fails
* xfer_msg: disable the DMA request as the first step of the cleanup
            (instead of the last step)
* probe: introduced intermediate `dma` variable
* probe: all DMA init errors except EPROBE_DEFER are now treated the
         same way: dev_warn() + fallback to PIO

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
 drivers/i2c/busses/i2c-omap.c                 | 377 ++++++++++++++++--
 3 files changed, 370 insertions(+), 23 deletions(-)

-- 
2.56.1

