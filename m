Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3D3D1716;
	Fri,  7 Aug 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122914; cv=none; b=DhT1bQb0zYZZdgdyeADOH62FEby4ZbbZxQ9379cJzxIR+wIl9elqHJUTJA4PkczQsfvlnS+UOPFae1MHpg4m9KGlujM9Sf55Bh/GAK4xUpwzTBJSbSfiitGb0dAWZTGAy5axbtcvs3q+ecLtjU/u778UCQVE7u5IXsKXCk9sKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122914; c=relaxed/simple;
	bh=I19tJ/JSrkDPX0WmA07k7+MSXhe7HUmwiQwQayH6c9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t38Xsc+1k6sEJ+p2/UbukVvfu6hl/K2WGMt9T4npEfD+fUCDCK1M+HKPm1MI3CNLitn0iA0fRPOY8AfFSRkPUqAYxVhjVn3rqXqrlpfxFzrG+2AiHGMiTpyi9kMZcJOuW2gEk15ROeYvMSPoj/icJ2bue7iyWZRqU9MuaGF9+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1h803Cmd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1h803Cmd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h6t3Ha3eE2oPKDIqEZftYYdDouJma79EyKI3RmbNrVY=; b=1h803CmdHMC77vNqU9mqVY67yc
	cWTzcpoLL9QJer1naQgHAhe3nYLgHLDgS+IchXILRy78YFPXaJDWLJ2PkO48aN58Tf5RnkaRBYTWK
	asAMFYjzDOif5RKdzHR8j08q9zKSiMzJ3Zg3yMqwoGlUQnVoM4PmakPXUcgdiDpkyu2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsO9L-00GcXa-HT; Fri, 07 Aug 2026 19:14:27 +0200
Date: Fri, 7 Aug 2026 19:14:27 +0200
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
Message-ID: <4aeebecb-81fe-4f09-9dfe-a3be2f778bb8@lunn.ch>
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
 <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch>
 <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>

> I guess it can also be used like this for live dt modification:

A guess is not good enough. Give us a concrete, in kernel use cases.

> AFAIU the patches other than the last one are still relevant regardless
> since they are fixing a bunch of generic mdio safety issues in code that
> has users since MDIO maps already change at runtime through non-OF
> paths(i.e. SFP insertion/removal).

Fixes are fine, but please word the commit message around real things
that can happen in todays kernel. If it is a race condition, such bug
reports often show the call stack of the two racing threads.

Do you have a board with an SFP cage? Can you test your change.

   Andrew
