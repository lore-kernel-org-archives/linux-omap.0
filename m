Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138850;
	b=ZMqQnaRKRxaV7AnvdVoBd3JsFbw094nORglGjSadlLxFzzp+j7gQ2uzZN5D0XQXxK8DW
	 gQ0l0tk50aEzKeU5wuHeCdpahb5hIBne/MPaRWmlKBlzBjwW/Kpw85kmNq8k/6NAv16xU
	 2AHC4K5F/tNgfmLNU95jvmypdeEpOG/Ri9GIBenaU6oe/2PLtLgC4j85jC2lnID3di/lt
	 hN53jLuxd3Y8PtQxFQECiUyRcV+v74plHkrDjD+nHb+ovBaCdRqx3fXPuh0vDd5fqfh0H
	 JJtYhsJWqLksVlD+PiaqghKEc8EdIuJFcAzLo7Ldt/TNdkMrKQqFA57tJITyqtMDaXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138850;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UNYBiOhAD+30znGjPejLZJPRdYr6/sqO+OtQ52jw+6k=;
	b=DXlwspSu1q7XpdLo6zvo71bvu/SF/dWi7OkVy99/wUjIG+1tq6jR889Gfx51a18Zi5fu
	 EHkodZLp0sHTx23FcLETTIFSReI3gm7eLR/1UgEXgQkuBvo0QzWJZw/a3legXvXR5kjUm
	 TlDa8/ZZ2NBhNT4O+u9kKpVkjI+zGDXLAdVfuRBJ5FoRrHsdy7SXqAAATbpqNyDj1bMP3
	 JDHLAEd4TwtZ8+bJCeTOTN5Y3wjHzdiBF+uf83byt38y9nYiFNxQJYmRHh550vh5FR4cs
	 S/PF9muxU48Q3vAGj3lBDK0dsIDYBBoubdXpa2CRytNn7LM6+8GwhUZbKnY8AekPF4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPjsVoOv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EF1606A333;
	Fri, 20 Nov 2026 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPjsVoOv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48EC1F000C6;
	Fri, 20 Nov 2026 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138850;
	bh=UNYBiOhAD+30znGjPejLZJPRdYr6/sqO+OtQ52jw+6k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=mPjsVoOv+gyomx2nkUJ4gfXTECNpfs5wubWv4LBWT7r0aOiMaRqYeG5ZVChyVtO2K
	 bLpyRDUr98Io9WqgybKFqsLehTGnCTwWSPELRLnqacSzqL4Z5NLDlEzTrGl9iATzxh
	 jN4Nh7bMMmbylRorj69iyvun/dpZc95nam8RKhXUnBOnG9x1/udORrrynW+j2WJ9Tf
	 EiTZZCI8I3jWTlFiPonHcW+KngD34tcF6LtLGpxm+6gcw2xEwi2wuhVm3PRhMDrCZq
	 jj9fkEs31b9b01QNqei7QmfcSZZIjZRGbwLYjATdDFDixrc3/gpTtpMuTWjqdXcUcM
	 vxI05YqsG3JCQ==
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/6] [RFT] drm/rockchip: dw_hdmi: Convert to
 dev_clk_get_from_provider()
From: Brian Masney <masneyb@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <313d11bdd1dd46e895e34236191e7a3b175d0382.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <313d11bdd1dd46e895e34236191e7a3b175d0382.1795094688.git.geert+renesas@glider.be>
Date: Thu, 19 Nov 2026 20:40:22 -0500
Message-Id: <179513882273.284394.4331892287524393422.b4-review@b4>
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=479; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=JGsrsWKRl0kw3WUwGSIprP/RenP+nQQZD7u3j9iJt1I=;
 b=kA0DAAoWt9LdJ11+wIcByyZiAGr/pROgWlEsgnn4T7idnP8BIUXK0HiWzQz/5qMUdPDmhjFmD
 Ih1BAAWCgAdFiEEpG0ycFhlqj3e3CkEt9LdJ11+wIcFAmr/pRMACgkQt9LdJ11+wIeTyAEAnOnn
 uWf5C9UfZlObjo+Lo59Bat1yoayzzvNH9NdY1qwBAOswW+07L4AHYLwWodYFTqnZ7ppxIcEV09w
 V46KoATMJ
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

> The Rockchip Designware HDMI driver uses of_clk_get_from_provider() to
> obtain the clock for the HDMI PHY, so the latter shows up as
> "deviceless" in the consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <masneyb@kernel.org>

-- 
Brian Masney <masneyb@kernel.org>
