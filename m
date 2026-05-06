Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6D30595B
	for <linux-omap@vger.kernel.org>; Wed,  6 May 2026 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088245; cv=none; b=dN3FivxUwahw5XI8/SxVSt2q4yhaYVV+a5tclTE2MhOmuo/Nm7PQ2bDoTDQZMdBJdDxfrcVRGh8ognEqS/1GsIWY7CitgNSVCVKkaUMuG5EXl095/MTFxfqwVUE4CmK3tz6YxO9tFfaFyPaAeb1noTT7GAntTrM2n7/FtovSXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088245; c=relaxed/simple;
	bh=pVvPgOiMZldoz4gPD1EEb+lZDazWRbOkpKXqmjJsD5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WnOsycJFSq42myNHdt8KNkbYZU2NtL25X5v/TAHDlMxscIwqcZuZ05GGZjihwzhGEcWmMpl0QXTE0ioaMJJKPqBdeHi9O3nX7W2Ox3GeGq9qkoQkqzZ02rl0qWq7HeM4elO1BptPJKxVJtwpfzJM2Jr5SXOFztTVCN1PMOPCyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=NLYckDXE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="NLYckDXE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36528851d7dso2025855a91.1
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2026 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778088242; x=1778693042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w9iJVVyuUDRZ2l55xQGBHnO/PNzQ3VP3q5G/LnaoPA=;
        b=NLYckDXE0euVEA6R+RicvNAUXTqbTUGPHSCHpQ0yZzHeaGTJK1MWKXNZHkjm9QVdOz
         5j4JTuQWECr3aFcL7uIFw6xbJKV25GVuY3M1i0pTXMHgDEa4acqzdZdTz41uLDAXzqdQ
         E1Jadnhyy1BzBYVrTqfMmKgr5KsbVtVXsgFKVeX5h1Xw/DLXod7QJRnb28yKzH7giqav
         mNV0PUng4hW64DV5xTZRZyEy/RJjS0fRd1CIr2B5RJ886chkWZUrM4fommE5k81gw1Tl
         D7eSg1HizbXGGlE3UbYyKfFjnoYk527KlTvEwNaf7O/iSGFxdZM6MhO6qIMJlbThybfJ
         yxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088242; x=1778693042;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4w9iJVVyuUDRZ2l55xQGBHnO/PNzQ3VP3q5G/LnaoPA=;
        b=R7FVlT/7zDTaWDWJ0npjfQt8rAwzP9nm87602Q7fDYMx9lAn76eEUpgztt6XumiZ5a
         yiqC9qtOvCCRTAp60hZDR/i3oYaPBpwJ8cenyzvLBWyXm9fUvZH7EJuMcEmaY0mkE8BK
         0yDrLsXOpZqGx72wqeKQG1bwL4a4zILYDQfMEDX0TxNN07UwpbRXK59RJApQKxxU7Aa8
         IyYfwiUSJ8QjJaEtdpB/NDJ1Btb5vNQpRzlUsK5vqWRJtJ+SefZdLiIsJtb2Ujpz7d93
         +88rkeY4+gGvDz0RmkqozmRWcbiskQ+zuWbI1H1TnG3f4cXI+B3RDfhoZ7lcHMhOZyFe
         vrxA==
X-Forwarded-Encrypted: i=1; AFNElJ+Zc1QfgAMNvL+DIg5LsYudMRy4M3BZu1nUVWyEXyYi/N8J4gef+aHfwAXsLLtCsWuFR5GlubalPPel@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3LwIVVRUBeIsztepGW8t5gIN5fknJTs/2VDExxD5rtaKh6PX
	vDi0IPquuHjjHV3BgpdHw5RbssNmsLe3FDE5SqWi5BSiuJMZNQv17rCR1XZuNdesNAc=
X-Gm-Gg: AeBDies8iLlf71Cf4N4RQf/omSPeAnBRiFV+Klbh0FKzIcvrRxo6yvzLHODkVYj4xxy
	inxutTT7TfBThz1GY27THBINUDuu8B4s2Q9akAO6q1L3ijhGSB+f3HDIjo81SBTb5gn49Tdcb7P
	G0bEQ3F7FzulED/qy3RNZrNFISy2I0+lcl50QLRNELyE+zYzDHLm7I9NosoJmTYYEcEYWWVFWU0
	6AIb6FohRdsAyHPb9CqGW1YRWB2Z79nw6vxL13UJzEefug02o4jlBkAsEFYEMrCnVN17dNgLCRV
	MiTcHOXZAfgWCeI7OCcdZ5HSnio2KJFDf00G4pUFHpcxHXS1BJ4C8kOmBe0CUawH5PzLWa+OJXf
	ufURINBS6XCmPrFIt03zJlAKexdySrovU1BCtdxOnYv7p3Co3O9WRvB852HxTYMtkzMTBX3kg/l
	5bTSNJ5iV6Tn5rtS+2sLZwiE1s63RAn7gOCjbNDIke
X-Received: by 2002:a17:90b:1c84:b0:35f:b288:8e4c with SMTP id 98e67ed59e1d1-365abe8b23dmr4046962a91.15.1778088242197;
        Wed, 06 May 2026 10:24:02 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-365b4fb5f1esm2984917a91.14.2026.05.06.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:24:01 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, akemnade@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
Subject: Re: (subset) [PATCH 0/2] iio: imu: inv-mpu9150: fix interrupts for
 MPU9150
Message-Id: <177808824115.2120464.8993137097234559712.b4-ty@b4>
Date: Wed, 06 May 2026 10:24:01 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 31 Dec 2025 22:14:15 +0100, akemnade@kernel.org wrote:
> The Epson Moverio BT200 has MPU9150 chips. The devicetree has a simple
> typo regarding the interrupt of that chip. Simply fixing it unweils
> problems in the driver causing IRQ storms by calling
> iio_readdev -T 0 iio:deviceX
> 
> With the fix applied one IRQ comes per sampling when calling
> iio_readdev -T 0 iio:deviceX which looks like sane behaviour.
> Probably applying this series has to be split between different kernel
> releases to avoid having fixed devicetree with broken driver.
> 
> [...]

Applied, thanks!

[2/2] ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in iio device property
      commit: e0abb8a515cdb7613a15ce54910405ce8110e4f5

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

