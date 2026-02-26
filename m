Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F9393DDE;
	Thu, 26 Feb 2026 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094552; cv=none; b=qNXveyntVbXK96S0Z/INv/XukKYXAC4yTjMVtLviJCOmc5srV6TJEP/JdeckmKuK04riKLVYB2hD1HW9qbqx20t1wGXRD3YAqNdi+h1KiDYp8JtXkWHTZhwVg0zVUu2CjyeAXfK/I205tAuCy8uOWmQ6kqit9doAhJx/zuu5tjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094552; c=relaxed/simple;
	bh=uq0Fvn0gt+zivwrRJU8ydweAWsX+EfqCoqbAPIyBb5Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KwGOs95kf+YCDdCmXTjfJzj6vrq0rz+q6AaNgxnL3JE527RY5G2VqGywVNBb0Gr+1q6QlvjDHHcl+IOlUGj9zWot0OGFYKl2VeeJgY5rCLJpi5DZAyFT9b35TBqa4ZEv61kvbptKDALivvGQT63/mmiFUT+3MI9R6ZZrt4arzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=kGYDhB86; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="kGYDhB86"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0KxSh7kE1xxfS6NJZSSWiiAxS5+M/OE0yk9rnVdu/qE=; b=kGYDhB86DcXU4gvoVGY3M6ezaA
	2nQHOBEwvyNErKKCWgCcyvWrVY7rOg9KwibQc8V3Oqynrttm7VZ7VhHG6tboHF6ASM9kZxdr0n20G
	06duKl1oltlhm93b4HTWaf4u5ce8RDVRBYbyqmyCXcQZqORglVVOFi3H+pi2RBYqXwpiDurd2Df7i
	WeTRl5lPS4bj+z32py39l4QWyPO798DB2Nty/9yVAmyNHr9eYdExbb3BouJwcvFN7LsyEYq41vASj
	af0Mru9snnjdT3vBfeDOTWOr2ZiLZ2KGAoNjrMV6YgxYCA9tbQNmIJtCseqrZ6FLf7O5WlL0c45kO
	QC9iFUzw==;
Received: from [122.175.9.182] (port=2058 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vvWjx-00000009GTo-1OXd;
	Thu, 26 Feb 2026 03:28:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id C2C231B4B20E;
	Thu, 26 Feb 2026 13:58:50 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CAXoQSXLACbx; Thu, 26 Feb 2026 13:58:50 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 39DF91B4B201;
	Thu, 26 Feb 2026 13:58:50 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id WTMalfr6gkLY; Thu, 26 Feb 2026 13:58:50 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 0F4211B4B20E;
	Thu, 26 Feb 2026 13:58:50 +0530 (IST)
Date: Thu, 26 Feb 2026 13:58:49 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: nm <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, afd <afd@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, rogerq <rogerq@kernel.org>, 
	tony <tony@atomide.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	aaro koskinen <aaro.koskinen@iki.fi>, andreas <andreas@kemnade.info>, 
	Andrew Lunn <andrew@lunn.ch>, 
	linux-omap <linux-omap@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, danishanwar <danishanwar@ti.com>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	praneeth <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <1885117045.525472.1772094529965.JavaMail.zimbra@couthit.local>
In-Reply-To: <B3077F98-CC5C-4093-8319-CF45EECEAE4D@goldelico.com>
References: <20260105162546.1809714-1-parvathi@couthit.com> <20260105162546.1809714-3-parvathi@couthit.com> <B3077F98-CC5C-4093-8319-CF45EECEAE4D@goldelico.com>
Subject: Re: [PATCH v4 2/2] arm: dts: ti: Adds support for AM335x and AM437x
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: Adds support for AM335x and AM437x
Thread-Index: m3OSGARO0zXzTDEelPMcISDqFz/iTQ==
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

> Hi,
> 
>> Am 05.01.2026 um 17:21 schrieb Parvathi Pudi <parvathi@couthit.com>:
>> 
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> PRU-ICSS instance consists of two PRU cores along with various
>> peripherals such as the Interrupt Controller (PRU_INTC), the Industrial
>> Ethernet Peripheral(IEP), the Real Time Media Independent Interface
>> controller (MII_RT), and the Enhanced Capture (eCAP) event module.
>> 
> 
> I am just wondering about the subject of this patch.
> 
> It reads as if general AM335x and AM437x support is introduced for the first
> time.
> IMHO it should tell which subsystem/improvement is added.
> 

Sure, we will address this in the next version.

Thanks and Regards,
Parvathi
