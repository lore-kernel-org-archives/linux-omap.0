Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7713D34AA
	for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684816; cv=none; b=cchAtQA8m8ow45bQw2S3xf3nv52+PV83Iwtqx6NwHEbLnlbJ+JIWTOJqbbCWo3x7Kw3EGIp6+uu+STkprBbF+horgVUkqhFfCFXvFRb699zNv/QJbJlGJagGDeghW57JWc92xcfz2GODn4kfsyHGCiPujDXryEfs/7Mjkkcxqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684816; c=relaxed/simple;
	bh=xJhMoZNqr+EHjdBUv6t14tIBHJ2MlKnKgZGrDXGR260=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7Wa/AX9gb3Z4bG1FWvgkSOvD1BxcODPdnaZtjnUiOWhh/WIxnX+1+3wNHvm0qWCbSTNuWr8R7oIO1DwU0YNLRAUThRjNra7xnC0q+vFZqQKKjEMj9adE5OQdlAD592rzIkXzEAD9pPtfvySvR1//EDV5NdSe6rQmB6cFMWldYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a5rz4F7/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a5rz4F7/"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c739e680bebso1591529a12.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773684814; x=1774289614; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6I630kcGdJmHLQvgv2ucM+rk0u+MBt6XpMILrvY8Gco=;
        b=a5rz4F7/PIq5VoPeuJr7+Y2B1gH2TPWLfJJYg2OnJMJUiRdcIuf4QvJSK6AnFFYIyA
         kDlAQke4I7guGFiBOIBg2AtC0aFC41RPGIeqiaikJAowEAcmII0mcc80kUAy3q1+ONh2
         G7a9tEcDZjdM4Fllm88bAx31ihMqsRr+sErfpHhfltzj7sfeeHTJLHvckufLbmxwLguz
         kHUILezoTbEFcVO31e+ZHgN1aQxeIP7pr1p7xwyBvOR0kAPrz6c8UlZb4sNw77FcUy04
         CY4X6qDSPN+ro6Fo0oHiQulDhZ/b+mB0QjWIpPxrTDkTLA3iTJS/wQ4oaevjugviTfxq
         vKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684814; x=1774289614;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I630kcGdJmHLQvgv2ucM+rk0u+MBt6XpMILrvY8Gco=;
        b=YRyFAnUsgecGjpdJ234fh6I9pEE2zvJOahdYBA6TvH6ueysCMJKwoW8dfG9qLxcUKs
         5g6ExUrRRO4N9xHcMzlfNcXFLVyH+Ewx6RO0K/Q3IIJKMv49bnszzdotp8gCpMv98L4M
         QYgZppCivVxtc22PL4LYYmUkO6B38hwUutJFxokH6nMLpzAepay6yQUeCgEiW6o/eKch
         bCXiwJ0JIj8pndwuMJ8sXbFZjIpfZvK/RDleWrSuJ0D6emiJAtTiyPcFU0p4aw/A6dXc
         e6A6KTO3FF1DiDLERL4hbxwwT2sQyQKjg9QiTYl8RyB68OtHmlur0H95/hpEyiTo3Ldh
         V+8w==
X-Forwarded-Encrypted: i=1; AJvYcCXJKCUuA8DKpy43DVUUCWIf3tW6aOIt63bBIKI6KVzRBcprpqeMhB2Hq1W7ZlBRrZFWJAOTv9JQDkUd@vger.kernel.org
X-Gm-Message-State: AOJu0YxesdpNdBCfm/0JvO10octDpq/xIlZzM4MSDIW+4SRyZXKQOz3e
	x4EP4FZc3gYSGhCKLsovZdWcrgs4YNppM6a5ePl6Sr6ztl7BRaQOEPoLBZTA+aGE9xo=
X-Gm-Gg: ATEYQzyrvMuoGadCxbW2sEy2pEI+acr5Z3PVGPElsVSiVPBMKfK9KhDOZrpx/rkJ8xJ
	lfCU7voPcA/xaPF18yWrm48cEJF+o1plalETc3Dl9DvRgk6ULkhzAoXJfhvabWRSE9nNaX2Bh4k
	i0w9H80eFWBhzV5m5X9k4Hsc3RBjUTDpEb0U1gjUqT3bNkAGXF2CV9I10aOrPShxSmrUdzH18yx
	yIeOc1U2IeRk3t4ArTszNIAt88aacQKzStgcZd7MHekLitv3JFH3WceDOe7LILmPsmKzvYjbPnr
	rhUFrgrK4oq6jPH5wXAHdDAbWiF6GFziP2/W3TX3ZyPbd45M7plUDmqXxJXyeMljU2tnbwYvKNR
	F+793PgNO//1pBNevfMTREiFmYhwFtLyfGK1Mk0PR5dnumvZ/5iPB3WE8Ri1cZtUiTFR6hMhDVt
	wPN0lbtgsF6fW0JjXqW/E=
