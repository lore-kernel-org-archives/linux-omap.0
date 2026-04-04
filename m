Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829E2BF3F3;
	Sat,  4 Apr 2026 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775293867; cv=none; b=hBBRFfad+YYFtIAdPPlnS+yLtYnFTiaOqEquCqAUI0hxOzkdDq5yy79WsXRvHP2DuvreAqo15QRpF/MiTRDlKql+xxl0eXpdfwZJz6YzzpW8lDHzkl7pnJYGZvpyqazuylJlUt0LtbrpB/hGQUTqLmDYp/BKZZk5BuZj/L/GCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775293867; c=relaxed/simple;
	bh=D6I9c5mIBu3BvZ3459/JAGOxm0o8EKD73fxMvQ9jte0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou5IuqcWWtZiht+EV65r0H/SI2f5Y0LczTfU0nbmqzC2d8CC1QR4Iul1a6ZML1sf5EYrGS5esRbs1HFjZkZbtOmhXwhlS0gYpXbn5aEvyEL1a6z0CW9dELkQ4N6PKbMaI8yU8ziCwHZhfzyX/U33YPy5jSwhM1yF/+Vt+SdCe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGAKPvBp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGAKPvBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F895C19421;
	Sat,  4 Apr 2026 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775293866;
	bh=D6I9c5mIBu3BvZ3459/JAGOxm0o8EKD73fxMvQ9jte0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGAKPvBpmOKG98wQ56WG9mMhBjhGkm5cTzeBlW8pC0NN/4koD54K8oaaDbX57b2ey
	 nefi5QdEi5/CqXQJhdZQIpFYudhD99FNoFRudJRmAcQtgLmCqMdFONNjiopx7B/Jdb
	 PsjxfhTS80Wwc4c6mGQBs75ycWCzcCiN8+KCpePRen7hOSP2R5IBH+31xbuS8LlY9i
	 ltMWawmFoJ1uvJt/xC9mDZ99vksVb/7PMobLraixUcx9XObyNtnngJnMF4gt4JqrfW
	 3z53h9hPD4EJUNbPH5cwSpOpq19xOxCUh8JEuaH2WgHDlHu56EvGTXaJkJJlf33ynp
	 puf1V6E287SGQ==
Date: Sat, 4 Apr 2026 10:11:00 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>, Netdev <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	Kevin Hao <haokexin@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [v4, net-next] net: ethernet: ti-cpsw:: rename
 soft_reset() function
Message-ID: <20260404091100.GT113102@horms.kernel.org>
References: <20260402184726.3746487-1-arnd@kernel.org>
 <CAC_iWj+vjZ0WnKUuqeFfaPeSoj5ovxZiEmUD5R8hPsRfkqMihQ@mail.gmail.com>
 <4498f664-15ca-4859-a050-a593f124105f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4498f664-15ca-4859-a050-a593f124105f@app.fastmail.com>

On Thu, Apr 02, 2026 at 09:16:29PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 2, 2026, at 21:13, Ilias Apalodimas wrote:
> > Hi Arnd,
> >
> > On Thu, 2 Apr 2026 at 21:47, Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> While looking at the glob symbols shared between the cpsw drivers,
> >> I noticed that soft_reset() is the only one that is missing a proper
> >> namespace prefix, and will pollute the kernel namespace, so rename
> >> it to be consistent with the other symbols.
> >>
> >> Fixes: c5013ac1dd0e1 ("net: ethernet: ti: cpsw: move set of common functions in cpsw_priv")
> >
> > The patch seems fine, but why the Fixes: tag?
> 
> Before the c5013ac1dd0e1 commit, this was a 'static inline' function,
> which is allowed to clash with other identifiers. Making it a global
> symbol during the move was a problem.

Hi Arnd,

If we are going to treat this as a fix then probably it should be separated
from the rest of the patchset and routed via net. With the rump patchset
re-submitted to net-next once dependencies are in place.
