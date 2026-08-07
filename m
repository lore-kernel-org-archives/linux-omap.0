Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E532BE043
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120880; cv=pass; b=CsQ+PWq6ZpQo5w3zHb32Uos9gKeNGFJQiWXa3lFauQ6HgJN+k204KmADz5ZJUZD21Yw1F8va7of6Tbs62xC5sj2/gGcJaeUN7iCObyBnCpGLoKsxjbaGTje+yA76LSM60tscx3zd3u/7BO2wvmgj+M9LRB/m3RZaqA5kR7tkymY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120880; c=relaxed/simple;
	bh=H4YOFrL1KfBu3NDle8YUdni3Mk4BFwaMFq6LZ90tQgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObUu2ltHh3UZN32lWeinwFJIF9JnAXy3uWVGxHZ1uUPWwzxm25zUqx/oCeppI3BKiEOmj6j5q5YaxkTwhPIYEJAmb5pjolNjJ7x5KEYpCJg79We6HKmRLqfJLDmdXmPwuEUmJNt/ZXtOndFmayD7tdG4ECfusbqv5dmGYdWMT2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQWRLutR; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQWRLutR"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-74a9ac9cda6so1846610137.1
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2026 09:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786120878; cv=none;
        d=google.com; s=arc-20260327;
        b=JSrUD4KJ7lxCElk4k2dgCcco9fJaMa67J+/WFTU9zxyCGQC3BIPbrpepIRBX63XOEq
         gHLNt2IyCK8O0CTHSld/h7r0urdkRwVuLxZ+nE/E36byLCdmqNxal91QgSCXaAi3p2NE
         wjVwR6bixShttnecKxy4xAJkhO4WfaoG2Ow/OYoKaSBzcfaHo3fKk0QhJgH/iY5AleYT
         sn5eb396J5b1fXNzWqg3CI+noC6uYxsdcXafGJReFf7/9lxVdO8lz07tZtONrfSYf9vl
         aIcDXKc+9fR09dnagUf0vbGPnmT4lvwgy10VDzdS1ltDQ1nRuUDPSd0wwKP2gmOMcGlz
         F7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        fh=iklVbYRBwvPg39qSmkblZH+eFFfFaz5s/UQxTOxy+pc=;
        b=ehYsSZrQBU40pST5kjKxFsWCjWCgRLPmQ0BUXd+Vj6EBpYAqGj2CWv9I2H7U00HlSN
         aTV9A1NoABI49qrWVJEz220vxbkpa3eOALapFhxHjbA4O6v6epEfGFPoios1TibPHQDf
         OGsIbbmrHkWgqSSvpGpUBKANfvz7PRwdFC9nMKvzQohftPtgH7svVOS7ShJi7ez0B5yn
         c16cyVcByrhIDzS6gHMfRWaSUltz38Q8bLaGmAC1F5nwcJRXU0+ggXVP9xjtEZTbQ5ZB
         0P87fPCuSuMMIAotUzfVHskwViSZTmxjnEz+Twc6RqocoF219iUVJ5TQbSMWnTZ/CN2t
         c9eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786120878; x=1786725678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        b=bQWRLutRFUKY/OF/6kmInYCWZcLyGaNyhItdMuuSNqAsCkK5solo5inhvi1d1BllN4
         f2FoUM7mxHcL13xsdSR/PjkSNpSbqJj/E0MbKsRafc9xqsmfzHCyWRDEBQgN4b+JLK08
         UYTx5SRS4fJuAJpBFSxSuNzed4SPx8gdwyYj9WsGBB6ueJggMvg9FWBWELo6wWhOn3rA
         y1wE/RT0j5aT2IJEjyV1D4zko8RrVkwsyjdXrAGkhLFYzeBU+1Gc6EYCzu+62B5DJ6Gy
         HfDT1izxLFumQm48VEMQWq8NdYgygHFzGxLO+uJr732wFlpsz0FiOW8K3ymk2DOyCMxc
         APhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120878; x=1786725678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        b=T6XL/n8pA/Po/K8d+RgizbQor+kIHjppZpCT51Yi8Y0ms+nRKITwx50LE+YzgWaHTy
         HEHl1C+as8sKMVGVepQUmmNxhr0tQbyqkde812yPupvl9Ij4cSAWKNrI8MMpnQdFVO4G
         xlRKlUeALW9C21SrdeeRiW3m1CWDdhMDcDo6wR49qENJKZpjHfuB5A//SXGXlCVPEwTG
         hqWrolAKqIWOBL1g7tRouehZcNe0fu3qc6uOIr5oCqZSP+2Rym0OPEdvgagYCeMijWxP
         YJarVDNm0eo+dccjGYVOkBzpLURP+GkqeFiC7SSIP/p6bYgMyXClI6qsyW5VBo2bN0ci
         qJ9Q==
