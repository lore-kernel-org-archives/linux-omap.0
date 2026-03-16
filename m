Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11AB23ABB9;
	Mon, 16 Mar 2026 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663438; cv=none; b=aUJd2Vt5UsM6QWAqU1idBvQBrCqohOmuLGx4GJWNgjUw5SKZIhjjGq5noGxBIyc0ietEmw8WReURxnGbI6elnvYSeGPZ6xjUPyHiAWu13lUR0WzYV0x3Se3HYijUzT9eSfokm0wRjhkHRpI6ezg2AKTAiDq/Ro20OypE2YAf9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663438; c=relaxed/simple;
	bh=V675jUKSH8QglSXawL5tz+HUbIQOaAylD68Q3+NgfGs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WZoVZJfTv+ZKW/NIy5LcbDKGOxwis55pxqSsnVSr96xK9eSCxGnbT40F42gXUYhJlmmtxj1XsSMBxJVWOYUoMvunlRH4wMskNMxQuXiAmDGQmhYRRjskFAM+TPWCbtW5uA1Hut8T+4IxrHnuzxUJEbvQciHwP+u3Du38cmLJPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=nJEjkrTM; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="nJEjkrTM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=//0aebZLoJRPo6o2UvBp6ake9K/kNjwGQS7c0uT+0wM=; b=nJEjkrTMDlVnLh22xJoeXhg3+a
	0JYhj7JKngxOrK3KgNpDhEfQxQO1tBRo55vpHMVAQD+vZwYJsWNGJJzktba9bUm0B04xKwVOX3u6W
	JuEEsPsqFZzaW7XleaAzB9Jtz6CCVuDZuesm18nGiVOWKu0AcUbshq8v+0GeplUGorBCNL2yNUs0N
	Ki+awxLqTZcOrpC0Z2Cwyh1T29QBnjwDrx7IDAWGC5iVgZOS6NIn1ujM2ZOqWAuOPErL4rKtgpWNZ
	lPcfE/lcGpGSBUdJxHfJTfeKIzvf0Hb/tjhgSAPKo4NvkfytHcl6u1cDfG+vGDFrWq4xGkDYs4QmZ
	n1D85yDg==;
Received: from [115.246.246.98] (port=30658 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1w26cM-00000009cmG-44qP;
	Mon, 16 Mar 2026 08:00:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 75E901B6849C;
	Mon, 16 Mar 2026 17:30:11 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id wNNMJAY4HRyR; Mon, 16 Mar 2026 17:30:09 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id A61B11B6849B;
	Mon, 16 Mar 2026 17:30:09 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id p85TJ2TKoeWh; Mon, 16 Mar 2026 17:30:09 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 423001B684A0;
	Mon, 16 Mar 2026 17:30:09 +0530 (IST)
Date: Mon, 16 Mar 2026 17:30:09 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, nm <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, afd <afd@ti.com>, 
	rogerq <rogerq@kernel.org>, tony <tony@atomide.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	aaro koskinen <aaro.koskinen@iki.fi>, andreas <andreas@kemnade.info>, 
	Andrew Lunn <andrew@lunn.ch>, 
	linux-omap <linux-omap@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, danishanwar <danishanwar@ti.com>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	praneeth <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	m-malladi <m-malladi@ti.com>, krishna <krishna@couthit.com>, 
	mohan <mohan@couthit.com>, pmohan <pmohan@couthit.com>, 
	basharath <basharath@couthit.com>, 
	Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local>
In-Reply-To: <7ho6ks1r4s.fsf@baylibre.com>
References: <20260307122641.738450-1-parvathi@couthit.com> <20260307122641.738450-4-parvathi@couthit.com> <7ho6ks1r4s.fsf@baylibre.com>
Subject: Re: [PATCH v5 3/3] arm: dts: ti: Add device tree support for
 PRU-ICSS on AM335x
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: Add device tree support for PRU-ICSS on AM335x
Thread-Index: fNGDHpGUBv5DoqU899rekVrrDtuztA==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> Parvathi Pudi <parvathi@couthit.com> writes:
> 
>> From: Roger Quadros <rogerq@ti.com>
>>
>> The TI Sitara AM335x ICE-V2 consists of single PRU-ICSS instance,
>> This patch adds the new device tree overlay file in-order to enable
>> PRU-ICSS instance, along with makefile changes.
>>
>> PRU-ICSS instance consists of two PRU cores along with various
>> peripherals such as the Interrupt Controller (PRU_INTC), the Industrial
>> Ethernet Peripheral(IEP), the Real Time Media Independent Interface
>> controller (MII_RT), and the Enhanced Capture (eCAP) event module.
>>
>> am33xx-l4.dtsi - Adds IEP and eCAP peripheral as child nodes
>> of the PRUSS subsystem node.
>>
>> am335x-icev2-prueth.dtso - Adds PRU-ICSS instance node along with PRU
>> eth port information and corresponding port configuration. It includes
>> interrupt mapping for packet reception, HW timestamp collection, and PRU
>> Ethernet ports in MII mode,
>>
>> GPIO configuration, boot strapping along with delay configuration for
>> individual PRU Ethernet port and other required nodes.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> 
> [...]
> 
>> +/*
>> + * Disable CPSW switch node and
>> + * MDIO configuration to prevent
>> + * conflict with PRU-ICSS
>> + */
>> +&mac_sw {
>> +        status = "disable";
>> +};
>> +
>> +&davinci_mdio_sw {
>> +        status = "disable";
>> +};
> 
> I think you need s/disable/disabled/?  (note the trailing 'd').  Without
> that, I don't think you're disabling these nodes, so I'm curious how it
> is not conflicting with the PRU-ICSS.
> 
> Kevin

Thank you for pointing out this typo.

We checked the kernel code as to why this did not create any issue in our
testing.  We found that the device availability check goes through
of_device_is_available(), which only treats "ok" or "okay" as enabled.
Anything else is effectively treated as not enabled.

So even though "disable" isn't the usual DT value, it still prevents the
node from being probed since it doesn't match "ok"/"okay".

We will update the value to "disabled" in the next version, since that is
the standard.

Thanks and Regards,
Parvathi.

