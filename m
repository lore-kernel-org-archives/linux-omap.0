Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438873;
	b=K+7e8cifG4ijMDngi/fBgKYpQE5JdNvypeXm2A8wO6W12pK/TtBnDHCxPRcYt/PdDClh
	 HMP5y7eW6HdFiUX+JGAsu8Uf7V2Ll5jaggn3ypZHUTRlGJeOKLaz3MnbG886BC+9jG0By
	 ALzyWe0jWtNOJ/Un9H6d/RaW2X+IUpg9+s5ZljHhDLsSMQdwHvVeTPxnGzlLEltV515QZ
	 SOZBi8axpghVTlJKLl2VJ0e+AdfYIfolinEcZlquwWRMB5OczCdiCidSfN/Rmda2nzQWV
	 kiUVhyAKtWTkX/n29kQXx5bSF3YnSTKZodOhBxsKgvLpxwfIWmaVpBjtC4xXoRymDlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438873;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=SsVRMPSyNzie31mooAWwpfLKTDZGyyCN3cZBedOe8C4=;
	b=kVWe1FwMK5ehYbIHMFaCkd1Za8MInQX7e8Xwn1g3giCEFNkld6zDyNxV4sDlaI4dXk86
	 /s3vI9jE3+2c/PCP9YxrDfvgAe0FpxIqmEqsi+rRztYbZDzqrZy9Jc7TwRTVBT1/pgnzk
	 5yD/H4RP2ljMISBLav9/dDRJiKcvXhCZwzdrwF0xppfBde5t0P4b8AvINB0/7BBSEUYTu
	 wXosa0Tm894wxLRkqJhDV3wPgbzvONIL+fjCV0bPxr4OO5h8SdDPRkn+QDf4hf4n84bpa
	 nKJ/HUWQcjNLYluSgHw7YRoxdIgIT1wBcfu0uH3xCH4SZTM8nZMU2Fx85uNzbWwrsoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=I4RCL8+l;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4147606A330
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 13:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4147606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=I4RCL8+l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=SsVR
	MPSyNzie31mooAWwpfLKTDZGyyCN3cZBedOe8C4=; b=I4RCL8+lfqpMIAWTNiyl
	Po3sM2dYYNnR0RVAbIEz75KzF2sOpEi0h7sIuXnka9qQIOHY6CY/PJ/feNrWrHrB
	6bE64kbw20m/c+8Uj3Shwms/DmvhERv6+T2Di+nxPDn1iG72DHVAo07B7mttZGEk
	+P26Y9LeYdoNC1jh+XZCwfj4cW0iB6iJdxdONZjGSIJTsLfP2lsc2WmoL/UGfZzq
	I8cjXXUtgimzxmC5e05i1VIhO0oxnQJlMWpgW1ch+DOcHjqAMQkKBMeAE+CYz9pH
	ZmQnveSzX5XVpsrjra98/SLTYFHxR77GV+xjhqMFLQOK9Ubg9ok1u8g3BlBr97zm
	BQ==
Received: (qmail 2731665 invoked from network); 23 Nov 2026 14:01:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Nov 2026 14:01:06 +0100
X-UD-Smtp-Session: l3s3148p1@vhjXL/FgUIgujnsu
Date: Mon, 23 Nov 2026 14:01:06 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>,
	linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
Message-ID: <awQ5Ems-ZyYsWVRy@ninjato>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>

On Thu, Nov 19, 2026 at 02:40:34PM +0100, Geert Uytterhoeven wrote:
> This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> about consumer devices").
> 
> This commit added a struct device pointer member to struct clk and a
> parameter to clk_hw_create_clk(), but the new member was never used
> beyond setting.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Cool cleanup!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

