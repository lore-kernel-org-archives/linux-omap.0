Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D863914E4
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2026 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131250; cv=pass; b=VIdYZN7F43gUhgpOC7o7PhCu1gCLCecHf+3gTIZt3Pf7AYgPVJN7ZFmtgQxFVyPM4xCwfDPnLr8RkCVzdEgKhE/dgoUJr+bv+vb5ITuBTkgTmXJ9v11w8zktW1JXgjLBWiQ12WFa0hSLJXKtZUlP4F7d4x4ezqi8DM1+khybp84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131250; c=relaxed/simple;
	bh=U6y2778gV/zoZJ4mqp5v2pm/RGDs0J8HINfVltgsuYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZajRb1MZahtMpecB8SdNUMx2jRXjqhZ1dRoXru0bNmLkKKqr+Zp/6uf0IJAAoqg7GNgWztmrctRpzm8m6bmfwBUoNT83SeQl6rulcZ7XlomVgvVxbDWHG3a7L4OAA2QEreUaG+Kab1n6XWZxpmnbgAifUSw/U6LwVg1iBnmFeXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if9oZXL2; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if9oZXL2"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9690c99c917so1324252241.2
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2026 12:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786131248; cv=none;
        d=google.com; s=arc-20260327;
        b=rPzopMua6vG01dSD2RK5804Cza0z9oYPRrrfJzeOufgueaPJ5Ik1+r09oJIdRw6auo
         RoN4QOImj5gzipfWAmzSZu0uvgUbsfTjN1GHvvFv737PZ3sH+gLcEsOx6XPPWi1ztTQ8
         7bWE0Lh3V4x31XJN4E8mnRMY29XYTO8ljkrWbIlrgg09l/PSd2Fnce77xKOTwe+b810h
         QMUeLJapumR2Loux1FEkcEzjYFxAsUblIJEempueb1DlOFcxOyt2zksMhpaV8mwwbjIw
         KpRBLDDjSp9rPttaB0R/BNezmG4eE/K8IymugEvYOBFFakBnlHCQCtB4Vdwl+Ri4962w
         jUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        fh=nFBIn6LH4DCoKHkiJFj2s9eAhRFOrB0Y3/kkGY5adv0=;
        b=eJvpevDrrg0IPDPwQ5bD2Oan79DSNtXU4joLhKwm+0Gs2pXIFVXwJTcifIwgI6Vpq9
         4GqZiXTyxu68BmAj8wy3W3CpDe6pBJ5aDg2TUakkaSQ2JMclYBDp4vSogd9wwvQCtkyA
         KQsU3E4Uo3JqrxJSHiIjNSIXY8nVh4+dz7mL7mhPZmf/aHbifekUtr7TV5N3xRI1aMsU
         xIykFxKWmFeosmsWwnOco7am2yN48XhVk1tcEvWuTmhGS246LcP+cPXuIdIMau5iqZLd
         KoRljbClO7nmekg4xnWkeXv6UNVbY7vEXNHkdm+LFUlDuWoo7Kzrugi82n3zN6TPt/ja
         aY0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786131248; x=1786736048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        b=if9oZXL2QnHfigqUiImu8fydZDDmfepU1ziHSDHwg7vyx4Xxy/XF34gEbxEUmIxlYr
         9lnAor71qGZtrcZ1O/AuT3Xh/Tnc00I0GrcxCDbiovj7vYoBlf/wWyIU5iX1MDNuAiQr
         sR2mxMFCsueH4zaYb4l9jPB6vDN/lJ7pzUNYfgfGxdGHxEYSUB3e84igBa/7w/KH9aOJ
         ljGKoZxmOvtGP7U7YTOighKHbaO/0ihPftlNtXN6NW95qC1Wt35lfYcdtYDNkzgNH4Zx
         UkEwMMrpGixtIM0fpafEEGuwKs4sIkmPozmk2RMLVOphB//8Eh5HDdpWeDByOxTwmbol
         x4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131248; x=1786736048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        b=FvQVArcgfsJorAFZ4Cb6OZDzaCvSO6d+RFwaFWodowRM2M1riUWAs2/D56D4ZFgntQ
         Qt8zS6lbr6EK+5xZPq92H6J+AEXP1PKTda7fJcGkAcGsrKEMzETEpo8g3tWBkkgNTfbO
         cxbwdr0L5GyZAp902Ejg/Rj+taKy6RF17asBt+AbsUgn+IFI942lBzv1T3vRDNkDKM4+
         AnSx0zQxkTUnpwHM3+8ggMJh36Y+jOipf0goQsqL6JetDOcKy2I51vnaxq6f4np5WTKZ
         QFaVb1bDv1AoO3AewKxeppCy7MyAfwF45us+N6+vsCkv1zByPPPArt7XQL0hx8xRl8rS
         uQiQ==
