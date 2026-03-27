Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF546391516;
	Fri, 27 Mar 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620322; cv=pass; b=IA64cVJNC7geGB2zqQLk5Gfz0/HgB/90uw1Hjz7XXS1mf7gS5sQpiO9MJwIuUrSM+ht0M81zd5mCCErEHj4yUKoVJe3fC01S9q8gxUU/8HG+6XTw1Cx3jyK9Pauilq5J3oXCCISiZW90w7OGWWPiE3IDM5htUuDSHzraxZQ1DvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620322; c=relaxed/simple;
	bh=LDW9ttjB3G8IFcmk08SYxamlEEgze56whSHpri4sMew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3mejfCoTwcS9KFG5AjOhfPt0aInT3tMOG9C376oRrnQQ5otoTO80Cq1PzGMVcQLXP4qQ+cZxjojbZu4UevGIwW/Zz48n/eTvQz+UMZ9qVOtwcYZd76Zb5mQ9nLn/o/VsPzhCPpDam90KTCTTa+i+jJb/HAw+9Mu0/HLRr7Dg2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mza3c35K; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mza3c35K"
Received: from darkstar.musicnaut.iki.fi (85-76-0-165-nat.elisa-mobile.fi [85.76.0.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fj2Tf2bXjz49PtJ;
	Fri, 27 Mar 2026 16:05:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774620311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xtu2xKU24myRwQOk9cD2GRQKYnMGvF6fQQgu2QdaIVo=;
	b=mza3c35Kmh+arZTcuM8M7dyjpYU+J4QtKVF7egPoeX584oYLBmaVOmJdh9mF7aO76FO522
	DoWBboy3qVOuO8u+vVnt1fgOtZXOizqeJKKxWdUq8b0U1TsGqC7XlinELtBNOraSxk7/kw
	/MNmwdNY6kZpfn64bbVMvS56foElvusEtf5QO7DEpFFM3lgoiyxHOk67ThXGORpJPuY3vR
	HQeYvhGpL+0yIp7h9qcRsGkhON81Zb/E2vdlRE1nOrLCgkB7s7jx+4IvfkhzLPfFhuTCJs
	yihinluu5OSsQk63s9tTEQ6sG7xlePx3hABKOR6hvKB0eg+N6KMo97vs5NGIOg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774620311;
	b=YM9iDk2dbFZCuGBcj10XBwYndUhXYqthGRKA1GZDwgbh7Mij3gYseCYAiwCOV8iWAaL6bd
	CpS77D2MIW0pA4iDtxTtm/C0io0Fy3tKySDftyV2ELZR2hKnpbzN45RBPOM6E0d3jHy1uh
	iGl0eqaVqoNeyS1eMFo+X9tC+NrbvZoRlt4Ik47aG4CKmgZ2VeO4lCOTitGTbx2QeEyUGw
	lKC5z2/1FrP3PuapT5KtVprfW0gB4Z9t2wSgJzg2L7n8f38836XAaLTWVQ2DyJEaeYjLqO
	a5FNafQPCNT+FB2Wgq+CyGBOcP1JnyI8MLEKtICSYglSWOQTtZLIRFAxf+y5Rg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1774620311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xtu2xKU24myRwQOk9cD2GRQKYnMGvF6fQQgu2QdaIVo=;
	b=IyWlVDjPWa1NvUpyWqmDQMeZy1hyYx0X8VEU2DGo/x/rdEfM8oyjQgLqlx62LrLnI8gB8t
	dCAIkh0G5B3/JufzHK4G3J6ngmtgNVw95p/gnjI11sMzHbNGtvVVCQUn2OQej5Fax/aW26
	92dHDzMI5w66A0cf7+9QhCcbcdJvOCAUQCxomR4HZVKT/n/bTDTAdSRdMthDoe/atoYSzY
	WMCtzpwyEdOLCi4d/MshN4kEuzDkB10PdM9BBf3ce8UgtGcj/c4Fw6C97vgJ0F5h2kUlP0
	scQSWBDV9aBtd0v08WPJhUjK898QgoxHgJQSW/SmsBbrTX3CVDoz94wiKzuaqg==
Date: Fri, 27 Mar 2026 16:05:08 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi>
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
 <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com>
 <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>

Hi,

On Thu, Mar 26, 2026 at 09:57:31AM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 16, 2026 at 9:50 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
> > On Fri, Mar 6, 2026 at 1:31 AM Kevin Hilman <khilman@kernel.org> wrote:
> > > Bartosz Golaszewski <brgl@kernel.org> writes:
> > > > On Thu, Feb 12, 2026 at 12:46 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > >> On Thu, Feb 12, 2026, at 12:25, Bartosz Golaszewski wrote:
> > > >> > Currently the board file for Nokia 770 creates dummy software nodes not
> > > >> > attached in any way to the actual GPIO controller devices and uses the
> > > >> > fact that GPIOLIB matching swnode's name to the GPIO chip's label during
> > > >> > software node lookup. This behavior is wrong and we want to remove it.
> > > >> > To that end, we need to first convert all existing users to creating
> > > >> > actual fwnode links.
> > > >> >
> > > >> > Create real software nodes for GPIO controllers on OMAP16xx and
> > > >> > reference them from the software nodes in the nokia board file.
> > > >> >
> > > >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > > >>
> > > >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Aaro, Janusz: Can you please pick it up for v7.1?
> > >
> > > I can take this via the OMAP tree once I have confirmation from
> > > Aaro/Janusz that they've tested.
> 
> Hi again! Any chance we could get this queued? Janusz, Aaro: any objections?

Unfortunately the patch doesn't work - 770 just dies silently. This
means that e.g. CBUS GPIOs are not working as those are needed to keep
the device powered. I'll try to figure out how to debug this...

A.
