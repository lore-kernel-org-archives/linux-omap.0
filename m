Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168428;
	b=z9qoQj6g7NwqAQWrDiX3PYYSKG6fxVYOuLpl8f72sZAC2QUg4OO1u2Qj5bqRM+JCvgO2
	 EMTW18y5pIUYS2L6Gfftadb5hkHFiJPYBI29xb8If1BapcqAZxsfanHh7JoDtok7qRTrw
	 5vBnqzahodhGsY+HJ9GgUwrIgcvh1UaJ6oTzDeg1EnGHkk632U8TZnozvrJUKfyNQnrdw
	 mxmguf3Rif+PSZSJdyTcbEES882Uacg+ts2fx5EQaoSAYGBX3tBvQBG8M/iD0X2v63Nkl
	 P0q+44/xHUJDTFnLCUH7qOS0gb6R5/i3zUG9uB5Pr+aCHeKe9OiTAX9tg1J0H8vXvrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168428;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/XR8mwGEvCfQ40OFBdbL3peozsc+De8DLZuvdd7EMf8=;
	b=D91ZM3nOym16JgIsA5LLJr15kOkfDsLbLqVmHLRSzCbCJ7bExACA87QMlR6xyRGfsBnj
	 47hJqb7S+oBeOUP+yFisURMaBNhQZjtMAaC8G+L1kQeMB+5ReV6/phuVbxD9qBBDfPr/p
	 p+wb3GZasoLg999QlSYepVN75cEe/K+3sTaTv/7Cjc/jzruFZTAz1IDZcGdP/E0aasxSg
	 brqZVa/Rxgm8MyYrH5QGzFn/bOsM3rQzDLBiGSQa7jNiIDWR1+hT1AwcOPBFFmlw/Y70B
	 lg43aL1HrP9+X9JpB4SS14BmCdUCJZeLX5TXlJ673L52hVrD1dF2uwsR1GoVuWpivGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="WOL/eJqo";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A1606A325;
	Fri, 20 Nov 2026 09:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E2A1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=WOL/eJqo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=/XR8mwGEvCfQ40OFBdbL3peozsc+De8DLZuvdd7EMf8=; t=1795168428; x=1796378028; 
	b=WOL/eJqoafpkqrk9LTmg8BvwsMvWf6PrUrKTT1LogTVW2ibHXFlvMt0TjJNvs1V64+xJx0nPo4W
	ZJyiDWIH7k9mDDzP+vzWU2DHeX1+TBihburZ3M0IvpE4BHB4BfZGRB/bzCBTP2O4TbuARZzTCUagR
	kfdm9iNZZgXWC2KIA+bPVz6Ujflr9KieElngI1kcGvMRpQRP+UUAMMFGZ7ZL8BrTMCRRiTAPqZfgs
	zkkj+6dPXTB3MXoZdH+YaYIWLOnxrqYeyYgSQHGOGwkHEJfAXBJWLeLMqdrpuUaZFudMjlYEv5mgW
	zll7PKlrpVhvc44hviHWqJhlsyn2esUJiRKg==;
Date: Fri, 20 Nov 2026 10:53:14 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ettore.chimenti@linaro.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin
 Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Paul
 Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy
 Huang <hjc@rock-chips.com>, Heiko =?UTF-8?B?U3TDvGJuZXI=?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Ulf Hansson
 <ulfh@kernel.org>, linux-clk@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to
 dev_clk_get_from_provider()
Message-ID: <20261120105314.57a13a83@kemnade.info>
In-Reply-To: <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
References: <cover.1795094688.git.geert+renesas@glider.be>
	<683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
	<20261119225017.15a7b5cc@kemnade.info>
	<CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
	<20261120094320.442d064b@kemnade.info>
	<CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
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

On Fri, 20 Nov 2026 09:49:39 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andreas,
> 
> On Fri, 20 Nov 2026 at 09:44, Andreas Kemnade <andreas@kemnade.info> wrote:
> > On Fri, 20 Nov 2026 08:49:05 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> > > On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrote:  
> > > > On Thu, 19 Nov 2026 14:40:38 +0100
> > > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > > >  
> > > > > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > > > > used for power management, so the latter show up as "deviceless" in the
> > > > > consumer column of the clk_summary file in debugfs.
> > > > >
> > > > > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > > > > the consumer device, too.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > ---
> > > > > Compile-tested only.
> > > > >
> > > > > The first change is probably OK.  The second change may fail if anything
> > > > > in the oh->od->pdev->dev chain is not available yet at this point.  
> > > >
> > > > Test on OMAP3:  
> > >
> > > Thanks for testing!
> > >  
> > > > --- clk-old     2026-11-19 22:44:59.810807920 +0100
> > > > +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> > > > @@ -1,17 +1,17 @@
> > > >                                   enable  prepare  protect                                duty  hardware                            connection
> > > >     clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
> > > >  ---------------------------------------------------------------------------------------------------------------------------------------------
> > > > - oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider
> > > > + oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
> > > >                                                                                                             deviceless                      no_connection_id  
> 
>                                 deviceless
> mcbsp_clks
> > >
> > > Hmm, so the passed device is always NULL, and thus there is no point
> > > in making the change.
> > > Do you know if these come from the first or second change in my patch
> > > (I guess the second)?
> > >  
> > From the first change, The second piece is nowadys only used by the dm81*
> > devices.  
> 
> Interesting.  So that means all/some of the existing use of
> &od->pdev->dev in _add_clkdev() is futile, as it may be NULL?
> 
I was wrong, it comes from neither. So lets start ftrace via cmdline...
ftrace=function ftrace_filter=dev_clk_get_from_provider

Piping the result through uniq -c 
      8           <idle>-0       [000] d....     0.000000: dev_clk_get_from_provider <-ti_dt_clocks_register
     66           <idle>-0       [000] d....     0.000000: dev_clk_get_from_provider <-ti_clk_add_aliases
      1           <idle>-0       [000] d....     0.004913: dev_clk_get_from_provider <-of_clk_set_defaults
      1           <idle>-0       [000] d....     0.004974: dev_clk_get_from_provider <-of_clk_set_defaults


Regards,
Andreas


