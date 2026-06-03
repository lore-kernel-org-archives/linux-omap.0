Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318963E16B0;
	Wed,  3 Jun 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503045; cv=none; b=QQXNr9B/8HgeS1aDNEa/D4KgnPoUpaXaxX+snrja8AwzTqjVBqGDOUp1fvIpCwTJ4EP9e7iP4TS7Zt07xU3Cfvm5K+DfE+wKkonAb891LdJq3gm+hZRJ0wPLXDGDO6vT97I+fzkFWhYMbZRYnJj9CmaxtE7PvVUDBDwohhKdxPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503045; c=relaxed/simple;
	bh=LmyBxm+sQtwIQ2mXoo+xzE30jg9pR4UPA0NQ+oP1+mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZsRUSbRn9gs30dsyXSsFcLyRlr/rfLlyZtbPmpv6z4llAA8s/BTsjqTBMweN9VxaYHfY8M1cDx9co9gTrHEkR/NKyg/y9dxDTJA9EuxfVOJVpJI1xdqEq3uSJOpkzP/gy2gUYvm/GnuQCL4K1RV746tYc2U33ZGHJXiWgKX2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rV5Nt2r9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rV5Nt2r9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PxtxjKNoYgUPQsMQmTzU6SuGaoU5BES3zxRcOY+fRfc=; b=rV5Nt2r9TkPzhzSTWHKkkLeH2o
	RVJNVdXyRXIRJfGiAAp4SQwwA7QR0r7lYys/ExD7RA+nhEP4eZ7592JQiDBKZQUoF6/92/0PdQ6c2
	4KOenNGj3ilJLUEIRRP+4RHzDAVsQRvnDV/FPhyYQy5zYdS0TXSf17vkvNjnl4KzucE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUoAp-005uRJ-Eo; Wed, 03 Jun 2026 18:10:31 +0200
Date: Wed, 3 Jun 2026 18:10:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-omap@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cpsw_new: unregister devlink on port registration
 failure
Message-ID: <b02f66eb-8b5b-461c-b990-30e6a5ceca56@lunn.ch>
References: <20260603140742.1398659-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603140742.1398659-1-lgs201920130244@gmail.com>

On Wed, Jun 03, 2026 at 10:07:42PM +0800, Guangshuo Li wrote:
> cpsw_probe() registers devlink before registering the CPSW ports.
> 
> If cpsw_register_ports() fails, the error path only unregisters the
> notifiers and then releases the lower level resources. It does not undo
> the successful cpsw_register_devlink() call, leaving the devlink instance
> and its parameters registered after probe has failed.
> 
> Add a devlink cleanup label for the path where devlink registration has
> already succeeded, and use it when port registration fails.
> 
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please set the subject line correctly.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Does this bother people? If not, net-next, and no Fixes tag please.


    Andrew

---
pw-bot: cr
