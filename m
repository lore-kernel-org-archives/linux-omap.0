Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B864CA27C
	for <linux-omap@vger.kernel.org>; Tue,  9 Jun 2026 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043961; cv=none; b=SM9RcLdsFcWlkn1/wOFw6Uu+6x+h1OdI5o0DdRx3Yx7DLXld/qiuUOmrD0aTK0Ht8zDBardAL52lZe+YUdMo8DaG6BqY8JwxyGntx8+CBEq/JZcH01Y+oW42p0+E337vqYNNv5MuWxVFC3aAHU7zRAZbP5gvleZonrxMwV7REUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043961; c=relaxed/simple;
	bh=B4kz5SsRggjEFJjV3J/sE+7/gP1ESaf/r5J4kQ1a0Po=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N8sULs5IbEObobBHW9npriRVcVmDAcr4k+W41l5We0EKJPoiA3v+iVoTBG8Cadv4enAV66JIrGj0mpujGFuXudYebd+A/65zgZ0TSzru9vdoz+zgYRE4+5jE3U7OHzXHFN1HARvNTd91ft1uPvh1TZjiG1EqcBVLUAtKtPBsKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QCQJjyR5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QCQJjyR5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so5667625a91.0
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2026 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781043960; x=1781648760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46q2U4nrUSnKYOo0Qk6SmRB++eNAzeKGUuI3ymafY8U=;
        b=QCQJjyR57x2jUdD3ntf6Gyww23PmARz4+wAcMdlzZE7wY0U7MqkScjLb+CT50OyZh6
         J/daVsPnZPc4yBpihDiUbgT4VGV0h9dxPXWbvpUu/q4qYgmBdvJ1euYLyvNvSbOGRONc
         NPjGHwYjXnDtuu5yVjS/sY21m3uBsnTPnRJuOsQneVVFuatI+lmoqwBhPbOjxxEK26i+
         W4YVcitKlZ3LHPjK6MRkSuj93knXfvNFg4+cImH/6dZ3x/Lgwx6UYIH+KHt1tYJGrJ+6
         +QB+g0IXjgcInp0c8o8Sfa8HSlJCsKibi7ZbFiVKKp+yCmGtIOHT2erGIHX2sRanrN3V
         ftYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043960; x=1781648760;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46q2U4nrUSnKYOo0Qk6SmRB++eNAzeKGUuI3ymafY8U=;
        b=k8qyQqjrqxVpmpflRsYGQWzuvhzRCqrrc/N+4b7f5BE5vFcpNCEQTODyGDnI3h/WFH
         8Cb6kKMId0kYPPHJLnRkkan8w0nELnHIsLpZyC/M4beaCCMtvvYYp37pXcREjl/MzbuF
         Orf9VHGnA4+eaIejw4hjxTDYXYE7cy7G/u+jAB6zWDYHc+GVfj2wSqF5jQG9mKFRnB2t
         wIOeUcz49xx0Ps9Cf53CewN3k1apcQ5a5E30B+UJ22owVEBDRUNlQwlhEeZGOj9gxh4x
         mljmRL8bpKf4KqM9DX/pGkR2XlTSX+SzUwMcmuvxaPFadK7NWz8o0jExrD5UTiHPL8uh
         CXsw==
X-Gm-Message-State: AOJu0YxIxEv3iH2U29FFH5LhZF4Flsqt92/LlYeFaqGQIkxO/fTYEuw4
	mw93n6duNY9NURvuBj1YJb+bGKif9B3sdA7yHPrG7BZDyhtd2+FFP5tsGGBT/kkx2XI=
X-Gm-Gg: Acq92OG037/rQ+yTct0v5mfFrST/+dSq9Hf+iXUTKFh+Q/atV9kKdE/oNvK/fCe9mTs
	ZxSzHCm0X0R9v+Hja7fRtIZsoGTJNiCO6VotvjkTlQ2IsRUBr8IhHDvGyIO9yz7iCinhGyKLWz4
	ExOaA/M9smUn8hr6ViyDqFkp7A3RSA6E4yAUTS1bjeSqKGIoCCbrtlbDi0f4lFUr0EnvPKyyV8M
	e9vl825LUYhxebTr6IWiXSHmOfTqxboe8zsgq04MXExZ3JggwoAQsS4kF+5EbHyTG/+Tw9nxXBR
	viwpQz63ufCyRhEY0R2njRHXe4v+fYBUk9RchI6txGp2RrNOGE0tWoVmDuYwCbGQrBHEcJtovOm
	9/41DYUF9UA7zJ31TlpKaXcVfB2ACxgiG7u45Kg94DerxAbPT6QjEAX467UYMekxMFGEq4IuCRU
	P0S9yKKwlPP+PxcfnQFs4nWPCQrAogJmM=
X-Received: by 2002:a05:6a21:390:b0:39f:a42:9247 with SMTP id adf61e73a8af0-3b4cd0670f4mr27316925637.37.1781043959893;
        Tue, 09 Jun 2026 15:25:59 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c85df0bd337sm19404461a12.29.2026.06.09.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:25:59 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: nm@ti.com, vigneshr@ti.com, afd@ti.com, rogerq@kernel.org, 
 tony@atomide.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 richardcochran@gmail.com, aaro.koskinen@iki.fi, andreas@kemnade.info, 
 Parvathi Pudi <parvathi@couthit.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
 danishanwar@ti.com, pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com, 
 srk@ti.com, rogerq@ti.com, krishna@couthit.com, mohan@couthit.com, 
 pmohan@couthit.com, basharath@couthit.com
In-Reply-To: <20260428072046.3022679-1-parvathi@couthit.com>
References: <20260428072046.3022679-1-parvathi@couthit.com>
Subject: Re: [PATCH v7 0/3] Add support for ICSSM Ethernet on AM57x,
 AM437x, and AM335x
Message-Id: <178104395875.234140.5899663583168202275.b4-ty@b4>
Date: Tue, 09 Jun 2026 15:25:58 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 28 Apr 2026 12:47:26 +0530, Parvathi Pudi wrote:
> This series adds support for ICSSM Ethernet on Texas Instruments AM57x,
> AM437x and AM335x platforms.
> 
> The AM57x and AM437x IDKs support two PRU-ICSS instances, each consisting
> of two PRU cores, with each PRU-ICSS instance capable of handling two
> Ethernet ports. For the AM57x platforms, the PRU-ICSS2 node has been added
> to the am57xx-idk-common.dtsi, while for the AM437x platform, the PRU-ICSS1
> node has been added to the am437x-idk-evm.dts.
> 
> [...]

Applied, thanks!

[1/3] arm: dts: ti: Add device tree support for PRU-ICSS on AM57xx
      commit: 9c4fc66a770a018062e371d1c8a77184d4c15dad
[2/3] arm: dts: ti: Add device tree support for PRU-ICSS on AM437x
      commit: cd080146369be3a1750774eabbb839c45cc9a750
[3/3] arm: dts: ti: Add device tree support for PRU-ICSS on AM335x
      commit: 19ab47bb6b96820c28024ebfe674050fa2c54ad5

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

