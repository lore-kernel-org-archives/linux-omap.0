Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035171;
	b=LT6vMtcRG0hbzOX2Aujns1lpqQ6ranPYTkx6ZRc/oWoDE4RARWH2a9NxHANdGVyCDjkF
	 xV+hfAALM3kh7co4mTc+Mmuz3MG02MagdXSQvMnl6sFGrlWFl4QD1Rmz+QXEktfpDeMMt
	 PMp87Ylw7PotXDdugPO5oAgtybMmfM0c9GTByVjQnqmWgT/GntM5//+BgVXVZsFMSgNbY
	 4Rg0qqgTXDJo82LJ7vj6ej2FKOWG0s4Y+KgJ0oVW+HyV0IjUvFgS3txuA6drucY12eHum
	 neILSuiAwmoJjFBWj1HTTy3UkHCUXk1ln8ELGIjZTbKzrfmS3StIM2eOuZoNJxUGLRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=a5MhG98OmxdXqTOc5Xluyx99XKwhYZJ2KKliQ9c2OkM=;
	b=B6M4dl05dHNsjR4pRHQMqNrzw2O/JsZ7FwMK/pymzBHqR/fey7/JJxzf3t490onDH6zY
	 hLMG6Uk8sz6eRRjenYSIgxx/nYT3Aarw7CGTCsqMeByn6W7cOrS/ap1eXxvfM7HjQm3kO
	 CxHPicwrzLn+bAmslJGOtkpCbZY04wvRRIvqnlolHPlDeOaO1z2kqR0ZjdsbTEAMgCEw/
	 0eyuihteF0U66dznkOFLtm9aXHlNt7gQGQVw9RX770pzC+1I4subPPEDz4PWY0pRrhuMM
	 A4HeagpeVAacE+0+dR4e2X8DE4Twi0E0As9Hfk14vscO/gqotz9j5KTOvgjRdLzZ3YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlxGHW+k;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE9606A330
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 20:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0FE9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlxGHW+k
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so216459566b.3
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 12:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035169; x=1795639969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5MhG98OmxdXqTOc5Xluyx99XKwhYZJ2KKliQ9c2OkM=;
        b=jlxGHW+kRyHFaEMpeXR4BNALXPsNplbIhzII6rNliHUbcX6NmABOnQ8XTqgppKQz/0
         jnpx4OD9SPT6Kr4gK+6e7zltezYlXyxXT2NfU5Odo31hxeQDHI1/oRoHWTSOtpxIboeQ
         FH3N84C6KLj2Igb3KbWBC2z49+iRGJvp0vB6BJ0/VWt5XCdgR97RAz5PXJN+PoywAORY
         xte54o9ByrMsQ2uilazjjngyPJdALuFEoOaJiHVqDv/lnXYuJF66BDqjNusCCR1GMXJe
         eOgd9Vlih01Qr/4o+siFo0v2a4oF4APKzmmYHrhLbqFeAgDBI043ZSqUkY6x4nruS+yR
         J75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035169; x=1795639969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5MhG98OmxdXqTOc5Xluyx99XKwhYZJ2KKliQ9c2OkM=;
        b=qiLv7eDKHPGzED6IO2qHtj1Oe5RfIlUsqmFeORJQWXU4SVlUeiyKu0/iMczqjjaULW
         zsaxCp6rW63wGpStg5gEVwpVCw+uvMso1QEWD7h5AVeZ3Z/E0rYuwnuTTbYVIcsxkvxN
         xyHW6O0g7hbUiwfcHbFzT8Cc9hS/ucYx8g1G/dvRpX85AHp0RYBYe4ToVbzyhdPZPaN7
         yY/OVDnpvc4UJKf4aqxeep0tW6JQGvx73h5IKC5ZCh01HY8LJEg9cOM0ixYxCCNX4IeU
         9EHQyKD5CVpAZIUYuVHQngY0WwZKV93bnjy4yOPPK0yBjG+MKl79lA71cSzqqGkwGII8
         k6jw==
X-Gm-Message-State: APuU4Z9CHZSkmdi4DcURt0Lmjs22GnI5m3apt/MaKx8oW2Plt1xaLNEh
	5g2PfU/55KvYyZ7Bs7qIn6BqBHaFEX/rOe4lU+jRdsWu8x4SoT9GlNp2
X-Gm-Gg: AYBFou3v46+EA7g/DPEV/bPNiFXvE3m0foxE4Dv8R9ygLwvmxsLKrp6GRsiudunWRSX
	gp2jZur9P7YP9pjOhohST32/BltuzyuSkcfGednsmhFYVZ3KzRtp3AHu7ipZrNQVB92YTIUwM22
	j1zjYX+M8tTfNUSjTthq9hPagPl5fPdDgD6h3RBlyiJ3MgTXf7yMpBcfrmSe2/MuTRRTTO2nTvv
	wut1sp/adLAspzfBex+jpVTflnL+wqqXrZV44K+lrx5hiDXz3Q6tStiX5d/4YDOfi7Uu9Hay5k2
	cwvFcKMlUdNIdx3Zk3Vv4ZrIoP2DYwAVaieqKyA6JrxEMxkyKQ10Uielh5eLHb1QGAvvR4DSaTH
	EnTC9UbN/+3UPoy9fCt/5T/uhbuyuk0Aa2XR5DMJcqzAdNHYOp2Ns8F4AUa6BgTHndhxrlR4H9D
	XsEddELTm4QFBsd4F3ba0TL2RZ/QzXCApfPuPouraMZCITJAfWEGPvcOYQ69vXSgMiCduh0cpLr
	TpGtEAntu1nnU54owR36id9Neks71GQVidLGWrhn+D5nv4mR9/8zYSx6XNgt3MLA9602AWjOzCz
	MbzF60L2IOT4r5Azq0hsTnJffNZxthbKlVWV12DndJqKr28tx2aNHOvUbiDvm9x2g1UPDhT5e38
	ePoIZcYk=
X-Received: by 2002:a17:907:1ca6:b0:c50:ac4e:3770 with SMTP id a640c23a62f3a-c510e516a2dmr391250066b.34.1795035168876;
        Wed, 18 Nov 2026 12:52:48 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:52:48 -0800 (PST)
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
Subject: [PATCH v2 0/4] i2c: omap: add support for DMA
Date: Wed, 18 Nov 2026 21:52:03 +0100
Message-ID: <20261118205213.88778-1-apokusinski01@gmail.com>
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
Also, I noticed some unused arguments in the receive/transmit_data()
functions, so I added a small cleanup patch.

Kind regards,
Antoni Pokusinski
---
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

Antoni Pokusinski (4):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: remove unused is_rdr and is_xdr function arguments
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 363 ++++++++++++++++--
 3 files changed, 350 insertions(+), 29 deletions(-)

-- 
2.56.1

