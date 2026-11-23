Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472819;
	b=LE/XLoQtdGUfzgZq+ms1vGiCfoqnDYxSrGKZpUlr88Eh8XGwgLZqF5VJTI4pdd4zklmE
	 ybaHm7+B4tnXbmwYkav5Jw7ReAwUsLOm64NaxqBUeiEwL93q9HfTBB3gDyqJTEtxL5bDH
	 nD2wGFqygA6R4aIII3z/H2LP0wXrisVAJNkBHbddiAL6xDyFzmiUk7y1gVB7XzkkMqp01
	 jg3jvEaWR985pJmUHG4uwf92IpRinmwlP+gAULxUKjdRsv+hcz9PeUY6TCjMGxQqpsA2f
	 MsMR1txN3Yyq3x8j7f2KYS3NZy08JnqHB6BC6dQ6WJ4HdSGZxEN7b8/NMcCOe9W6Czg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472819;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yYD5vZBdnkFtnUsJ6D8rbr9QKv09GjSrmbmfhpJgdAs=;
	b=pnLRyC+r4X6OnMmd4DljqzR1hBTnw/yZsjg+quO5whjp1lCmjqCeWevT8cGy2xhChZxG
	 wxZduRN05qrL+okRSI9RYglpDS7KEaIc/urC6vIvQkSzF18ptKDOFPZ9OB5xFIvyhvEbQ
	 8dBIqhHBERV92hL+ilHTIvTxkZ7A1a1fFLJZNDgluo1YSarJ5F4ST//5+QFzR+KqK3CBJ
	 hy8XGXp745QNVlg0LYFPgN0Zat4Pai+3qOYjCE1spWKypzePVp8lMvt33Iypu1PhpMo8o
	 dl2RXEUn4bNGC52nJqMVi1h/QikpXI2rbeyiIrpDbGJG6Nx7Lcw4+G5JjHvnBUIqAug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9R06Iht;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C8606A332;
	Mon, 23 Nov 2026 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9R06Iht
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31CE1F000CA;
	Mon, 23 Nov 2026 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795472819;
	bh=yYD5vZBdnkFtnUsJ6D8rbr9QKv09GjSrmbmfhpJgdAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q9R06IhtsuQiCDcfXLA76ThniV+03fiA5vFBcWrHH4yVDSdtp+HXHCSKoBqMXfwQU
	 btOLOtabBXNbseUBje7KPsBlzOzN3tUjmPrwPGR8TqgXI/khlEQfCpnVSAgTy2ZeUs
	 pFtsks7RftbWpnaIA6iDYUCyRrDrtUQZmzUMxLpLeHBcA3b6E1uDdUr4j/aYVDzu8o
	 qRjk38WKdd6V5hAmspUEx5oo4SbD39zK/zbJb9+bgflt6ruMTr7TFp70suKteeTbTk
	 qIDUUvrr9T/oiAjh6meFEyf8yKBH+pgJMIMguuRc3F6zB/SKXz0soJD4GT5ZNH/mN4
	 Ix3m3RYTe9p/g==
Date: Mon, 23 Nov 2026 16:26:56 -0600
From: Rob Herring <robh@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: vigneshr@ti.com, andi.shyti@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, aaro.koskinen@iki.fi, andreas@kemnade.info,
	khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com,
	jmkrzyszt@gmail.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org,
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Message-ID: <20261123222656.GA3008799-robh@kernel.org>
References: <20261120185915.150228-1-apokusinski01@gmail.com>
 <20261120185915.150228-2-apokusinski01@gmail.com>
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
In-Reply-To: <20261120185915.150228-2-apokusinski01@gmail.com>

On Fri, Nov 20, 2026 at 07:59:11PM +0100, Antoni Pokusinski wrote:
> Document the TX and RX DMA request channels featured
> by the OMAP I2C controller.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Missing Krzysztof's ack
