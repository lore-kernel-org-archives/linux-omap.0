Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1019046E;
	Mon, 30 Mar 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877866; cv=none; b=uUR86iAF71J5SSI9E4/iCAcmSp7jR/3SkYPIPED8+v2ygLg3jQLz6BM/r9ARxP7Iyf5q4SqFcEOMsr2Fi5YIy1JwpxoCodeKzH2EEJp/iQS8GT/nLwFo24GHdh+cRINkCYY2boBm6PacWWErEez4qpkWMDZPZck3CHB1S2exruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877866; c=relaxed/simple;
	bh=d49rzc7VgXP+qBIv+G+I+R2A+YQZkwu+LgZRxaLstvo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PEFUREwZFgAPpIBQnF0s69t9kQN8vaCgOaJLbyVMWY/saRcG9sdiSTnECiPdQO30Ks7s/Nx0MMCOmSGDk25fuP0EP4sWV12tIQ3dbmdnkcoSwLYVmbYN35IE9jV9JEohkuFwN4QW0A0l7SEIylqVJvAAV4SbXKRFZgsxC9PzO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl8hWv+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl8hWv+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E17C4CEF7;
	Mon, 30 Mar 2026 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877866;
	bh=d49rzc7VgXP+qBIv+G+I+R2A+YQZkwu+LgZRxaLstvo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Jl8hWv+uJLAQPEKSKGdE36Wo97h3x2+83eL7VvA30dPSlAGNq20iJlr+RrB0l/qTB
	 ls/X6vlrnayAkWbLGo3aTXCmKM1Hc38gIVCuDo751r6yCFETwEyUxUhqVuzm2Q7CPf
	 QNNFMh+B1VQgOfWxTp/t0lan3Jg6GqfmcBB93S5FvdgyITm+lP1TOFxOvjGOYtj4sg
	 0zxKew3Il0nIua8n6fqyzRXYLwwhm3C2PexPHfFLzXAn46rqWd3KlckUDVlhc4gICb
	 /8wPvlfxqvBeu4mC48PTYWwBgbqs50wm62Vlu2LQq4T341SB29J8ikM3R7KY3oTVqw
	 RRViDgBf0tbHg==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 15:37:41 +0200
Message-Id: <DHG5OX85I4LL.39U0RRBS0JXFP@kernel.org>
Subject: Re: [PATCH v4 0/3] ARM: omap1: use real firmware node lookup for
 GPIOs on Nokia 770
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
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
In-Reply-To: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>

On Mon Mar 30, 2026 at 2:40 PM CEST, Bartosz Golaszewski wrote:
> Bartosz Golaszewski (3):
>       kernel: ksysfs: initialize kernel_kobj earlier
>       driver core: make software nodes available earlier
>       ARM: omap1: enable real software node lookup of GPIOs on Nokia 770

Looks good to me overall (one minor nit in the first patch); which tree sho=
uld
this go through?
