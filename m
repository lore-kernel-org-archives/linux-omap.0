Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4E86341;
	Sat,  4 Apr 2026 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310450; cv=none; b=A7wk7r7ShoLu+5Wp8c8IDrCUz+4tco33OFArZDjh2LxrNo+xE9JFAWL5LO+nBo1YTsEVQ1n5ljJU1cUBN7COw7xfxllwoOgU+S5KzSvCxkXWyTYf7Z0/RlKK5bRCeJNhsw/se5ZPTmU706IK59cDtidADGOwnvIDlNACv84zg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310450; c=relaxed/simple;
	bh=ZLP7WHBUvGDqXuBLL29WpNLjtnUknY8jBSPfm/qjtPI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KxylJwku4B5aqIZU39xNtBz9LnlAfbfG62K0cA9uWaXcPRnaqphvBaJAIfkYKghNGt9c5NB9IlV61SQK0584CbuWUF8jA++e87SBOlp37rpTM0fBTeNj94gFOIXAgQLZ7NBNXGZ4VzkTMKfYwxf4DrA/f6XvwzzHuB5u3v+/9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhCjIRFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhCjIRFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC5EC19421;
	Sat,  4 Apr 2026 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775310449;
	bh=ZLP7WHBUvGDqXuBLL29WpNLjtnUknY8jBSPfm/qjtPI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uhCjIRFhL/aeqFHYthiYzndfhCzh2nfXYQlYiE/WxBoVAQnyrpal3qbB3Z3I0CJkh
	 H7PfONT5MECquktG45xjU1wvr/3DUQIPlV3ZSGEc1Ao5oCsufqv428yCTRwtcLqDjH
	 nOj7thtebyEcO03JhqdpJJFTT5RdLzLCwkTEXQ0SFrp8SAN3tSHI7hYOUQrz6hQJxc
	 UAZlS6dJ8kOzEqZousN+gvqzxXONWyaEraHkEf+D6+9ejjV2s11GWTuvopR7q2dbxN
	 eVup9aQgNCCJAcyjipbGZIl28Y1z8QCGNuQZz2vbUcyRlz7NnuKcKD2rtY0149P/SQ
	 ttMm6rCmBGCSQ==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 15:47:24 +0200
Message-Id: <DHKF135KLNW5.3LT0J6T5TE3JD@kernel.org>
Subject: Re: (subset) [PATCH v5 0/4] ARM: omap1: use real firmware node
 lookup for GPIOs on Nokia 770
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>, "Tony Lindgren"
 <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>, "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Arnd Bergmann" <arnd@arndb.de>, <brgl@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-omap@vger.kernel.org>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>

On Thu Apr 2, 2026 at 4:15 PM CEST, Bartosz Golaszewski wrote:

Applied to driver-core-testing, thanks!

> Bartosz Golaszewski (4):
>       kernel: ksysfs: initialize kernel_kobj earlier
>       software node: remove software_node_exit()
>       driver core: make software nodes available earlier

    [ Fix typo in the commit message: "s/merci/mercy/". - Danilo ]
