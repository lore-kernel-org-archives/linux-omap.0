Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67BE4BB7E3;
	Thu,  3 Sep 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446330; cv=none; b=AlxWFRm5Pb8nX/C2WsTubVPfh761aDDsFo0KoxQ5Kpo+mKkvX2oTPvUsiTPQlsuNZejTHRNP9QlFNNSfAuO2+LSD7bj8mnXQbIrnbIrFcD7HyC/xGW2xt1iB5bTGr3xJtxR9+SM9kJ535KxFxwxC2nlVkBAHiDp+2R+BEwqqSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446330; c=relaxed/simple;
	bh=2Xwe84FlK6+KI9E68zHSaOUN8u+WtQAdk4H8FVqgUoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGsv2H+HCN1h1c6OY3xn7QBLXsrw5MNIJ5wxjacjwVv36NxoBXGQe2+zxMIfrHtdVS2PNFR61IlQlpyB5vrRC8QqxIZRgkmpeY1yc0oQyO/Gyw2ISD2bm+pw12lph9aGyqA+6m2YVuAll3OdIn4t7DLcgGBhAgztOD4PA1RmcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=47lpu5L+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="47lpu5L+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u6J1biGYMDl1Rlglc6SgE1ekvM8cxjB5ln1otwwvfJg=; b=47lpu5L+kW/5J7MjjL6lHk36pU
	ZbfSNQVXoOzufimCXyYhmzTGsRe2bv8ZrMe2Pz+Q/RI0Kv+nuwuArTZy67PeZj6+eYHxB6A+3CuSt
	iQVW1DBchkSbMDmZcluS7RUAIm+ADi69bZFXjnZ1WktnOXm4MKVJiY1PwEPRzmELJvQ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x28aJ-002k7o-GU; Thu, 03 Sep 2026 16:38:35 +0200
Date: Thu, 3 Sep 2026 16:38:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: davinci_mdio: Drop commas after match
 table sentinels
Message-ID: <abec6831-d344-489d-b70c-1e5dd4d43c2d@lunn.ch>
References: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>

On Thu, Sep 03, 2026 at 02:06:47PM +0200, Geert Uytterhoeven wrote:
> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

net-next.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
