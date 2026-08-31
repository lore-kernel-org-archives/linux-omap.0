Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6375964E8;
	Mon, 31 Aug 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184281; cv=none; b=MdTrWIQzyPXDWe1ccDNJLvi5TpL0On2CIKGi2sBJjuy6esY26d5le4DGzu3UzHo7RTtYgUG8IFbqXIVFbtVBLE8MOIUoehmAqpqMfVFZ8VX9jn5bWRudxYrB2ApXhpJDLRFr8WkpFJ8Mw9w1kyNeo9g9EvUbgKJeX04tQuqP0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184281; c=relaxed/simple;
	bh=Ub2uZI5lGKBA04VlT1aSOlv+CWYnJ9OL7FpPIElIVz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo1FwTI49vitUquZJifXVSjDdLLxSAQlO6mJ3HOLnI7ZhQSCswYbmMtzB6SmJ2JDMRJtw8+culRc49RMM9nKHPJdvETkZQeDey9qvnZnqkTVr9g9130R0FSWIgRV398dz8zu+MW92hhCoQc9hEMoPbv0UsSWR5DfKLZPqMfD0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOANNUDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOANNUDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25CB1F00A3E;
	Mon, 31 Aug 2026 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184279;
	bh=y4IRaCf20yPxkwDQVxSHxKx3Orf5PlsmI9OWlWAa9Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KOANNUDFBJ+uHPZf8IJcY+JYButcvHpUnztsqXR3sadF7hHLw8ka2ATpDvwzOFdb4
	 E4JCsc/mmSuyWNQZL339gkUNNdQbc9V4uK2fytnkwXkAx5KfhhADGhYYC5AdYXSX4/
	 nEwzFgttL5956vWjSTO8aOh/wil4qwLUb0ze3P5jBwTu+f+Zc1slRKj31DRJ03XG4g
	 YIQLKrraPrB99cMmoP6MppRTJJWLDAjHuj0ZFYCapEDcyKG5bV6lB6Q555uo3RKet9
	 nUxmyl/BW5Jt/OGuUW1LmZgldY2kdU8VWLbSkzy/OrgZy/dlsZOy7mVwoLA9dHmzIn
	 chQFWVKWQw+cg==
Date: Mon, 31 Aug 2026 08:51:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Frank Li <Frank.Li@kernel.org>,
	simona.toaca@nxp.com, linux-phy@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-kernel@vger.kernel.org, Kumar Gupta <ajay.gupta@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, m-chawdhry@ti.com,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Siewior <bigeasy@linutronix.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, daniel.baluta@gmail.com,
	Ravi B <ravibabu@ti.com>, goledhruva@gmail.com,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 4/7] dt-bindings: usb: ti,musb-am33xx: Convert to DT
 schema
Message-ID: <178818427788.762177.6804931155762512398.robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260818-ti-am33-usb-v2-4-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-am33-usb-v2-4-66fd44d66824@gmail.com>


On Tue, 18 Aug 2026 19:58:46 +0530, Bhargav Joshi wrote:
> Convert the TI AM33xx MUSB text bindings to DT schema.
> Changes during conversion:
> - Allow an optional vbus interrupt used in am335x-bone-common.
> - Add the interface-type and phy-names properties natively used by the
>   dm816x hardware.
> - Allow 0 or 1 for mentor,multipoint. While the text binding mandated 1,
>   the Mentor USB IP natively supports both single and multipoint
>   configurations as used in existing DTS.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/usb/am33xx-usb.txt         |  25 -----
>  .../devicetree/bindings/usb/ti,musb-am33xx.yaml    | 113 +++++++++++++++++++++
>  2 files changed, 113 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