X-Received: by 2002:a17:903:22cb:b0:2ae:5a70:477e with SMTP id d9443c01a7336-2b06365b4dbmr4321155ad.12.1773684814193;
        Mon, 16 Mar 2026 11:13:34 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee3basm151378665ad.43.2026.03.16.11.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:13:33 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, nm <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, afd <afd@ti.com>, rogerq
 <rogerq@kernel.org>, tony <tony@atomide.com>, robh <robh@kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 richardcochran <richardcochran@gmail.com>, aaro koskinen
 <aaro.koskinen@iki.fi>, andreas <andreas@kemnade.info>, Andrew Lunn
 <andrew@lunn.ch>, linux-omap <linux-omap@vger.kernel.org>, devicetree
 <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, danishanwar <danishanwar@ti.com>,
 pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, praneeth
 <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>, m-malladi
 <m-malladi@ti.com>, krishna <krishna@couthit.com>, mohan
 <mohan@couthit.com>, pmohan <pmohan@couthit.com>, basharath
 <basharath@couthit.com>, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH v5 3/3] arm: dts: ti: Add device tree support for
 PRU-ICSS on AM335x
In-Reply-To: <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local>
References: <20260307122641.738450-1-parvathi@couthit.com>
 <20260307122641.738450-4-parvathi@couthit.com>
 <7ho6ks1r4s.fsf@baylibre.com>
 <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local>
Date: Mon, 16 Mar 2026 11:13:33 -0700
Message-ID: <7hcy131w36.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Parvathi Pudi <parvathi@couthit.com> writes:

> Hi,
>
>> Parvathi Pudi <parvathi@couthit.com> writes:
>> 
>>> From: Roger Quadros <rogerq@ti.com>
>>>
>>> The TI Sitara AM335x ICE-V2 consists of single PRU-ICSS instance,
>>> This patch adds the new device tree overlay file in-order to enable
>>> PRU-ICSS instance, along with makefile changes.
>>>
>>> PRU-ICSS instance consists of two PRU cores along with various
>>> peripherals such as the Interrupt Controller (PRU_INTC), the Industrial
>>> Ethernet Peripheral(IEP), the Real Time Media Independent Interface
>>> controller (MII_RT), and the Enhanced Capture (eCAP) event module.
>>>
>>> am33xx-l4.dtsi - Adds IEP and eCAP peripheral as child nodes
>>> of the PRUSS subsystem node.
>>>
>>> am335x-icev2-prueth.dtso - Adds PRU-ICSS instance node along with PRU
>>> eth port information and corresponding port configuration. It includes
>>> interrupt mapping for packet reception, HW timestamp collection, and PRU
>>> Ethernet ports in MII mode,
>>>
>>> GPIO configuration, boot strapping along with delay configuration for
>>> individual PRU Ethernet port and other required nodes.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> 
>> [...]
>> 
>>> +/*
>>> + * Disable CPSW switch node and
>>> + * MDIO configuration to prevent
>>> + * conflict with PRU-ICSS
>>> + */
>>> +&mac_sw {
>>> +        status = "disable";
>>> +};
>>> +
>>> +&davinci_mdio_sw {
>>> +        status = "disable";
>>> +};
>> 
>> I think you need s/disable/disabled/?  (note the trailing 'd').  Without
>> that, I don't think you're disabling these nodes, so I'm curious how it
>> is not conflicting with the PRU-ICSS.
>> 
>> Kevin
>
> Thank you for pointing out this typo.
>
> We checked the kernel code as to why this did not create any issue in our
> testing.  We found that the device availability check goes through
> of_device_is_available(), which only treats "ok" or "okay" as enabled.
> Anything else is effectively treated as not enabled.
>
> So even though "disable" isn't the usual DT value, it still prevents the
> node from being probed since it doesn't match "ok"/"okay".

Yes, but since your node is in an overlay, if a previous .dts[i] had set
this to "ok", then your overlay would not disable it, which would not be
expected behavior.

> We will update the value to "disabled" in the next version, since that is
> the standard.

Thanks.

Kevin
