Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466982;
	b=DLu+pqxivKFVNwY2F8Pub7VFeZhY7A38kdcbeo6DX/pgEzLTivRMHzEFLiDoxBhlyMW8
	 1jKWE65IHDulE14Q3nmLsdHiYHN79ro+SA433p5h0JykFUEC9RqB0zhGsi7VV4iF+VyVa
	 AWRkgs322i5DCoAqeZFlakfEuWqGCg+Q+lVKEg9/vcHRlC+6gDQTRySVoMv7o1P0faU+a
	 lgtVIo5Tcwm+qZD8cn73c3G0USTYFVjgYlw3kiGBZ6vgBq57tVNEbMSaR+uVlTxDuMwUz
	 n8w3GoDQ+2qG0HxHhqur+jlZlWf2IfOBV4mBYcOx0isDuDXGVeClDJ7vqT03rCyq0sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=/mBZi5W3sDWHIrgVG5ai7HwJIE30ho6SI0RH0HYnw5g=;
	b=hatdBiIZpfuJBDWIixsElrKmyJk6zyX8tRVnD8ynpc6FJMeIe3+GGeYkWx8qgiegVUy8
	 neCyAPYY2J06Np1QliKMHm1bA9xfaH4H/GQGOLXF1kAcxjT6J0Al4SRB364FFxZMVEjCw
	 FfaGBc98lmFE52gwTPOkI/beKtFagsuqqFnCe412cOnGOU6WdnVUOPlchFj5C9Kb44ymO
	 X09DzJzlsHT9HPuSDZyBUqHsXFrErT3HWxtP7mo+IZonXLbf8Jgn9AMVaSZl25Rl39Py6
	 EvgJ1Vg/ApjEaOnb3GReREKHuw1lqW/iBxe0HuUDt7qgIm3bLNdzFWbQODGtsTCB/DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXkkPmEc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B71606A31A;
	Sat, 31 Oct 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXkkPmEc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B5A1F000C1;
	Sat, 31 Oct 2026 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466981;
	bh=/mBZi5W3sDWHIrgVG5ai7HwJIE30ho6SI0RH0HYnw5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXkkPmEcBzmhUuLw3mxD5Qu20BXyKdtzE2d4WOom2Nzy1s2rcyn4rSNB9kOGrk6El
	 sKJlTtr4cGyfXDFmDgG6X3JRAmxUvAw7UBm4s7As/QDk1ch470V8tWz3SFTZh5vxLl
	 ZBYk7QWc0aIIfGsPp4xwJLaaoJuWnfsYOTERGyBKqSBcus3IiKKpSP2tkYur9X7NQR
	 64vYdKrpbilEaUbmmWBBEu0Lg9IcA4kUAOGOeGt7de55GCqAtjqcqQqIp4qVzwVHh7
	 YGHPFT6VAuHF2h+1oeI3eCUyFred5oVs9wbfCQjg9SU66wwdR3vrmB9z+dDJzz0/se
	 NykGJ583PCqRg==
From: William Breathitt Gray <wbg@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH] counter: ti-ecap-capture: use regmap_assign_bits() for conditional set/clear
Date: Sat, 31 Oct 2026 13:16:09 -0400
Message-ID: <179346694223.3640101.18401240670826689615.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260924083448.461792-1-peng.fan@oss.nxp.com>
References: <20260924083448.461792-1-peng.fan@oss.nxp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=408; i=wbg@kernel.org; h=from:subject:message-id; bh=J4NaL/W2yZsqaCGWyer5oIJrl7TEhysTub4ajAq0dV4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFnPlDwO12YLKeY9dF6RtOzZjfyIpz4uszauNxFUl3gj+ FXZmpGlo5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZhIjwTD//IneSI/hTNeLf30 8K9e1LY/35Mvz5sUM1vw9QXddMuLD44x/JXn/h1xxuWStd9eg5BXez5f4Pa84RM4J/+Qg5XcLKf Qz7wA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Thu, 24 Sep 2026 16:34:47 +0800, Peng Fan (OSS) wrote:
> Replace if/else block using regmap_set_bits()/regmap_clear_bits() with
> the simpler regmap_assign_bits() call.
> 
> 

Applied, thanks!

[1/1] counter: ti-ecap-capture: use regmap_assign_bits() for conditional set/clear
      commit: 6954e1a8996bc35a6e1b65f6028c850490b1d20a

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
