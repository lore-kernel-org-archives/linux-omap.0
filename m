Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6824F052D;
	Fri,  4 Sep 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537494; cv=none; b=Lx1skuFPWQWOPbx/aFwTPUvipdUb/8Z3+nVC3JP/wGfxyHFCjDgMuEFhBOzz84748WiHFo32nWuQ0C2lHiOtc+O1/daGgT1XhwEh/xMu3vb4a0qGAPLB9nyQl849IMzdSgdIxBjrsW765sATXvopTSQEp4D5+KivL8LakIx6Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537494; c=relaxed/simple;
	bh=MAMHc3lcCEx7Gz9i6NwKaBAiqbW/7oSEolLbycKUbPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HymG4gMpbjuwtdR5sHZXfp/PRlIuWCP6TuKhoTqEx9PoqwAKmC2TWgAbR3/VqdZToXdPuevvh1FDK4u2e/cSfHe5JCspUC76TV51XVIcoZ47rdxFK1mS6oGnPtkE+TXmen6rWYY2RTx0JT5M3OHuJ5XxcT53yDx4Ha/o/szKoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeoORvmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeoORvmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D661F00A3D;
	Fri,  4 Sep 2026 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537493;
	bh=xFBkR9T0SQCtUDwL8PQObCORwH0zWTKutCjB4dzETP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YeoORvmHxqLmUVtXYpglFo8Xgu1ji5AKGIXIO6Mm8N5xIm4dXmqXD+clgqcWKLeY3
	 TQXS47+v9ZKtzRnB9bwcmz/xuaotwZQZt+msSrow1xFdWHhWuZI7rpSimHlnU7ercc
	 qq8732lFwY9ju3z4VMdciwyPv6/45agXQqEHVc/j1wIeyMWtwmURw6TnxLOh6kUjXE
	 qt2RQj1/NpPKFcBnXJsX+gLYdYGuK6yw7/7pPoiKZQlxG6bMMx5OD2cxw6yQjanA0O
	 l6mxQekLsEfYk02DnMQQtBWF+b1uSpc35BoRUjFKJ/MvNqfSS5szwk94rmCJUfqbjD
	 pTinIofYxQYWg==
Date: Fri, 4 Sep 2026 08:58:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
 <mailhol@kernel.org>, <msp@baylibre.com>, <florian.fainelli@broadcom.com>,
 <jonas.gorski@gmail.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <kurt@linutronix.de>, <hauke@hauke-m.de>, <chester.a.unal@arinc9.com>,
 <daniel@makrotopia.org>, <matthias.bgg@gmail.com>,
 <angelogioacchino.delregno@collabora.com>, <ansuelsmth@gmail.com>,
 <linusw@kernel.org>, <luizluca@gmail.com>, <alvin.sipraga@analog.com>,
 <clement.leger@bootlin.com>, <justin.chen@broadcom.com>, <dlan@kernel.org>,
 <rogerq@kernel.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <rjui@broadcom.com>, <sbranden@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <opendmb@gmail.com>,
 <andrei.botila@oss.nxp.com>, <wangruikang@iscas.ac.cn>,
 <amadeus@jmu.edu.cn>, <kees@kernel.org>, <tmshlvck@gmail.com>,
 <c-vankar@ti.com>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
 <daniel.zahka@gmail.com>, <nora.schiffer@ew.tq-group.com>,
 <v-singh1@ti.com>, <oss@vassilevski.com>, <haokexin@gmail.com>,
 <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
 <lgs201920130244@gmail.com>, <linux-can@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-omap@vger.kernel.org>
Subject: Re: [PATCH net-next 00/33] Remove comma after sentinel entries in
 match table
Message-ID: <20260904085811.7e2c2db6@kernel.org>
In-Reply-To: <20260904043724.2955444-1-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 10:06:06 +0530 Siddharth Vadapalli wrote:
> This series removes the comma present after sentinel entries in the match
> tables across all networking subsystem drivers, with the exception of the
> davinci_mdio.c driver, for which, the patch posted by Geert at:
> https://lore.kernel.org/r/e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be/
> does the same.
> 
> Since I inquired about a cleanup across the entire networking subsystem but
> didn't get a response:
> https://lore.kernel.org/r/b3d19098-eccd-4619-b667-ad3b7e0a4422@ti.com/
> I decided to post this series. Given that Andrew Lunn acknowledged the
> cleanup of the davinci_mdio driver:
> https://lore.kernel.org/r/abec6831-d344-489d-b70c-1e5dd4d43c2d@lunn.ch/
> and I don't see why the cleanup is specific to davinci_mdio driver alone,
> I am hoping that this series is treated identically to the patch that
> Geert had posted for the davinci_mdio driver.
> 
> Series is based on commit
> 6ebcf5074cff net: openvswitch: don't schedule rebalancing if there are no datapaths
> of the 'main' branch of the net-next tree.

You failed to specify why this "cleanup" makes a difference.
have you ever seen the sentinel not be the last entry?
