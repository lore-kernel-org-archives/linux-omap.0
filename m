Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C6310620
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2026 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363559; cv=none; b=jzm/uxRiXCzHs0oNvhk+cabjRPflkPFMu1HQquk1KKK+rrdHGEEPv8yJp0nPgsCPyhu6WzDh08Mmob/zxQOUZx5ZqYrqaawHRbZTgN12ywBA9qhfMxQfzcPQvcym77UiXOOLXf65NDs9suE5H0KoB5RZGulRrHK4M0YcTHbEf2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363559; c=relaxed/simple;
	bh=N56zY6ERDiOsmUWj1ibbj5vfyDtADAWSqqKHL42yXrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bnJBy+h4RqTPGxNAiVLHD6JCXvElM2sE+pWKYxJCAZp2392HTS8krLo2EaVkcAVQPAdse9mgmIubs97QTuXx+gvp7wlCljBK1Giio8GLFwSDKyXbryFk/cbDPtyEAI1dD6O8Vr00Au5ca49g1SClQfNIVsDSBxDKDZAlP41f8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y6JwNC3i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y6JwNC3i"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab46931cf1so20639295ad.0
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 17:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773363557; x=1773968357; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy9kXTv2NCvP2HAY6FejDEYYtBGZPXJx11C/O+hbqz8=;
        b=Y6JwNC3i4h2a+xUspaGAvbblEkgjWhUi1oTTNnqTLfcOrbWWmbaIxHWZzPxARxGqes
         Iw791pN2q3PlQpJ3X0PmVepuXJhCTsDCl3BEGhlAQAr917C5JZdIyeBNNDz3ljvnVVks
         9dyDaFCgwSI+gWr+9EPD1hcOrxnW0iGz3c0rYl8HWp1qvJYO84BeM34+Cdw51RjeJf27
         SinJrYFDlLbMwkJsb/xt0/4CNuG3HkPP5F3LPv+B4jIZfLz3VIGylr8RCX1b/z1JvCag
         5qYFa9iAvJ0xHxmS9nEg6b83ZgIsTPOtPg39IbG0FfMT3TYbygy6eyMB8PGZ4J6qYQnX
         gtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773363557; x=1773968357;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cy9kXTv2NCvP2HAY6FejDEYYtBGZPXJx11C/O+hbqz8=;
        b=GWhCYENDKOf7qfgycjeDj93VnDxgtGaS7v5o55g49zxdSvq98JGIbQQSQ1WSm6IQI5
         WYp8T9trcSIAE8L5hsuZpBnOpcxpHMPQcxBx5B7INzlc48Y1/8U9d5l8eO+pZrUdYnpD
         9DSue7uhe2slRf2t4q9HiiwWV44Ymt9CkB0hpsQ4N+IZkvJJxtF9MQ7Jt+drf4Goqeet
         wzXm096t+MKiGqZYJBzsc0ZE9yL64EM0BtJ8z7L9YQunorssabf+xVWQnYjTE1uHINlF
         gWFfYdd32euairE6dMWfqy91n5HM3lfh51MvkFnl2zDv38A1sbO6XJeRXUy4N7J/+F05
         /i6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXugllvTkbcsRsaHvv3f1pHNpJhnUjdkpulfe5Lj9a1N3ape/3ZIhtu6PIp0voi2qa8bv0QkkdpfVsN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SEj2negdMe3zGEg3hRASiUW8e6YqU13AjvgdUKyBkIQRtGJh
	u1WjaEHMRMnhOj1SSxkon8eiRzuIhifzrL/iAyEQOMwk8v5a/apjeY13hp6l6PX8HjQ=
X-Gm-Gg: ATEYQzyFQ9Rt7Ta3gJ+IVDhq+avvgodto3/EeHDdbP51d7M3d91EaQLrv2UGcHmk6Hf
	JVF1NDyLYw2GCyMNJphWbraVo3s/+4mn89h1/sFf37rDaN3ZrGpthJW88BAqSHLLwKLEYdkVzMF
	6FcTTNA/FlyiKAL/irARQkiIkSTm2Akc07TaMgY/YQXrb+4QIJZlIQIPYZnYgj8KZ+CkkHLiPZD
	bU1slBqWW6MzKlH5TiIO4ro5V0eMDavJcC0YUrAZ5e45V60QTU2ZuSMpX+2gbGxhLxwnhHXpp2J
	muEPKyHRQQSVMcpk9U2Wq15Z51ctC9fTIL9Fon6AqDdfcS+xtA0n5TPGv+o/VH0SAAAZzZUPQIn
	9WlYCkANCc0SruAc6gMbzdBL65YKfH8GnUAjSWujZrW6OGz3kNx6UpsM8xK5RF21OHmamnxcAyc
	Tnj4v6u1zP3z/n7CIw9Do=
X-Received: by 2002:a17:903:120a:b0:2ae:47d7:e101 with SMTP id d9443c01a7336-2aeca4cada8mr12610675ad.1.1773363556830;
        Thu, 12 Mar 2026 17:59:16 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56cb7fsm3034135ad.6.2026.03.12.17.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:59:16 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Parvathi Pudi <parvathi@couthit.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, rogerq@kernel.org, tony@atomide.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 aaro.koskinen@iki.fi, andreas@kemnade.info
Cc: andrew@lunn.ch, linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, danishanwar@ti.com,
 pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, m-malladi@ti.com, krishna@couthit.com, mohan@couthit.com,
 pmohan@couthit.com, basharath@couthit.com, parvathi@couthit.com, Murali
 Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH v5 3/3] arm: dts: ti: Add device tree support for
 PRU-ICSS on AM335x
In-Reply-To: <20260307122641.738450-4-parvathi@couthit.com>
References: <20260307122641.738450-1-parvathi@couthit.com>
 <20260307122641.738450-4-parvathi@couthit.com>
Date: Thu, 12 Mar 2026 17:59:15 -0700
Message-ID: <7ho6ks1r4s.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Parvathi Pudi <parvathi@couthit.com> writes:

> From: Roger Quadros <rogerq@ti.com>
>
> The TI Sitara AM335x ICE-V2 consists of single PRU-ICSS instance,
> This patch adds the new device tree overlay file in-order to enable
> PRU-ICSS instance, along with makefile changes.
>
> PRU-ICSS instance consists of two PRU cores along with various
> peripherals such as the Interrupt Controller (PRU_INTC), the Industrial
> Ethernet Peripheral(IEP), the Real Time Media Independent Interface
> controller (MII_RT), and the Enhanced Capture (eCAP) event module.
>
> am33xx-l4.dtsi - Adds IEP and eCAP peripheral as child nodes
> of the PRUSS subsystem node.
>
> am335x-icev2-prueth.dtso - Adds PRU-ICSS instance node along with PRU
> eth port information and corresponding port configuration. It includes
> interrupt mapping for packet reception, HW timestamp collection, and PRU
> Ethernet ports in MII mode,
>
> GPIO configuration, boot strapping along with delay configuration for
> individual PRU Ethernet port and other required nodes.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>

[...]

> +/*
> + * Disable CPSW switch node and
> + * MDIO configuration to prevent
> + * conflict with PRU-ICSS
> + */
> +&mac_sw {
> +        status = "disable";
> +};
> +
> +&davinci_mdio_sw {
> +        status = "disable";
> +};

I think you need s/disable/disabled/?  (note the trailing 'd').  Without
that, I don't think you're disabling these nodes, so I'm curious how it
is not conflicting with the PRU-ICSS.

Kevin
