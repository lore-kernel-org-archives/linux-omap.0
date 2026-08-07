Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CE424652
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141968; cv=pass; b=OzK9z7alB/EgA3rAMxjqUYTh+amjxoRTB1FRW2m5XwEQck1wJfczdhw3ew1E+XiPWaO38T5TMlp2rTw4tXvdHnlv3jHgAdjC9RUlNkc8K8vgxA3t97MFWhUdFurEUBtPUfQdCpg3J6vMiXloAYibksj8n6WWgt0tPjMPV2NHI0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141968; c=relaxed/simple;
	bh=JwddWGJZUPZTzv6QSlQzcPEBc+v0AeD0PB2XVffGRak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4GWbDfbDr2niXy2+jElAS6eDzXNRfuym53bBtDjsGBfjxKXhYoEGVUP9je70j/Jx/Ond14VXv3cB+xakH9yZkC+rEawcBsu+x6ucnOpogyveRdGmvZmb0ULG1Iai0jfM3QPwFEk9cmHU6pxSpsutqtWVY+hT73CG4faq6q0yd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GywWj4T2; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GywWj4T2"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-76535268562so18620137.3
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2026 15:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786141964; cv=none;
        d=google.com; s=arc-20260327;
        b=eS+QVdah3zKX6vg0j0EVOO3FfHBr603THxgQVSLqVo7avJfSe0FSPlDmzvKHBM8bsY
         qeJeab8cLveYjSU0V3U0mSD/pBaPOjTrzypqtmyjqAvFnJjChjXuNmIf1BLFO3CC1nQb
         SvQzlboTlSaQy3n/TaFgZz8T0nXcK8BCHrNDGH3m7JqlfyHE8Pl4kaUFCEy76NclG7EG
         Tze1IStFwc+Pqs6d0s/SSeFlseXkb2FtJEMlB25gLbfJzx9zxd82ucfdd/xk93nuJppl
         /bMGiSgDnKI2LzWNVfrhPQ6y13VewsG233nfTqffqBtQE+u5Gr88AtYF+biOQB1HJeYN
         +OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fS+xnTply4IXaJCkwQuW09XhcpXvBoF9FN6yjQ3qbqc=;
        fh=yXXq8kK3haHg5Od/f2tnMU0bjCfBSuT2++xmuWd5+W0=;
        b=INQg2dMzhj2N/7bTw7UXhlvEsCGTacCbtWBMJROesWuWp7oZbdpfyWfnzyb204VWhC
         JCurHdaGbsExQoZEnSh3YXFlZK4HoD0xMBxOp3457TKYEDM0c4hzCrKvmGKFtxdvCFqN
         ChLszixbZtH8VGxHmfomambFgoYrpPula4YqSmpYTXq13xIJlFm22iZfrzchTHo9H5Ob
         eehDCdvnMr3U6m+VaGsCGnJwzEHZUxTspNP8d/zctwvSahHCl8/dUj9jYksuZLmqujxr
         YQbZcdVxFYUEWOex4IjA7iWFYpVOiOegaWnu5rnAi4BYdKGLyDfeV0INfNxJyWYmRx5M
         GR8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786141964; x=1786746764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fS+xnTply4IXaJCkwQuW09XhcpXvBoF9FN6yjQ3qbqc=;
        b=GywWj4T2knf15AfgTJDbwBtzDTM92LNdaEDsAKitc0j+V+AV9/s1lNumRYmw8JyXsV
         inHxrDkThPxGbu2lwTFe8Rg/yGX+cKCE8uS1LT/27grnY+YW9SuvNUskO9yJQ7c6oHO+
         BVWYZj0yK7obxq3WixDue7BwQg6s6d6oCRzhFXFuiKMKh/1rGXPAq63sFA4BFsi4JShS
         +Cu8fQF2G9hSV5mMXJts7ebH8DYzoxR7Ygf+MOEQ1uVSWUjtbXeuf5q+faL2HORjo1ER
         T1W/3PJ0QzYqThy+eUWFaAqz+7mLL6BW5gMq1U4eWbQsBiY6qanO4y0iJCNRgsYGSGut
         Etgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141964; x=1786746764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fS+xnTply4IXaJCkwQuW09XhcpXvBoF9FN6yjQ3qbqc=;
        b=CbFUr/Y3EgURdS9izL40FQpawTr2rkHM3/+rEsxmmBPqeAVpfcWMgjx6oI0FWdo6do
         m4Ifvit79w6Wi7JgBddn6vSZJCIvJk3DY3dUaDeK4opouxfoN4VLEIdO5TYTgvPUedeW
         r9sNeVPM0lx8qzv2z9IEqmo9xVgDqFzpcwFlrpuB6RKIO/xSCwQOT+77kqTGf9P4zQOW
         0HPnCGArqc9RDJdaRXVxzKHzbDUfsLxlrqA6w6R0Pp0GTbx1jPRE6O3FN19e7r2pIOw4
         o8VindyNsV/lKE7doHwq8keZ8hPGBdXq6JNZoDctWOLT8LvAa/JAF5PRpAxus8zuJJbL
         pJ2w==
