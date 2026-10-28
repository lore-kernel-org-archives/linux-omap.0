Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195849;
	b=BB1VRKe068RbbQESTLcxbEOIaulrEQ4MlJSg4bshUb1sNpD+juSa5OPPfQF7wK2UE95O
	 lAB217BpqzYHHMWsOq+6jPkPDnW0VBYV8NqJpWlXEzpX4q8kfrRm8icDuWyBIDNKhxflC
	 lkc78I6luc2SmG6QibJgb231IL6XIMB6F06OkN3aQNFEXQ2FYwI0/l8Ivb/000n7bHKSe
	 iiQJTjB6jO2IBKgdn43+OVx+kIpRC1fjAJnIP16mkEKUxUbxclFX4ngbiO0CigYKzzQPZ
	 atb1ulNhsAhEz+tM+ammbOISplH+d8impfOxRo9EDv879WYptFQ5njyL0foYo4SfaGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195849;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=kjoWncs6Ir+gA9d8rwO7aJw5Gvr2T1m9bpDOqJloaOw=;
	b=tbhSXN1Ttrro+cQj2SFQBvrKMfEPjPiDJ5jF6NNvwsjDzEJdJDPj9eWdpy4nbIyH0xmn
	 aQTQLwtuTzexn/654gW/QBc+YwqRfy7qoKng9WcHYyjIktApIWjpxxPvmkvCX/GTYUs/6
	 4XJW/FcvXVu0+PeM7gC/XSBXo4uBidwHR6woRkjz0QG2mi7NXuhnzNUt7BTumXfAkxsGq
	 OkLIL9X8FqdNKcgTVX0CG9SXKxKjwe/xIfJz3T1uQ56U0ljgMAOMN8o7mD0VPBsJpGDVU
	 t0dKHYG6TcmxY//FyQYYokzw0Yg8osQ6kqGyFUfHvx4HPR5IJnoH/WxVnQLSwiFL4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZwIzZq+o;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17155606A31E;
	Wed, 28 Oct 2026 13:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17155606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZwIzZq+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793195849; x=1824731849;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kjoWncs6Ir+gA9d8rwO7aJw5Gvr2T1m9bpDOqJloaOw=;
  b=ZwIzZq+ozL1CIxqmw2WKf+NvZDuyx0YsJkKbifCOXplLjHYlj78YhoqF
   GZ4T178s+rBLI0Wf6czymlgpO66CsBppllp38+eBcU8J3hQ6f/cDvKtZP
   JxjJWmRb2EZ85mYaiFpCFTqq1X9LCeVFZI0KEkHbn5cHqU6SaU5u8Ncm6
   qpjQnIPSURjzw6CSmmKs7fntpwTeurt2QIiDz2WcQHuXOKCj5UAbCF00b
   +zyFqLAA89r08MVecMbTUErEtSMGZbNtyJmpRCJdRVvqPHMJu9IlCFQbH
   Pu5OqHFRAcxSTEnq9VeFFBD26ZA/xsK/L4Znb8vsztKCUnFTErbKNOmFS
   w==;
X-CSE-ConnectionGUID: McGPa8nmSF2pWpGaQxikcA==
X-CSE-MsgGUID: 6Sn3DPhMQJGo+SFa9z4heg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1929831"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1929831"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:57:27 -0700
X-CSE-ConnectionGUID: XGvMYi6BQtyLHQWIIJ1jww==
X-CSE-MsgGUID: zT8iJdk1T9Kr8hcOLr1FEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6667408"
Received: from ncintean-mobl1.ger.corp.intel.com ([10.245.244.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:57:14 -0700
Message-ID: <733ef8df15abeeacea0ac12dd93ad1eba5755dbe.camel@linux.intel.com>
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"
	 <u.kleine-koenig@baylibre.com>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, Sakari
 Ailus	 <sakari.ailus@linux.intel.com>, Broadcom internal kernel review list
	 <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli	
 <florian.fainelli@broadcom.com>, Eugeniy Paltsev
 <Eugeniy.Paltsev@synopsys.com>,  Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team	 <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Imre Kaloz	 <kaloz@kernel.org>, Conor
 Dooley <conor.dooley@microchip.com>, Valentina Fernandez
 <valentina.fernandezalanis@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>,  Daniel Palmer <daniel@thingy.jp>, Romain
 Perier <romain.perier@gmail.com>, Robert Jarzmik	 <robert.jarzmik@free.fr>,
 imx@lists.linux.dev, 	linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, Hoan Tran	 <hoan@os.amperecomputing.com>,
 Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
	linux-hwmon@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>, 
 "Enrico Weigelt, metux IT consult"	 <info@metux.net>, Viresh Kumar
 <vireshk@kernel.org>, 	virtualization@lists.linux.dev, Yinbo Zhu
 <zhuyinbo@loongson.cn>, Thierry Reding	 <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 	linux-tegra@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Srinivas Neeli
 <srinivas.neeli@amd.com>, Michal Simek	 <michal.simek@amd.com>,
 linux-aspeed@lists.ozlabs.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-unisoc@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Michael Buesch <m@bues.ch>,
 William Breathitt Gray	 <wbg@kernel.org>, Robert Richter <rric@kernel.org>,
 Andy Shevchenko	 <andriy.shevchenko@linux.intel.com>,
 linux-acpi@vger.kernel.org
Date: Wed, 28 Oct 2026 14:57:11 +0100
In-Reply-To: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

On Tue, 2026-10-27 at 11:48 +0100, Uwe Kleine-K=C3=B6nig (The Capable Hub)
wrote:
> Hello,
>=20
> the original motivation for this series are the patches that convert
> the
> arrays to use named initializers, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre=
.com/
> for the idea behind it. Looking left and right a bit while
> implementing
> that, the series grew a bit.
>=20
> Changes since v3 (available at
> https://lore.kernel.org/all/cover.1793030820.git.u.kleine-koenig@baylibre=
.com
> ):
>=20
> =C2=A0- Picked up review tags (b4 even found some from v2)
> =C2=A0- Add a 2nd MODULE_DEVICE_TABLE(of, ...) in drivers/gpio/gpio-
> mpc5200.c
> =C2=A0=C2=A0 (My grep didn't handle >1 driver per file well), noticed by
> Sashiko
> =C2=A0- New patch to use named initializers for auxiliary_device_id array=
s
> =C2=A0- Fix code style of of_device_id array in drivers/gpio/gpio-grgpio.=
c
> =C2=A0=C2=A0 (My script doesn't handle of_device_id::name) and
> =C2=A0=C2=A0 drivers/gpio/gpio-ppc44x.c (didn't exist yet when I sent v2 =
and
> =C2=A0=C2=A0 failed to notice that for v3)
> =C2=A0- Fix code style of auxiliary_device_id array in
> =C2=A0=C2=A0 drivers/gpio/gpio-shared-proxy.c, missed as I didn't have a =
script
> =C2=A0=C2=A0 for auxiliary_device_id before.
> =C2=A0- Dropped a few broken email addresses from Cc:
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (23):
> [...]
> =C2=A0 gpio: Use named initializers for acpi_device_id array
> [...]
> =C2=A0 gpio: Unify style of acpi_device_id arrays
> [...]
>=20
> [...]
> =C2=A0drivers/gpio/gpio-novalake-events.c |=C2=A0 4 ++--
> [...]
>=20

For gpio-novalake-events

Acked-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
