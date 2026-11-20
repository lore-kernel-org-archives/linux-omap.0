Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193820;
	b=ZZr8Em7DpOv7IyKnav81CXxwMOgL8T/7XT6ndtYI8whgNBeCEYidsDTJtiUyvrlAe38F
	 ErkmLGCPvqc3BABStke5Xk54sX83r7ScmVeDIOewg/OMjRhjj5CXusFznahA7dLJV/urj
	 fOQ6z+u0fszvOMu/tWyxGh9SGB6etTqQ5fzvmn+LTFqhIvHRl71KofP/78nvBgaM8ABGX
	 5Z8w7WMH5pp6WZ9VO6FDH0pOZ9/icbDnNa0BB/0ybwBQQ/rZ+T+Ls7d53+Hm5Y+6iR67b
	 OUPBGDsFFYHRdhokJcbbvIZE0cNKgdepIHjLL1uRpVvwacK9IkF5JwacjwRS8ak/AlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193820;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent;
	bh=DJ8cIXCRUOB9I2+njuBlGE2LdGi0WFfh6HrV7BoGga0=;
	b=fgU3qwe5PRLTQGsv87AR67Mi/pV5F++ByEdXfQu1ro/YS1iVsa9FsDS142QrxwLAmMAq
	 4C2OcOv5cSgP/lee8IUXeRWS2VIhDgry7qSET+9ZxGdmmAkh8z+NlJTABMFHH8kVYMIQR
	 RxidA9h39diUO79KtdikHs9pI0k+qycXTdwqwuWTYx0GpblLM6sKjboNrjNmGm1AgustI
	 s0svMTb8TT4tslSg2ZAauOO/tB4egbs7brZ2Qz4Ei6WmeB4wKhFOjSjf+bJxXkHgVcQ13
	 XaR8kxJ7PEUxYGjNhVQtMNjArhYYTP8qE/LsVfV0rO1N8jXcnvV3hKc3HjRh/DnVASw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvjL9tvT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2B60A2602;
	Fri, 20 Nov 2026 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvjL9tvT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536F91F000C6;
	Fri, 20 Nov 2026 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193819;
	bh=DJ8cIXCRUOB9I2+njuBlGE2LdGi0WFfh6HrV7BoGga0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IvjL9tvTQiaHmCAeq33bh7cFtxbf7C0P3W2mb5u/sHTjg5ZZ1TlTASaX589CHUTBE
	 SYhMFA7GBcFTiBF20NyZfjJPAWMj+S0i8HfaMniF3IF2WrIfG39DkDkl+w4Sc8ZSJl
	 rl25wzQXY04GQrpJ5sIp1JoOy4BarvUDAgeh2SV0OI4PtT/XqTzTcCFVSs5n0Gp702
	 WcMHxkybAkagD/kGHlIKYRRGjjQmpBseVg1sWbGRqUN3sw7wkBD+EhCrxFCrBOLCX1
	 +pLkiqN1sUQPvCj1nzfaOGFY7AsjZCp5JUOyeollaCp+tKvu0tI8pBJ/5/r8oB7XOb
	 U7IUN3yMvsNyg==
Date: Fri, 20 Nov 2026 11:56:53 -0500
From: Brian Masney <masneyb@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>,
	linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
Message-ID: <awB71ckHyTRIfy0p@x1g10>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
 <179513882271.284394.17357508909448455391.b4-review@b4>
 <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
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
In-Reply-To: <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)

On Fri, Nov 20, 2026 at 08:44:29AM +0100, Geert Uytterhoeven wrote:
> On Fri, 20 Nov 2026 at 02:40, Brian Masney <masneyb@kernel.org> wrote:
> > > This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> > > about consumer devices").
> > >
> > > This commit added a struct device pointer member to struct clk and a
> > > parameter to clk_hw_create_clk(), but the new member was never used
> > > beyond setting.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/drivers/clk/clk.h
> > > +++ b/drivers/clk/clk.h
> > > @@ -5,8 +5,6 @@
> > >   */
> > >
> > >  struct clk_hw;
> > > -struct device;
> > > -struct of_phandle_args;
> >
> > Did you mean to remove of_phandle_args?
> 
> Yes, it was added by efa850487a6b6742, too (although it was
> used in that header file before). Currently it's not used.

OK, I see that.

Reviewed-by: Brian Masney <masneyb@kernel.org>