X-Forwarded-Encrypted: i=1; AHgh+Rqmr51GwoUlOItY3FSh/+KsYund7yZk9HOtr7CQbyAmfU4eGrZOwiQ9xNdh8rVws8dp7fXvq8zv24Jq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv02gHh6mmbmwz14tBWuO4YU8ZB7AvT9jxsd0h0EwQQ4XDwBps
	0X7ObMn0MdEBWg31ODktorFYUflFXnHGjbmuCOmHucBmbdvhj5QAnBieVSYS40zcwEGqhM7rJXh
	j8qP+7/42+OFkLZnLpyNjXo+3xNL5ZNw=
X-Gm-Gg: AR+sD12jDmpA7gmEmPyyjoJLk8jjTKSOHSFX/04yOWeY5mILPJ6hWqZRfX84TtTuToc
	Yx6h2MBnkzFEpjVVSz6ETnNwC5PjaYXl0gQzz287Xt35ohzLYXZFr5p4Skd2wqIZWNYxPN0yM1l
	yU26h5A3fEiPVIO2Mt1JizzxWSlngVlrm57nVE6aBkLM8SAxUsjvEFg4LhnDcbFCwFUisO6PRFB
	X7EjiGDzSAegYEl+dUt+066gG4LEfSSek9rhBhFkBdrdmqQlnl9xCL+N+3dVVvRD9g7gqIy8PXI
	kdzjtBU3FmApWZ64rII1WzEWhqhNg0P8hSgKgS5HlcrhSgf78V4W9vVlLK4dPIMNZzTxdCcVi51
	D3FVciPqisArdnXJehC6yj3x6Kbo04T4uwf2UEfR2TG2OwHBMPkawmEE0hEzOP8GVoz0GrewwhO
	YrhYeBMCy5OnGo+e/MX8386ZCUe30OpaaFJSug
X-Received: by 2002:a05:6102:c10:b0:75f:e517:ec96 with SMTP id
 ada2fe7eead31-760e3194fc4mr6510269137.0.1786141963578; Fri, 07 Aug 2026
 15:32:43 -0700 (PDT)
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
 <3cd188e7-7dc4-4d67-82de-e2ef3edee232@lunn.ch> <CADvTj4pJG56UERve8BfbYzjCLO4KBDDuFviTcz1ivuwUFRMdxA@mail.gmail.com>
 <e0ed0a61-8878-46e8-805f-c0869b97da7d@lunn.ch>
In-Reply-To: <e0ed0a61-8878-46e8-805f-c0869b97da7d@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 16:32:32 -0600
X-Gm-Features: AUfX_mxyCMJ9oLuM4JTN6om3edbz324m6hnUZwCI6mNxVQPiU_32JZeN9SnoDtk
Message-ID: <CADvTj4rq2+scjiG8Uf771Q9ykhqDCFbAmNgNbHedyUteW-A0Jw@mail.gmail.com>
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

On Fri, Aug 7, 2026 at 2:26=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > So should I just drop the final "net: mdio: support dynamic OF device
> > changes" patch and keep the MDIO hardening patches?
>
> If you can provide suitable commit messages which indicate you are
> fixing real problems.

I guess I'm just trying to figure out if mdio map hotplug safety is somethi=
ng
that's considered to be a real issue or not when most existing drivers tend
to sidestep the safety issues.

If OF_DYNAMIC is something that will eventually be supported for mdio
then this is something that will be needed eventually anyways.

> We get way too many AI generated patches which
> fix theoretical issues which nobody ever encounters.

I did hit it in practice with my original series so I used that for validat=
ing
the fixes, however my later revisions use a different design that uses
phy_package instead of a separate ctrl driver which avoids the need
for OF_DYNAMIC support for mdio.

> That is wasting a
> lot of Reviewer time, preventing me and other reviewers from helping
> developers doing real work adding new hardware support, or fixing bugs
> which both them.

So to me it seems like hotplug safety for the mdio api is mostly an API
footgun at the moment if anything for existing drivers, so I figured since
I already had done a lot of the work refactoring it to be safer that I shou=
ld
then submit that upstream anyways.

Most of my embedded Linux designs heavily incorporate different
hardware autodetection/autoconfiguration techniques which is probably
one reason I like the idea of making more use of the OF_DYNAMIC
feature where feasible for the kernel.

> Those are the people which i prefer to help, not the
> newbies using AI and have never taken Operating Systems 101.

I'm certainly not a newbie[0] but I have been using AI workflows quite
extensively as AI greatly increases the speed at which I can iterate on
patches as well as significantly increasing code quality.

In general I run all my patches through many rounds of AI review before
submitting as well to try and reduce the amount of bugs and such in
addition to my own manual review.

Whether or not to preemptively refactor code like this mdio code is kind
of a personal preference however so it's not always clear to me whether
or not it's something I should be submitting fixes for upstream.

Maybe incorporating AI tools more in your own workflows can help with
keeping maintainer workload manageable? I certainly use AI a lot when
reviewing code from other developers.

[0] https://lore.kernel.org/all/?q=3Djames.hilliard1@gmail.com

>
>        Andrew
>
