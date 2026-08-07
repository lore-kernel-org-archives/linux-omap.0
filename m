Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446DF42AF95;
	Fri,  7 Aug 2026 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108609; cv=none; b=hWYjO8Sbu2QJ9Smwk5tpwp0YmUErF/XC9OV57x5d/lLFeKbf7hLL/g3aH/QfxPFKk+aXmcid15BVeeMbyfC5uY4yKZm0tuo678cxtzY1EL1QwiCaVW1nMKXO70Q54uchC1ezD7Ly76O4YM7VQePwzfMzxpB2bHJCdHKoNWSYjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108609; c=relaxed/simple;
	bh=275TKm/AQkopBHdkuCASW4g5iuoN/RumyTuzpPTV1hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXVekynKQmGeIby6YeYYeqtJsR2AIyNUP8EfoD2nu46QS2E//1OyiNSjX+Qb5OEronpRyd9rq9NC0kvIaLgeVobcGZEjYT8xMkgZULHB2bndRUnshX80AI9DpsFiT5nsUrA9c7NdtUgQ34o0Xl9QJcHYsVu6kqIAc1UAb8WPmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Whe+yB5E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Whe+yB5E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+UWe1yX17cQB95ay+ZQVnMP9BDbpBIsEUhuX6QM+s5k=; b=Whe+yB5EzI7EwATAG4Fcqi+MVA
	1pbi7YHrp2BcRjzSXdZeMLPCt0+KAnR7GC/mWBOksTVDZmIiDTUhGJXF+vxK6JpmUTeY33Oel/4il
	bXO7Xw2qYhMpUJU2Wtd//FmZJnTBd6PBAk1Bff+M9eJefIJp9rupik76288n4JScNOcY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsKQB-00GZWU-M9; Fri, 07 Aug 2026 15:15:35 +0200
Date: Fri, 7 Aug 2026 15:15:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Ciprian Regus <ciprian.regus@analog.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Mark Einon <mark.einon@gmail.com>,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Michael Chan <michael.chan@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Timur Tabi <timur@kernel.org>, nic_swsd@realtek.com,
	Byungho An <bh74.an@samsung.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Sebastian Reichel <sre@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device
 changes
Message-ID: <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>

On Thu, Aug 06, 2026 at 09:54:19PM -0600, James Hilliard wrote:
> MDIO buses enumerate firmware children only when the bus is registered. A
> later devicetree overlay or status transition is ignored, unlike on I2C and
> SPI buses. Supporting live reconfiguration also means that population and
> removal can race address scanning, PHY attachment and bus teardown.

Please make the bootloader work around the issues, and drop this
patchset.

	Andrew
