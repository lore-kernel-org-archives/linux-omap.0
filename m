Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8D1D6DA9;
	Fri,  7 Aug 2026 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130217; cv=none; b=ewtLCa/QlaW9PKgi+xGwGACYH9EUOhUBxtJA1v7U5qxFuPpRZp8/9uEMbM5novI+/KFXkajw3mVTYu+Ba2TCQPyfjKllx3hToMUjrz5xQOWZWU1qtZ1yu5oMxsZDUtWN/K4A/RUfkuF6eQEoz55bVs2knMmkQS6ku6gETr1jR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130217; c=relaxed/simple;
	bh=7Zh3BEABkFIdEcXRxO12XmgTpQfa58TTt2MYaGG9yBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8NcgGnEhfdLQuD2cU4qL1SpPGlOkSfMoj/4VpKDJDK3fDHRE5zRw22DqXmeUZa/vYc9VHNHfY1vdtUjU6aeCJz37GK/RQl1j9rtP5oIHY+E02MMRZbYSGckcS+DxSS8N0Z0SsLbhR5wjkopAtqNlQox2QjOIYd9mVKlVOuU/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jdZ55W7Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jdZ55W7Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=NZTPP46mEG0ybtXZ7y56NJi9fDk2qf7dIZJTJzYdJCA=; b=jd
	Z55W7QXZ7pSD2rEhznONNqrOrdtGj8TNOX3LlaKoujtnJYgiQpriWY3O4STdeDbrpZXst2mWGiQSN
	LpoMKRE0XNG/6U6IpU0n1IQbufczmPjF/F0ITvK6Ilp14Ic7Pi27jRDvW6VBNaGX+FTrhjVAjuz2t
	1LpVUFhg5Co2SOU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsQ38-00GdFs-9p; Fri, 07 Aug 2026 21:16:10 +0200
Date: Fri, 7 Aug 2026 21:16:10 +0200
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
Message-ID: <3cd188e7-7dc4-4d67-82de-e2ef3edee232@lunn.ch>
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
 <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch>
 <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
 <4aeebecb-81fe-4f09-9dfe-a3be2f778bb8@lunn.ch>
 <CADvTj4qrYYA-e+9iJ+q4UaZteUjpypRa6HBSmwp-ajwPbwYERg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4qrYYA-e+9iJ+q4UaZteUjpypRa6HBSmwp-ajwPbwYERg@mail.gmail.com>

On Fri, Aug 07, 2026 at 12:48:43PM -0600, James Hilliard wrote:
> On Fri, Aug 7, 2026 at 11:15 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > I guess it can also be used like this for live dt modification:
> >
> > A guess is not good enough. Give us a concrete, in kernel use cases.
> 
> I searched the current tree for callers of the OF changeset and
> overlay APIs and for OF reconfiguration notifiers. I did not find a
> current in-tree path which adds or removes a child below an already
> registered MDIO bus.

So lets wait for a real user to come along.

	Andrew