X-Forwarded-Encrypted: i=1; AHgh+RquoDf/PnhjPp+LNHv0qI9VISUleLpgwnHQLZPDKiWdPGws8yAhWLUyDGvzL9lHbtjkBR5WLkc9BiLk@vger.kernel.org
X-Gm-Message-State: AOJu0YydstSvuPNQrVlj+nykw/YTg3rDlSzyxRxMn5pX3u2TPlsVhRLD
	ZhLi+mb/xsCpi8qqimiXo9LE0tgToe4ASoC8tlJ6JXLmL5PhrZ95ELuS4wKydiJPy2RqMQ5L8tY
	omuOVL2OC9PRfWvz65c0bVKSJyq1ZRAA=
X-Gm-Gg: AR+sD12sF//KZRoNGczRK7AeEPXFuf2WRWwJVagFf0mWgHTkiZ9SQwcIqWMTREI5WUp
	8a0k0huIJMKpxHfkDd5aRuTR4WOWtHARf6HLT5B7bX4wlD0P1WdNNlSvmfHO2Tcb4g4NTByf9Bv
	3jP/B0uXYUhhMYsJLLDABeM3+aiJG3a4NPO1yZXQGstKxYjA55gmuqqoOtA6q+VTpURmBHSH2Vn
	u+ataOnJgKprpSD9xW9rk6t+3uk097SL/+HQl7dgwgP6/S/l/QgBD2oxvUGVZsjlFg031zi1ZSN
	8WoX5XZiClNAb9PfC6QqB0446ERZ929v2tspLNbZff+2MoNNg05X1zin/r+znSC9rPWfORgU5TE
	0h4evqWkapmMYPQx4/2BOShGRIC5fPw2GshwbFIAg0pbCen8/Uk4dLt57Yl4lTbqIlIJdynoxfH
	Yhn/UIwIohEsiuA/OfGdc9v0q90/W5IWYNLQV+
X-Received: by 2002:a05:6102:578b:b0:737:5c42:858b with SMTP id
 ada2fe7eead31-764e72c3a27mr698784137.11.1786120877713; Fri, 07 Aug 2026
 09:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch> <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch>
In-Reply-To: <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 10:41:06 -0600
X-Gm-Features: AUfX_mwLDixIRmddCRIK4ioEeGf1D4LRV-vMQxIFETRbvqYEEeJik4zuAKwk_IU
Message-ID: <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
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

On Fri, Aug 7, 2026 at 9:10=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Aug 07, 2026 at 08:59:47AM -0600, James Hilliard wrote:
> > On Fri, Aug 7, 2026 at 7:16=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Thu, Aug 06, 2026 at 09:54:19PM -0600, James Hilliard wrote:
> > > > MDIO buses enumerate firmware children only when the bus is registe=
red. A
> > > > later devicetree overlay or status transition is ignored, unlike on=
 I2C and
> > > > SPI buses. Supporting live reconfiguration also means that populati=
on and
> > > > removal can race address scanning, PHY attachment and bus teardown.
> > >
> > > Please make the bootloader work around the issues, and drop this
> > > patchset.
> >
> > This is just fixing OF_DYNAMIC for mdio now, it's no longer used
> > by the AC200/AC300 PHY patches anymore.
>
> Meaning it has no users?

I think OF_OVERLAY depends on OF_DYNAMIC?

I guess it can also be used like this for live dt modification:
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/t=
ree/Documentation/devicetree/configfs-overlays.txt?h=3Dtopic/overlays

> We don't add code unless it has a user. To do so pointlessly adds
> Maintenance burden.

AFAIU the patches other than the last one are still relevant regardless
since they are fixing a bunch of generic mdio safety issues in code that
has users since MDIO maps already change at runtime through non-OF
paths(i.e. SFP insertion/removal).

>
>    Andrew
