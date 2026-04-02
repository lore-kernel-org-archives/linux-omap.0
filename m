Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF233F390;
	Thu,  2 Apr 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147401; cv=none; b=o/khDze3Uz28JtK1y9KDnLhdH9rKhbc4iRCe2XTf7S0ZQ5WjOsNjeEYcN9mzV42JU+GVrL1avx3LIAvlK1GX1sVwpJzHc2Ici1LFoOpYkrDv4Tn7W5ylC3DnmZ89XCLyIIywEPpNon75ERW3S05qF6HrCCUU0mkcRRVvoNTA/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147401; c=relaxed/simple;
	bh=w1dW8AZk4reCHACcRL/0+eMefcFQIN8mzWpVA8G3YSI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=lKamiG7s6d83ZKJ2JJsYI3z2QmVy+xiZnHKx4DVulPkDqcQbZaw+JKH9H/2vVGj9pxIh2lUy0X0To+rTSDpsZWSpphCn8ZWp8G/ctukypsEa6SWMdTreBtkfd4C0m8/QEb8fyKiBQl1m84escEfXjx+h6rR9g0tmNWa7EycubX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHOyIcuz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHOyIcuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198D7C116C6;
	Thu,  2 Apr 2026 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147400;
	bh=w1dW8AZk4reCHACcRL/0+eMefcFQIN8mzWpVA8G3YSI=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=KHOyIcuzguDroW3VbA8bQHdLBILXZSpffvP320Gcop3G5/+HewMrRub0Hx4dBP8Ks
	 iDZHmCQD7FnOjeaaWJq49GeqWXgFEnDdcJpq4VQrI+zI8lz/6SjsVFidu0RoIURTts
	 70rLx9nJyQEb2tR8Y63JVX9V/El/5pKBQu7AYUmwpD/Xok/5ilw62F0JwwDME1ldzL
	 zkWXlo7UAgPyn8Ou0yBdlTAHOfA0b5ApTwbiO8KwS124kHhZ0iQNCygnZph6filT0I
	 rLBwc81Dcg0gyCYg/spGCS0zfg/tLbZW/38xh0jL3JKznlOTP6F/IsXyS6n/39UMFl
	 dtNAN9+0M47yg==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 18:29:55 +0200
Message-Id: <DHIT8FGUNBB6.3JBUXPIVOP6GU@kernel.org>
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
Subject: Re: [PATCH v5 0/4] ARM: omap1: use real firmware node lookup for
 GPIOs on Nokia 770
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>

On Thu Apr 2, 2026 at 4:15 PM CEST, Bartosz Golaszewski wrote:
> Bartosz Golaszewski (4):
>       kernel: ksysfs: initialize kernel_kobj earlier
>       software node: remove software_node_exit()
>       driver core: make software nodes available earlier

Looks good to me now; I will give it a few more days on the list and then p=
ull
it in for v7.1-rc1 if no one else raises concerns.

>       ARM: omap1: enable real software node lookup of GPIOs on Nokia 770
