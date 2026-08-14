Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3217B418;
	Fri, 14 Aug 2026 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686223; cv=none; b=ZXo+LOzN6l6Z5TSwF/43iWpPId2AeRqmloaVirXiRtLZWJ3NGe71PcIwxVn4rBVaVkU0nzKw2WtnkEsEdsUlwOwRZG5v9j2QSQ73FfC6mKWbMOQ+WP1azbO6PdtqEsZnt48EICcujOEKmPEHn4mB4SF1NUX0Pqsb2n0MV7668cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686223; c=relaxed/simple;
	bh=LMoo0ESsMRpEuzCtftGJUlU3NR/BBc76SjsdGAO3inQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=N3s6Tbx4Gva8GjNHIUFynEbz0dXN3HBTqAuLmjEB5IvRfQP6g5QbbeF9vRYbJ4Rv4ebXbPFyVL4Mv7Fuv7A/n33K69F45KxL7Six4Dw0qrTMb3oC523a0zytJ8WgikA6VRVE96TGqMaGS6cYsxRSErtvj7XINGXW7A5TDotzm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytgw9+dR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytgw9+dR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7B81F000E9;
	Fri, 14 Aug 2026 05:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786686222;
	bh=LMoo0ESsMRpEuzCtftGJUlU3NR/BBc76SjsdGAO3inQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date;
	b=Ytgw9+dRSf8eW4XWAz+lY/AvkgjXlzLzm0pQOVk8V/aBgll747HbxDjus4c0b0QjC
	 pRHkOG368JjnhjmGSkXKrtRBMjNcgrX/y7TlmsUNohj1R8ygMDT5CXSHDDC0yDKwvy
	 4GqhmRLhqkDaNwxAHIqpdDdZHX3M88Zqflp2l8fQRqCulYJCQVDn/3fC+8qwKquTRX
	 VirNeE+S54tKceFHplRuUA2lyy3Eh/8GDHQlsSNcXPD2f2BxIvki1YBOQA7O9+5O0m
	 WBQzMIxDuC/6xaI6CNqyotGBSJ/Scu/Nh5U8oGdMtIgBqxdcCPbg9vJS9Uhjqm8/J/
	 l3sULYlrpHQPQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260727-mathieu-wdt-clock-theo-v2-2-c048a6394436@bootlin.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com> <20260727-mathieu-wdt-clock-theo-v2-2-c048a6394436@bootlin.com>
Subject: Re: [PATCH v2 2/2] clk: ti: composite: resolve parent clocks by DT index, not by name
From: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: Brian Masney <bmasney@redhat.com>, Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Tero Kristo <kristo@kernel.org>, Tony Lindgren <tony@atomide.com>
Date: Thu, 13 Aug 2026 22:43:40 -0700
Message-ID: <178668622045.5897.18285793450979765927@lazor>
User-Agent: alot/0.12

Quoting Mathieu Dubois-Briand (2026-07-27 00:41:41)
> Resolve parent clocks by their index into the device tree "clocks"
> property rather than matching names as strings. This makes it consistent
> with other parts of the same driver.
>=20
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---

Applied to clk-next
