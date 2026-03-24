Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6FA38B7A6;
	Tue, 24 Mar 2026 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345190; cv=none; b=bsH2CZfI1UAqVd2U97weigPH64G8/MbU8R0ZRXNAjx/Yi6QJnov1q4/hK4GVgJLMEAKzb0MSftYRGLnHhbsgXtEWrD8pViOwVP/je+BW81xUAU8Rkd44B71Q3eEWrPqEb8wogvLpdrhOb+Hj2C4h8KDRfUl8l+xEsg7xT98+qt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345190; c=relaxed/simple;
	bh=eSSk9S/a5tSlLPfTiNb1+UEgdM6nFwQoO2D8Z4eKudw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TE7sRuw4S0GyhUkETlJQ1UiedEprh0Um+lS9cGA5FYcsWluk/OR5757uBpr+2fp8y3YGTxgDOmjlvOzMBjQX1KfLLtQJlYDTUs043lYEj+zeg2f/8DbsAD5163tt99SJqsG98TaXT/SfhNuBjylzC59GAort7tYMHdTIJ653qfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bFdClbMp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bFdClbMp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 16AED1A2FC0;
	Tue, 24 Mar 2026 09:39:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C5AB86011D;
	Tue, 24 Mar 2026 09:39:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E872210450D32;
	Tue, 24 Mar 2026 10:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774345185; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nJpZfWii39Pl2CGVviW5wJECwhKEY7RXjU5Qjoc9wd4=;
	b=bFdClbMpP0gfSu09EHQpPe4c6GMbqI3IOBKukCVmCXixiIZJUsNqewJjVmalDaJm0wc6DZ
	kuseC3/48cPQJrKTyE7YkXMNWMaKDvhYHLLH8YGdRRtZSOikYnTfCgzrkx/OdtdREwZqZX
	Z8cRKBE9KJzrfzJZXrbgQFLNV/yEXbmREH7lWa1YYC4jN19zOGbpTr+TLp9KinrlYmIpD1
	CWKLER0zgVX2WSysrkvrCYXQtBvyCK8gcDzvaIK0+Q0RQO0CBkXwOP1fGBGRcRkRQaOSWm
	5QpuBvSUQ9OjTBZOsITKHQ7yCP0VGFnWK28DEP/2FGGuZdkQA7DqeBSdmksgNA==
Date: Tue, 24 Mar 2026 10:39:34 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bajjuri Praneeth <praneeth@ti.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Louis Chauvet
 <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: Enable overlays for am335x
 BeagleBoard devicetrees
Message-ID: <20260324103934.7d259008@kmaincent-XPS-13-7390>
In-Reply-To: <177275924369.1445909.1029086854461649971.b4-ty@baylibre.com>
References: <20260216-feature_bbge-v2-1-22805cfdbf62@bootlin.com>
	<177275924369.1445909.1029086854461649971.b4-ty@baylibre.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Kevin,

On Thu, 05 Mar 2026 17:07:23 -0800
Kevin Hilman <khilman@baylibre.com> wrote:

> On Mon, 16 Feb 2026 17:55:52 +0100, Kory Maincent (TI) wrote:
> > Allow overlays to be applied to am335x BeagleBoard boards. This adds
> > around ~40% to the total size of the DTB files on average.
> >=20
> >  =20
>=20
> Applied, thanks!
>=20
> [1/3] ARM: dts: ti: Enable overlays for am335x BeagleBoard devicetrees
>       commit: 18161bb01ede109fed41c66efa2624a4c27377f7
>=20
> Best regards,

Thanks for merging it.
I see that you have merged patch 1 and 2 in your for-next branch.
Is there a reason to not merge the patch 3? Are you waiting for a dts
maintainer ack?

Maybe I can resend only the 3rd patch to ping the dts maintainers.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
