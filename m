Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97F4749C6
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114801; cv=pass; b=q1tv2zee3OdZ8t/t4KIM4jzrtG4fyE4AQBP3xBNizRO9Pd4HuJAPVlSbkMmplRfoZqH2u1eeESJeSmaSzVCaub/iyYXacTnsdsaVvdPNU1XHp1adK85cQPHTaRty5QXnNBzeq4q52PbRFLHcKHN6Ys9lQGudRW9Mkz6+DNTdRss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114801; c=relaxed/simple;
	bh=gV20Qq1q8KHAEqMNSgw5mTDYx8Xl3nfNz4w7UDZshT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3YSGbsmcpQzISkUrASYXhUKBLTCnYapL64uvi5a3R6jJoETl5iikzlfnOkF2BzrNRURwzbxCOo4r4ZXLz2Q0EhXpkgEZQ+yPNzZhLwa+RWVhdGn8hThg4z1ZqVpiYaZcvIZ5+8EJ4hVTQ1+z7HR8686RY0QHa5MyFSXtxAM0TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyl+qiOJ; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyl+qiOJ"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-74ab99038afso1860463137.3
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2026 07:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786114799; cv=none;
        d=google.com; s=arc-20260327;
        b=NPrwd4u8gqQAS9CW7WCNjhQ/75Bd27In9MnY4OPRmZ2cDEzpFP54hnlPboULkXaRsA
         hjJOA9wR/Ep/5YGVQKJd5M88lYzaM2DhKYy2hq+y5vXSm0pvP/jX4Drs9Euzu5PL49ux
         ajFnbKTb194JNeY2D52fyzLWv8ZICFw/ZFoU8G40pmrEbKRikiK4RHRiT5Xd53+54GGY
         Mot+wIi6CZqMwWcs8UnSjFxf+9r40fI+TolNEiIRLFMKmemOmq00mGhbAna6DpA/GTJM
         yZQfi1FXVEmHC0aV5nr+30o7+Fg6RdSXLcfyT+4a9Kt5hapnRPgfmAkC9CPMbdKADgdM
         97mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        fh=HzAVzY7y0ErngZe7nff3buh26l0Q0ASGnertkcXkOWM=;
        b=gO5QfE5/LqG9aqgK4eBIEFJZ5iA1Xu+U6fbQG0nezlhFVK/oXMNaYa2z+maMcLvZkn
         wDRKxwxa7aTgDQL8dkw4yr7Oe3Hrf26Pgdxq1/IOjnaJM34wre01QoU4KzMI4TYX4/f0
         G2fHPjAvwHcXY6NA125DlIE5LVVXWHPHql0yjCg67TNiPQ3WQXg6ugtHlyXlgatUNmUK
         uiVxTKBvapbzihRzdnnXNehS4P7UUTsxuZjXBP39C1209Gfo8e/75kF5Fq6aH5aOxWcB
         Ye9KpeiGDWMRZ0gMIvtlJnx1nkXDrtb5TefJMKKrw6VP2w8unVU0fia6ufdVP5B7tyM5
         62SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786114799; x=1786719599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        b=Gyl+qiOJiAmjPzSOy+yAUbgHE7C2l5ryrcwZj7SEstdeZ+RQ/gj0b3pqLcoW8xI+G2
         w2S7/9zA5bbP10Ap0l2Y67e5QA9K44vSAFVIWbKWgO6Z/6LORJD2qArzV6qC4vK4fVhi
         eMxU0mH8NslkObuipwS/rQBTeJrw5of9PMksU9uX9cTRAZW3bLaQY6gq3kblSvGOAJvT
         3U2CmeCH60eiIbrMmDDH3T+kowUcOpAd++FiuYPTcTvC8T+++pRDc2WTzkLjNMsD0y8b
         mryaobBDYudLE61t/mF0Znw65XqqXKH37ghcuoyZbB9lu0pIgHgMsV332cNNIFOP1TRa
         E9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114799; x=1786719599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        b=rqzvJOt9irFl+7A7cZpXFjvMrmUYnrjr/50H9SjMxSQkEnw1VjAQ8VCuYhT8szur/Z
         qjNvf2UabIACSGieZsfaEoexRCfYQDPuoxt7JeQVgpuZ+em8FuVV9wnsQMW1Y90N2GrI
         ETTT2NqgP5rgRUqmpeHSN6sz/LmitGoLe1RaBkkjTNBhs4aNCgzwy89j+2ybg/sYp26U
         MnYc/w6OzOCUBrQu2o+L/VYGyVxWJEl3HEeS6XJeWohiXVhWJta+LgkfSEIwQep6wjWr
         cZrvG90+SBAKNaY8y7iQlaeMlLW0tmguxEX6U02py+6epLyRqt+CPkuFqWNpm/FxoQf1
         KQ5w==