X-Forwarded-Encrypted: i=1; AHgh+RokCqD0SwqpQ8zqf835l2Rlg4F5JVOwzN28hn9QTM09TDlaQsBMSQjLTTnLfCmQODe2qaV9qIF17lTw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1pyzQbRURwmopqdBGXsXT7D9SJPxGLyJItRSU/S0HkDQytn2
	ltLMgRQKOcG/87omhndMEe+VVY7clhI5LwvN4vRY2uDKdSv9JigLPccJeCgzOmNoBkAwjO0pM9l
	eW7ol0WcaDEJJ6Y0CN/jOJY5Uk6c8OQY=
X-Gm-Gg: AR+sD13KllKzMMjR8n5yCoPVZeNSwF91dU9jdDtq0CIcJY1JN5cyb1PhQ0AwDMQV/vC
	bbtwA+OM5den1c4Ev5u+houeL3eqDh146oRu6+c5U8vXxRB6osl/SC8b/EqVxdfnWF5xCxpncKd
	/JBmJVmFttlzIL4tvVeiJ36gO23vaStRtACFO+ypTlrat09Vj41tA+DNu453KtHn5pKCQc2T3co
	HutYCy9jwpVt7IN24xnorxAfPOdbj6mkCriFyOBY//qSbjIHI6GGbmPPjSGSMpeBC0TVn7pNUsj
	pqYie1BlRWRQ2vQIRCtZswTracwWyBCaqCc5t4FDnLmW30BV+kTtDo8OW90sFFl/1/07jYa3zwT
	BzJfC2zDsW/QCg5g1nSdmzcQq40+mzz6o/HW/Ad6ICH0gJqZTtHP0FzbBbUPJ3N2biQVyzQ6Err
	31P1fidy5Fw3y8oyNghC16BhSU08FBZS37pOWF
X-Received: by 2002:a05:6102:d8e:b0:739:478b:5bf2 with SMTP id
 ada2fe7eead31-760e8f347d4mr6463052137.13.1786131247763; Fri, 07 Aug 2026
 12:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch> <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch> <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
 <4aeebecb-81fe-4f09-9dfe-a3be2f778bb8@lunn.ch> <CADvTj4qrYYA-e+9iJ+q4UaZteUjpypRa6HBSmwp-ajwPbwYERg@mail.gmail.com>
 <3cd188e7-7dc4-4d67-82de-e2ef3edee232@lunn.ch>
In-Reply-To: <3cd188e7-7dc4-4d67-82de-e2ef3edee232@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 13:33:56 -0600
X-Gm-Features: AUfX_mxMpD-qand8wklMDqDrRd_xxDI0iY7G3-8rmiKaEvXH5AFL93SLf7_FiGM
Message-ID: <CADvTj4pJG56UERve8BfbYzjCLO4KBDDuFviTcz1ivuwUFRMdxA@mail.gmail.com>
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

On Fri, Aug 7, 2026 at 1:16=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Aug 07, 2026 at 12:48:43PM -0600, James Hilliard wrote:
> > On Fri, Aug 7, 2026 at 11:15=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > I guess it can also be used like this for live dt modification:
> > >
> > > A guess is not good enough. Give us a concrete, in kernel use cases.
> >
> > I searched the current tree for callers of the OF changeset and
> > overlay APIs and for OF reconfiguration notifiers. I did not find a
> > current in-tree path which adds or removes a child below an already
> > registered MDIO bus.
>
> So lets wait for a real user to come along.

So should I just drop the final "net: mdio: support dynamic OF device
changes" patch and keep the MDIO hardening patches?

>
>         Andrew
