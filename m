Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291363;
	b=bhlzUz/HxwcT6Vvoaf/T7uuotAxfk+Z05L9BByNg10IG0KIzfq5d4c6if2noPUsmR4jM
	 AfDUTt++Hiovaf84DF6qpNqZB6pR17mUtvU/su/zdwlSjd/8/FBNJCVX39UqQwsrvr+Ih
	 ODDQQNmEMiK87Bl2QnOwSdin00AlPLsOWoHYC9MAvu/g8243mvzjWPjq226WcfxVKYe/o
	 CBTB/fgyVeiXzBU88U6Rg/j4khS//i0mn1rYh4+oEGMKfE36VzVUW/hGP0bBkuU5Cmgvs
	 9xSqwyeIlQ3irbCDuovYTl+TmfG6rrbIbFj7qZzrW9UXpPNnsxMLAX6m5UKfCHGEm8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291363;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q4Xohw5mmf9HaJmwh1HyXHKVuyq9JIpdGzwAqa+LDzE=;
	b=uJ1m8t/jqSgilQeE1W32MjRCJvS7sM3dp8JPPFF4i/yLXJVHjfuJjSPVnbpJCrUMC/8B
	 pIv45ZbqtDKh1kg+mrjr5AwDsVOK+wHQ+d9qXuLXW9ABnbzVUt8pNpZlY+poyZ1ARrUPI
	 pnNujldFvcdNUByDe5Ctg0qnaKN1xi5b0FMNGPAZDpZMQDxxfX8LsAKpc3JzfCRWyBwIM
	 j1ADYWJ+4Ok8XwjEt9e/IJ4+AiSSSHz+ciexuMO0ObyBRQHdDVNycafysnxpweFfrK3Qn
	 LMChUNuJdft11Ij2sFEJa3spShgIHCjtPnqnPq/61xOY2ifI2mRDa5SeIhc09MhMhPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=Ly5kvd7j;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10822606A31C;
	Tue, 10 Nov 2026 06:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10822606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=Ly5kvd7j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=Q4Xohw5mmf9HaJmwh1HyXHKVuyq9JIpdGzwAqa+LDzE=; t=1794291362; x=1795500962; 
	b=Ly5kvd7jmot6mdtBNX7gwckb297IdzU5FVESuMnvRTlH4slalkSLg6NlmptnqzChbhScMAuZONK
	JcSmTF4/0z2ryrFIoHwPxykHSk1Y0I1zlC81wAL0JIfKzEUJjdXBiLF8me/OKHJsEq2vWdcXRUC35
	ggrkHPSelaoVlxntcKosSiU2NW2MErMaUQlTfZ9bsAoTbH7l88i2FlXFpCtlVexnkAuc83gOqfF6h
	EBxtXm0NDawJaIcE+8SxZ6/qqvCbrtAGG4Wcmjr8RZhFatt/lZq+ivw3nMl4zssO4NbDiGRcNKPA5
	ZiGpq7R7wCw8eHKOOchZ2qo2VTXxoLBlm07A==;
Date: Tue, 10 Nov 2026 07:15:38 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Christopher
 Obbard <chris.obbard@oss.qualcomm.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Paul Walmsley <paul@pwsan.com>, Russell King
 <linux@armlinux.org.uk>, Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/9] ARM: dts: omap: dm816x: fixes and peripheral
 updates for DM8168 SoC
Message-ID: <20261110071538.69f9cc54@kemnade.info>
In-Reply-To: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
References: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Nov 2026 20:52:46 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> This patch series collects several fixes and peripheral enhancements for TI
> DM816x SoCs and the DM8168-EVM board:
> 
> - Pinctrl: add correct pullup/down enable defines for DM816X SoCs, which
>   they appear to be inverted respect to OMAP2/3.
> - SD: explicit pullup disable in DM8168-EVM SD card pinmuxing.
> - Storage (MMC): Update MMC node settings, dropped mmc1 hwmod.
> - USB: Update MUSB node, enable multipoint mode, dropped usb-otg hwmod.
> 
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
> Without upcoming Andreas's patch (not yet on the list) that silences the
> WARN() for the missing hwmod from DT, commits in between the hwmod DT
> and the code removal will get a harmless WARN() during boot.
> 
The patch is applied now.

Regards,
Andreas
