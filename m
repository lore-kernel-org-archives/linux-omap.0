Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6923EA84;
	Tue, 24 Mar 2026 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333041; cv=none; b=aFiQ1w0u3g41E0EXu0fPRdStNYRG7cK3NjqbW+2KT6Xa7EAm+YVod/1qb9frfE7xZSSD/KOoWIQ01wjj4P6mzz+5NBEeLxJ0HhVmI7JpbdR83Tdz7AZ3IU1yuoFutNJpDZMCuDVb5+KUJa/sZgBGaoZB7rZFvNCxskjpq+2UdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333041; c=relaxed/simple;
	bh=fkHDElAmhCE4ojupdnU3cYDhBoqE99JXsU0jtOaO4v4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Q97hGfeiexUsBSO48LQYInwsHs4IPSczzIdX2mFzxPWEyfcgmBprS3I0nFDL9sXMzBMEPtJf1cHkPfRWaBIujCbiEvC6upOf7sGjTo+A76M56Y2mSaT+uR307P5QyR3+Kh53jp9MT6Ir7RMrPDzevBzEBWPHHLD8BDsbJMzxYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=bbWzOW8f; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="bbWzOW8f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bgjC2f3Z8bWKh44Bxq0DLNe6UoZ6k/6sVOmxVskh0Ug=; b=bbWzOW8fqqsncxs3ZFjvWvk2Mr
	ynElpPICQzJTvfKupOWYdj531v1N2Bdm0EuG8/O4fZmAOYsYUuqzsF4L9WcMbW+m5Q6k7BhU7aw44
	t6XO9nKCTQeWmnHO55AX3Pd+Ek9i2UecnpccRR7V/Vhh9ey7WWtctIvG/0A37xr39NB0CmZU3mnLK
	T56ZAi06dXRSTEygt6qCyQq9GAAar9Oqe0Bon6HppTirZo/SRKr6a0B4+E5MZGd1PxAFhrySwU6M/
	HiIebszYKcb4KXg2XJ8kjght2Lv6+xBBflarNEUCmyff0tNInsQzcX1+Mb4WiybPvzVV2pSlgLJTL
	NWWU9Sww==;
Received: from [115.246.246.98] (port=54461 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1w4un2-0000000GuuQ-2q9K;
	Tue, 24 Mar 2026 01:58:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 8F4981B8098F;
	Tue, 24 Mar 2026 11:28:50 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id iAaFhnawhd6z; Tue, 24 Mar 2026 11:28:50 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 4D30C1B809BF;
	Tue, 24 Mar 2026 11:28:50 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id l5bd7S_18K2S; Tue, 24 Mar 2026 11:28:50 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 264761B8098F;
	Tue, 24 Mar 2026 11:28:50 +0530 (IST)
Date: Tue, 24 Mar 2026 11:28:50 +0530 (IST)
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
Message-ID: <200940616.724084.1774331930110.JavaMail.zimbra@couthit.local>
In-Reply-To: <7hcy131w36.fsf@baylibre.com>
References: <20260307122641.738450-1-parvathi@couthit.com> <20260307122641.738450-4-parvathi@couthit.com> <7ho6ks1r4s.fsf@baylibre.com> <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local> <7hcy131w36.fsf@baylibre.com>
Subject: Re: [PATCH v5 3/3] arm: dts: ti: Add device tree support for
 PRU-ICSS on AM335x
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: Add device tree support for PRU-ICSS on AM335x
Thread-Index: S8Ccte6ObCw3Alp4fCQkM+hcJaygoQ==
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
>=20
>> Hi,
>>
>>> Parvathi Pudi <parvathi@couthit.com> writes:
>>>=20
>>>> From: Roger Quadros <rogerq@ti.com>
>>>>
>>>> The TI Sitara AM335x ICE-V2 consists of single PRU-ICSS instance,
>>>> This patch adds the new device tree overlay file in-order to enable
>>>> PRU-ICSS instance, along with makefile changes.
>>>>
>>>> PRU-ICSS instance consists of two PRU cores along with various
>>>> peripherals such as the Interrupt Controller (PRU_INTC), the Industria=
l
>>>> Ethernet Peripheral(IEP), the Real Time Media Independent Interface
>>>> controller (MII_RT), and the Enhanced Capture (eCAP) event module.
>>>>
>>>> am33xx-l4.dtsi - Adds IEP and eCAP peripheral as child nodes
>>>> of the PRUSS subsystem node.
>>>>
>>>> am335x-icev2-prueth.dtso - Adds PRU-ICSS instance node along with PRU
>>>> eth port information and corresponding port configuration. It includes
>>>> interrupt mapping for packet reception, HW timestamp collection, and P=
RU
>>>> Ethernet ports in MII mode,
>>>>
>>>> GPIO configuration, boot strapping along with delay configuration for
>>>> individual PRU Ethernet port and other required nodes.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>>>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>>>=20
>>> [...]
>>>=20
>>>> +/*
>>>> + * Disable CPSW switch node and
>>>> + * MDIO configuration to prevent
>>>> + * conflict with PRU-ICSS
>>>> + */
>>>> +&mac_sw {
>>>> +        status =3D "disable";
>>>> +};
>>>> +
>>>> +&davinci_mdio_sw {
>>>> +        status =3D "disable";
>>>> +};
>>>=20
>>> I think you need s/disable/disabled/?  (note the trailing 'd').  Withou=
t
>>> that, I don't think you're disabling these nodes, so I'm curious how it
>>> is not conflicting with the PRU-ICSS.
>>>=20
>>> Kevin
>>
>> Thank you for pointing out this typo.
>>
>> We checked the kernel code as to why this did not create any issue in ou=
r
>> testing.  We found that the device availability check goes through
>> of_device_is_available(), which only treats "ok" or "okay" as enabled.
>> Anything else is effectively treated as not enabled.
>>
>> So even though "disable" isn't the usual DT value, it still prevents the
>> node from being probed since it doesn't match "ok"/"okay".
>=20
> Yes, but since your node is in an overlay, if a previous .dts[i] had set
> this to "ok", then your overlay would not disable it, which would not be
> expected behavior.
>=20
>> We will update the value to "disabled" in the next version, since that i=
s
>> the standard.

Sorry for the delayed response.

In our setup, there is no previous .dts where we set this to "ok". We are w=
orking
with a combined DTB (base + overlay applied). When we de-compile the final =
DTB
back to DTS, we do see that the status property is set to "disable" for the=
 node.
At runtime, the kernel=E2=80=99s of_device_is_available() only treats "ok"/=
"okay" as enabled,
so "disable" results in the node not being probed, which is why we did not =
observe
any functional issue during testing.=20

Are you referring to anything beyond the final merged DT result?

Thanks and Regards,
Parvathi.
