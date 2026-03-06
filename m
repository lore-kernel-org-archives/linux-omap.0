Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603143002A9
	for <linux-omap@vger.kernel.org>; Fri,  6 Mar 2026 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759246; cv=none; b=n9pDpiMBx4kYEjMys366nJ9wEOQJjlvEJPzY4V63ofKyvlmr06NyyayXPjjbGAyW0BsGoxRV7C9P97VWVvltjQirlAV5wbkl6guZCzry/tZxDwElIxXVj/tiKrJkkyHBltM0fAq0hn+g+rlDvE9hJrZCJ0MNkLN4EGJ7OpAptzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759246; c=relaxed/simple;
	bh=AwYvrtyXn5t42Evv8Q1//vnY4MBFvm88APyJ6xccnHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uPx7ZjeZGymgBCpWR9m1A0nncHcBhA3kZaxQ6DcaKsoiFLDOO5yFdvUQYtALutrzZhKuXXePtspVBauGx7b5AhTGwpNwpohSlLVzogkeFIQPH2md5H6ALis/qg1tVkw7QKuTWq7mK9hWwj/Gwf8wdyG83W8PfDAi9++4ie4JgQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jL55B+fZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jL55B+fZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab232cc803so40880565ad.3
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772759245; x=1773364045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt65nlyH2+056MIjJR2mDSU6Xjc3S4OPgUVzwFjh2sg=;
        b=jL55B+fZc2lG37UlJqcJtZufUmygMSpRm2szwruI8WrIayPHEC6NZLqtNnKk8/0XYO
         ib21yl0RgijVRF2QnFQlyakj2JQ7lyIIA9Wz3bQFIivCYx65W5NI4XBx4ChmQIZeGtkM
         5nEtFjf4w2x6FMIVEkf+SuqDCOihht+8Lm2h+rKDVj+7TO5X6WJV0iRYuUniAAxiTH8E
         PVD8uumZAx/0Bio7hf6AzA5FXAwrhOJbiwEy02YfhS7b6YcFv5m2Ag/CPzOpyC8HWKyL
         AJCGOlBhqEGNFnsCAtEGiMn+vPFSGmE5+kF3OOKtRDSodeTUIN7PFSLyYPztz2C04R7B
         M/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759245; x=1773364045;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tt65nlyH2+056MIjJR2mDSU6Xjc3S4OPgUVzwFjh2sg=;
        b=oJyisy1rY0uk46O2WjjGgOB4gMhLHewRzBu0l3jNapY9Bnkpm3EU85vM1HTmCeR2m9
         l8Uev4qT1ARwbCgUnxDkZrmq6VDLarDkYdzhP2KLRSqQb85LKXM/hlFtAx7yIPRuvqgB
         lPL/1+sBqg8AqUO78RRhWHHZf/0PxGryl57bAK1ssS05fyPFzgnU0+BMoHXh1QzjREdx
         YqBHTZ9sAABKm2NT+KyN3l4SvLrSlLqvRcCZ43NTQgIMM6fZtOp8LfXKZdL4WLEk8t4k
         d48H6+5ZD6BMad2rq4e74i9dokTz/VntkWnWw1Wj8boDHiM1OskaYGS0/OCOsuE9Noby
         N+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXeLQEfCUYuXCPWvBaC0TFjaulgemhJaPLPiymtqH6IiefiN8Kxm7ikFNe1jKEg850u7YmfX0ev3An0@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvWrnPZsHWTgdZQOYfKn5X2Vzr7IOQYQxVZTWxsyn8zsq8nLT
	ifWAu24zilPseWEDRUxx0QnLskgELsXTPYn6VaXMKQjdiGWhOh+u8LNiu6Gs+gBwOKQ=
X-Gm-Gg: ATEYQzzZuVwPPNrx62CbeL+g7ZSKVJ2eTBNxe5M7+qQaBl10Xm6EmMTOBQcQ5m8Go2H
	HpPkn1J8ypP6P0UQmBlAOdw6kn4ZyXw4KN6LPDSPoDz9jR02UDWlzOSFrqp/ZvAiJWcTYUaVk3H
	LeA0BTULYdK0cQnbSu1Apu09QhlikXjI50HpAUSqp0GyLTVUZ0/3YXJH3bmQ4DOeFduP0l8Y+3w
	eOiZHPJeSEJfAsNxtbNcbgwdnkVb6STV19jfjRc3cNq49p0RfwNpLkn3bKr8LQOYDzbs6Y/xOAf
	K0gLc4PpjswM7OENElK6GdQ8DHCKr1V+LBORutD+Q2XdqGtGlFUOGch53TN6xGZUyABLRBPaWWK
	22CAiSK+XhxNgctyRU0X96trYPV3GF5e93fj86f0jQ7q0NQNzSUR5+In9bexcJhcCpW4dGxzWU7
	CECHRoq56Ake03DPMBIA0S
X-Received: by 2002:a17:902:e80b:b0:2ae:54b2:27d1 with SMTP id d9443c01a7336-2ae82467157mr4766475ad.44.1772759244771;
        Thu, 05 Mar 2026 17:07:24 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45e07626sm172535595ad.39.2026.03.05.17.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:07:24 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
In-Reply-To: <20260216-feature_bbge-v2-1-22805cfdbf62@bootlin.com>
References: <20260216-feature_bbge-v2-1-22805cfdbf62@bootlin.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: Enable overlays for am335x
 BeagleBoard devicetrees
Message-Id: <177275924369.1445909.1029086854461649971.b4-ty@baylibre.com>
Date: Thu, 05 Mar 2026 17:07:23 -0800
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773


On Mon, 16 Feb 2026 17:55:52 +0100, Kory Maincent (TI) wrote:
> Allow overlays to be applied to am335x BeagleBoard boards. This adds
> around ~40% to the total size of the DTB files on average.
> 
> 

Applied, thanks!

[1/3] ARM: dts: ti: Enable overlays for am335x BeagleBoard devicetrees
      commit: 18161bb01ede109fed41c66efa2624a4c27377f7

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

