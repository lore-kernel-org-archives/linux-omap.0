Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7343B4E8B;
	Mon, 30 Mar 2026 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873395; cv=none; b=mlnbOOP/T8cxVqJMt17wapq7uaFdyMNxBiY8HSmTl/v0pzzwBps/X4p+H8H1KZ+x4M5wGtsjptRxgYgb+IhaQZj2+kg/FikA4c/PoeviTCOx7xfH7c1k+5efzoe9xzRAFnBCi0o07UHxtaGF5inlIpsZrUR4Yncj7R4zskE7z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873395; c=relaxed/simple;
	bh=FsvuZh6AdTR/1QOkqYfLXEn+LEcBDFMJTS700Rj4mxc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QkwLGP7lSaMeqBXkIWW2vnxuKuO5VZhz7oZEq5bjjMMWC0H/Etj43mtD64QKnQoDJBq8Y/w6p1e2r5N8xUia1r9C+ypILNPRdoMrXzv7G2j70b86p81GEcPmRXXdqPMlr3VMyeaqgjwyW96lpwgz1jOx3w7TMok2M1Hl4rqQTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=xzEvR8ZH; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="xzEvR8ZH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wqOHbYxZOhKblA4rwLkEKOT4hJPxT7ENuF/pYv/tQxg=; b=xzEvR8ZHDo4I62B4dPIGN+0R3O
	5QkEzWyY2CAiRv+A+QGcAI+eWBtBpZvb/1yI9cuCbe7qO5sOLlF616Fuu7YZ5fY+a1Ob2ivJ/EKDW
	4dr0PONKQPEqiBx6KkNngxOSWbtmEJ2g0dF4F2tZrpPl5reUgff2+pmCrjD4SwRv+i+lw5ZxYiurR
	cdTYStoFU/YtAMF8l5wJfgwLde4TQHEGdC4e1I5fdG5sQ0c2MOu5xcbHwaCF6Ye8V55Op4aIivYR4
	0gKrvMTWbamrfZxaViQFbCOuYD+/KkTmBkqaBb4dw0H1n+umP/mCOm0+FVKsCu+bMacfQebnYRxcV
	tuBypLMQ==;
Received: from [115.246.246.98] (port=33079 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1w7Be4-00000005tTc-05MZ;
	Mon, 30 Mar 2026 08:23:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 2AB1E1B22FE5;
	Mon, 30 Mar 2026 17:52:58 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZZfqEwv8_Cm0; Mon, 30 Mar 2026 17:52:57 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 9538D1B23224;
	Mon, 30 Mar 2026 17:52:57 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id U0buoev9nmnn; Mon, 30 Mar 2026 17:52:57 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 6D0871B22FE5;
	Mon, 30 Mar 2026 17:52:57 +0530 (IST)
Date: Mon, 30 Mar 2026 17:52:57 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parvathi Pudi <parvathi@couthit.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, nm <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, afd <afd@ti.com>, 
	rogerq <rogerq@kernel.org>, tony <tony@atomide.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	aaro koskinen <aaro.koskinen@iki.fi>, andreas <andreas@kemnade.info>, 
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
Message-ID: <2119014162.782613.1774873377419.JavaMail.zimbra@couthit.local>
In-Reply-To: <6c523569-928b-4df5-89f3-9a460d5f6020@lunn.ch>
References: <20260307122641.738450-1-parvathi@couthit.com> <20260307122641.738450-4-parvathi@couthit.com> <7ho6ks1r4s.fsf@baylibre.com> <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local> <ee2ec279-ee5d-4d6d-b6ff-35187e3f03e6@kernel.org> <1868242922.724201.1774332140293.JavaMail.zimbra@couthit.local> <6c523569-928b-4df5-89f3-9a460d5f6020@lunn.ch>
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
Thread-Index: Yeg9Le+d6/LdmTazsRbjkV66zNcCzA==
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

>> We have verified that dtbs_check does report this issue, and we will update
>> our test setup to retain full dtbs_check output to avoid missing such warnings
>> in the future.
> 
> I would expect the exit value is set to something other than 0 when it
> finds an error. Why not just fail the test based on that?
> 

Earlier, we were using the command "grep -v '^\s\s*'" to capture the logs.
We noticed that this command skips capturing output lines that starts with an
indent. To prevent this, we have temporarily modified the grep command to capture
the full output. The downside is that this results in a bigger log file. 

We will review and try to come up with a better way to handle this issue.

Thanks and Regards,
Parvathi
