Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC323F2102
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621346; cv=none; b=mLligTILDcoONNGCuj15CBhETYeKlWU3mDFUJqp5YKC0mT9WObGhlTXwJKsDQ0Z8INCAuAj2CxyOJdxbR99xKvGl6PeYT7f5fZ7qsW+MPZJax2HpYHrlL+Pif/kdPnzlO0ICCLTOFe2d6RBrIhydbbPXyoLGe9gdKys5vz4uQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621346; c=relaxed/simple;
	bh=4uP+LWbVeH5sme8wy63yLjMro2rk/77AqVdeM7AIlcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOaHp9zI80wmyA7KRLQsT3QS/lnHe9iyDhW/vmWYeO72j8Y1sbzMX522uCJnM12Zc5+pKF0lbvYZds8Pk9lRml44R7X9M2u5D/Fc4gDf4pi1d/HoOS2dV0Oa24CyJFWU3H+O/OU2WJH+d+DVGwTLU0jUYQqLZLXyLJyA3AkbVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrZoXwfu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrZoXwfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C78C2BCB2
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774621346;
	bh=4uP+LWbVeH5sme8wy63yLjMro2rk/77AqVdeM7AIlcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MrZoXwfufASZTHClrPyvMAHg+SuRPbLNL5vTEshX0xlxE7T/Ic4So4RfBYK/aSzEb
	 I3NmZEdYeCmX0QzVrFfKKAHLnu4BJ/R5IN213WdpQcxT2ERkAyLB0EJJRziGMQ0bZK
	 lue+A4GwvM+KUdvllO7mdy/eBHK84TzeWm287Zm2E71rvhZzWfK7gTwwzZ9fbiubqo
	 pQLk+Fd1pz49D488kEG8zITMpvUKJ5cI/mQFYici1QgpKoKIbcU8xAcSwG+3leCVVH
	 ZpPIWaNwXD6QwIJi3sTwX/F3tEOYOA31SVaYaoJU+JZIEhHPVhxcrGCFNHYFPojSsu
	 SjK8a5w89vFBQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38a43f1f978so18750551fa.3
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 07:22:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYTB1R7QXf724QzyTf9fhv/v8mywJBe8ZlQprlamszGHRkcrKdNue1mw+f75QsWupaFnJRCdtxk+Vw@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRyMczuRGRdcVbkFzsMFO2mYw+oa8YoxaTVyxs+7cgZkMl94n
	tyTw2GfUe84rNbPoQdvCXpaiD+N0f9rhmmNuS0/af2ZsWeAF+xs5+FRyXN4Rf+GWn3RPvlnxCZ9
	3sl/oxV9GXCB3NE81bBrn4xGa+78gqrUbZ9BXiBp4Zg==
X-Received: by 2002:a2e:a9a3:0:b0:38b:fd3e:c445 with SMTP id
 38308e7fff4ca-38c73065b9fmr9547931fa.3.1774621344588; Fri, 27 Mar 2026
 07:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com> <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com> <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com> <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi>
In-Reply-To: <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 27 Mar 2026 15:22:12 +0100
X-Gmail-Original-Message-ID: <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
X-Gm-Features: AQROBzAei1HZMdE0m_cEQL4UZSB3RN84tkUjwRNw5_LUz-GA34rIY7vYZzOkmeY
Message-ID: <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Arnd Bergmann <arnd@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 3:05=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.fi=
> wrote:
>
> Hi,
>
> On Thu, Mar 26, 2026 at 09:57:31AM +0100, Bartosz Golaszewski wrote:
> > On Mon, Mar 16, 2026 at 9:50=E2=80=AFAM Bartosz Golaszewski <brgl@kerne=
l.org> wrote:
> > > On Fri, Mar 6, 2026 at 1:31=E2=80=AFAM Kevin Hilman <khilman@kernel.o=
rg> wrote:
> > > > Bartosz Golaszewski <brgl@kernel.org> writes:
> > > > > On Thu, Feb 12, 2026 at 12:46=E2=80=AFPM Arnd Bergmann <arnd@kern=
el.org> wrote:
> > > > >> On Thu, Feb 12, 2026, at 12:25, Bartosz Golaszewski wrote:
> > > > >> > Currently the board file for Nokia 770 creates dummy software =
nodes not
> > > > >> > attached in any way to the actual GPIO controller devices and =
uses the
> > > > >> > fact that GPIOLIB matching swnode's name to the GPIO chip's la=
bel during
> > > > >> > software node lookup. This behavior is wrong and we want to re=
move it.
> > > > >> > To that end, we need to first convert all existing users to cr=
eating
> > > > >> > actual fwnode links.
> > > > >> >
> > > > >> > Create real software nodes for GPIO controllers on OMAP16xx an=
d
> > > > >> > reference them from the software nodes in the nokia board file=
.
> > > > >> >
> > > > >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qu=
alcomm.com>
> > > > >>
> > > > >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > Aaro, Janusz: Can you please pick it up for v7.1?
> > > >
> > > > I can take this via the OMAP tree once I have confirmation from
> > > > Aaro/Janusz that they've tested.
> >
> > Hi again! Any chance we could get this queued? Janusz, Aaro: any object=
ions?
>
> Unfortunately the patch doesn't work - 770 just dies silently. This
> means that e.g. CBUS GPIOs are not working as those are needed to keep
> the device powered. I'll try to figure out how to debug this...
>
> A.

Hmm, I'm wondering if there's a race with consumers already requesting
the GPIOs after the controller device is registered but before the
software node is added. I'll send a version with software nodes being
registered first, then passes as firmware nodes to the platform device
API before the device is registered.

Bart
