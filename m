Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79564511228;
	Tue,  8 Sep 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892823; cv=none; b=I6fiFM9lNYnIYSrUxCszXVKdNFbxQTmMkxxKSRSVGxnARFbgln6zO2tMJz2Eem8UHTs3D7H+9R4W65kV+eKrZFaOpSGXfvPnucwic0Twdb67Tppf1syDG2KgUYrNCDEKe/CBTywf/B7WPDjzsK88D5xoINPWaYzXnM2Ui086/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892823; c=relaxed/simple;
	bh=MIQfWf7S0tnEVtPzmP4KcxUXGdieiiJi2elrbgA6nS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXwUtJEo/5fBJGLbN9QZKXEkzk1fZtztEae5qW4hUXD+57dLWpUhbMxslHOVaOEe4G7drLnNuGHIKgedtJ1bHk9H7AyeWfFoNzeQeaIGZiCJl7NoR/4T3ltf+34yCfTcMKxrQjR0qpfyUWiYUqo0txsYqbi+HAR5DBttb7gMeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BdsgoPPK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdsgoPPK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/r4vdkbDofK8rt9bMGcF41mARvsonWC380bc7dX3e90=; b=BdsgoPPK6G/o29unZIE6pmTD6h
	vl8XlRK2dMl1trQMgcYg+yNlsZ4aoDtauOsRYPZSnopwZpQN/qITcGAP77Jvv0raUCVRYWYks2eg3
	owzKdzsFoWNXJo2BrWhycroWMfC1LhlcqolZFYJVxpj0xyv6IC2dEqUUTh/SaQrQa7pWX+AnCuCPv
	GbDx0UCewJAn1uefSZYbF/uzdW26sy2rnzpO3bHUlat1tCHSrOOeEzaiYt2DkNFD+rGHKN5mo/Fov
	mkFJkesgAshNad7evCYuWwfU+bRMLby3BelwbEGZl+FVpKSZKMU5iI+9oz/Pl8bxUlqXWvhMHxaeu
	5X4Kklyg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40jc-00000009zZM-22bT;
	Tue, 08 Sep 2026 18:39:56 +0000
Message-ID: <0fdd2490-b076-4722-85e0-55c25fc21a6d@infradead.org>
Date: Tue, 8 Sep 2026 11:39:54 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] ARM: deprecated platform removal
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux-OMAP <linux-omap@vger.kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <fd157e63-e581-44b6-9e4a-962002669438@infradead.org>
 <173bb63a-59de-4961-a841-4a2fd0c2bcac@app.fastmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <173bb63a-59de-4961-a841-4a2fd0c2bcac@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/26 11:33 AM, Arnd Bergmann wrote:
> On Tue, Sep 8, 2026, at 18:53, Randy Dunlap wrote:
>>
>> If netwinder is going away, can all of
>> Documentation/arch/arm/nwfpe/ also go away?
>>
>> Or do all of these come later (in phase 2 or 3)?
> 
> nwfpe is used on all OABI platforms, not just netwinder, so
> the patch to remove that comes in the next series after removing
> OABI. See
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=ff375183fe225b79de700f004181405ff6a739cc
> 
> for the draft patch.

Got it. Thanks.

-- 
~Randy