X-Forwarded-Encrypted: i=1; AHgh+RojI0ZBtp7gc2Vdd21ihZFfMi2wJpr3PU+LvWMD+6yRaRcJgoe/qlgeDRVEzpV1DiUOwJNBg5WtNHaA@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFCxUa/Mdqq0GkNctsRUHnFEvuU+e76IGKDbytQMxUR1/qkzH
	FxWvcLMS4toYEPKkJemRWhPyUO+Cr3herPBODHQLqHJz62jtEt/7HoY27rY4p1FJKa+WZJurT2L
	LfEpMRH/jFPpPwseF54y7MZc5hUj1GYo=
X-Gm-Gg: AR+sD12TUYs7X9GCk63pqJ2iSILn2mvJdhL2TN1fFLqmU3dE4daCsenUab80sPkgAF2
	Fh1A58QUKKYTuaU6VHDnSfvmtib90Nr8RPJh9gSkXslTTD7HiDGykYr6dQfrTtEajrGiAhODxAv
	N4k05o1ZU4o6wt7VHDr6uDBJOkl/+/m18OUnlOaE6y8qOZRqqWt+GKPz51hVgIF/ci66kiOeYqP
	RsCQKjE9l+BZtXf+4llMSk+KXkVUCGx5FJ8p0gC71bbQsteNeDbjyBAcaVx1H+vbckZTf3eOVEr
	kphpg8158raBbbGojGLjBrWpiKwBSwxp4f/ZUoug+hFgg4Ibm1nda+ot2z3eZkS5CNZXLyTiTEt
	q7b+z5TYR7o+5nud/B4IsFib3BPJXFqOy5N0csLoJ/8eWhjjPwCfOV3z0T4J1iwygUQOaE+6vJE
	fyn24nyf67tR7WRCiNpnznWiXQLs54xGxkB5Az
X-Received: by 2002:a05:6102:54ac:b0:738:bf0f:d0c6 with SMTP id
 ada2fe7eead31-760e3b9ab74mr7413161137.0.1786114798682; Fri, 07 Aug 2026
 07:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com> <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
In-Reply-To: <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 08:59:47 -0600
X-Gm-Features: AUfX_mzMI4rGrSWJxil0rkCdGHQcdQSp5kYsnGxukt-NVGzxhhYkib-rvufG5PE
Message-ID: <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Michael Chan <michael.chan@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Timur Tabi <timur@kernel.org>, 
	nic_swsd@realtek.com, Byungho An <bh74.an@samsung.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Sebastian Reichel <sre@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 7:16=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Aug 06, 2026 at 09:54:19PM -0600, James Hilliard wrote:
> > MDIO buses enumerate firmware children only when the bus is registered.=
 A
> > later devicetree overlay or status transition is ignored, unlike on I2C=
 and
> > SPI buses. Supporting live reconfiguration also means that population a=
nd
> > removal can race address scanning, PHY attachment and bus teardown.
>
> Please make the bootloader work around the issues, and drop this
> patchset.

This is just fixing OF_DYNAMIC for mdio now, it's no longer used
by the AC200/AC300 PHY patches anymore.

>
>         Andrew
