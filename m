Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A7EED8;
	Tue,  7 Apr 2026 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527502; cv=none; b=fYo86cN88LtP6uDgHGdergqvyMn5tsPJBcThRQwwQ27+qQADtbO6jQFBH310BC6qoRiKSk0pHig7hN2Bfbqgj9zvZ/UlEgW1wvfcbQ4jKUSsMbnaqmB2AJr2xv3RnwunscSya+ksajN78DVmp5DSIhwS9MrwrlXwhDYGVd1/7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527502; c=relaxed/simple;
	bh=QAbPk6VWnQg1ID0bqbSVaZJqWzuhr7oU3u8vHAFVY3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4TuzMB5xbBjkYUt9lpPbt9LNHuHXd1gWymTHprQg4FaNLMRRa6VOgeMMv+uNYZb1OkYJXQ2DAcOC+O0z889cIRelKNdYJAAlry/SCett5wbsqa8P59H2A3VmCe/wZnby1ufih2VOqZq6g10Tx+yGt7GocmIgUwpMl9ob+uFxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5bqUeVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5bqUeVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9A5C4CEF7;
	Tue,  7 Apr 2026 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527502;
	bh=QAbPk6VWnQg1ID0bqbSVaZJqWzuhr7oU3u8vHAFVY3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V5bqUeVK7FEQTESf6if9UYiMQOfsqbgiDnPbwEKGzpMZztP8UvkT0gfb0tloi4KcB
	 7nC1HYLzApKHl+RGixxl+vnK0N1fhxt+sF4aVRh6/ViApMBp5hs3KopqPRn+epXKoL
	 zIAEONunhGo8J2YGpkZos6Ea1be0bTqcXNLpL7QdYssWc/C/FnGs0DZR2E+GPyF090
	 cvv60+P/p2RHJHRe9hiLJwrkDzNAgfbN66bPhUDtOH+ojF2fQFwggEunHxCpJ5cwpS
	 Sa6nEtUXsAYXym3O7zFCJH2aOTm2zxDrSpQ124xkuPcOfDJd1lw7XTATws4j5eYmtv
	 aZkjZVOMMeKYw==
Date: Mon, 6 Apr 2026 19:05:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Simon Horman" <horms@kernel.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Arnd Bergmann" <arnd@kernel.org>, Netdev
 <netdev@vger.kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Grygorii Strashko" <grygorii.strashko@ti.com>,
 "Murali Karicheri" <m-karicheri2@ti.com>, "Siddharth Vadapalli"
 <s-vadapalli@ti.com>, "Roger Quadros" <rogerq@kernel.org>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, "Alexander Sverdlin"
 <alexander.sverdlin@gmail.com>, "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, "Kevin Hao" <haokexin@gmail.com>,
 "Daniel Zahka" <daniel.zahka@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [v4, net-next] net: ethernet: ti-cpsw:: rename
 soft_reset() function
Message-ID: <20260406190500.21c4ec2d@kernel.org>
In-Reply-To: <64384fd1-edb3-4c7a-9ba8-56385a303d35@app.fastmail.com>
References: <20260402184726.3746487-1-arnd@kernel.org>
	<CAC_iWj+vjZ0WnKUuqeFfaPeSoj5ovxZiEmUD5R8hPsRfkqMihQ@mail.gmail.com>
	<4498f664-15ca-4859-a050-a593f124105f@app.fastmail.com>
	<20260404091100.GT113102@horms.kernel.org>
	<64384fd1-edb3-4c7a-9ba8-56385a303d35@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Apr 2026 21:31:28 +0200 Arnd Bergmann wrote:
> On Sat, Apr 4, 2026, at 11:11, Simon Horman wrote:
> > On Thu, Apr 02, 2026 at 09:16:29PM +0200, Arnd Bergmann wrote:  
> >> On Thu, Apr 2, 2026, at 21:13, Ilias Apalodimas wrote:
> >> 
> >> Before the c5013ac1dd0e1 commit, this was a 'static inline' function,
> >> which is allowed to clash with other identifiers. Making it a global
> >> symbol during the move was a problem.  
> >
> > If we are going to treat this as a fix then probably it should be separated
> > from the rest of the patchset and routed via net. With the rump patchset
> > re-submitted to net-next once dependencies are in place.  
> 
> I'll drop patch 1 then and send the other two when I get the next
> regression with duplicate objects in a couple of releases. I'm
> travelling at the moment and won't have time to rebase and test
> before the merge window.
> 
> It's no longer urgent since both cpsw and dpaa2 have been broken for
> years now since I first reported the regression.

Seems borderline, let me take it via net-next without the Fixes tag.
