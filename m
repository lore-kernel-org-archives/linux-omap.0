Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C85B4825A2;
	Thu, 10 Sep 2026 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042976; cv=none; b=NDfopuhmz3Mcli/HSwX36Hl03E0QqsgO2Q7GsKEVeZgrPDd07yu1BzwWPFIjrmoD/06YsnGhSwMD308+PKT5meMXEc7kfhilbU5yLXnYFkgT+RXpUNLhVVh2GX21143X/keXOiQyoBVeRA0rQokTcdCSrm8T8Tpl8Ak5/WEoFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042976; c=relaxed/simple;
	bh=K7ynjK2IUu9X4y7RXzqPisu8TJrTDVPLt41RSUsZ/4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9+vFr1MeSX456bgfn1U5uOTrj5M8ZPMGtHHbu6Z3ZnMQYEzNGeNrYSqMwHEhBlQj3ibcLJm4tsnd2UtQuZV/zahVBDoZpOvU7fPrwvV3QCN9ezwmj8M5TAU9EdKuUFj+oaDDdO5UjfXeooQEqxWN83F7Uz9Kf0/tgNZvzhCVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ztDRjH0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztDRjH0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E651F000FF;
	Thu, 10 Sep 2026 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789042975;
	bh=FLkkYcAm3RJhU2JkWTOmrZqCilyPTV7ci6H6/e+lezI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ztDRjH0JryrNTXyV2KBnMKcW6noto6XB46PidnaorR9Uq8SH3Hqz1NGKl3kQ8RpRm
	 nWaRjstnZPDBjGF0AekJ/ktzmMscGy8Oqg/tbwrJvtX9f2f/gCEHBsXxAXw+x3zAXb
	 LXxO5zXd4tlolC2JEv3+td279uPdkYLqQkMnlKX4=
Date: Thu, 10 Sep 2026 14:22:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pengpeng Hou <hppiscas@163.com>
Cc: Bin Liu <b-liu@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] usb: musb: omap2430: propagate PHY setup errors
Message-ID: <2026091024-pep-enlarging-201e@gregkh>
References: <20260906034149.85550-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906034149.85550-1-hppiscas@163.com>

On Sun, Sep 06, 2026 at 11:41:46AM +0800, Pengpeng Hou wrote:
> The OMAP2430 glue ignores generic PHY initialization and power-on
> failures during initial setup, runtime resume and system resume. The
> callers can therefore access glue registers or publish resumed state
> without a usable PHY.
> 
> Keep the three lifecycle transitions separate so each patch has one
> failure state and one introducing commit. Each power-on failure exits a
> PHY that was initialized by the same transition.
> 
> The issues were found by our static-analysis tool and manually reviewed.

None of these were properly "threaded" and can't be picked up by our
tools.  Please fix that up and resend the full series.

thanks,

greg k-h
