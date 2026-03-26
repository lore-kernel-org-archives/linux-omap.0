Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DD38F926
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515465; cv=none; b=KCYmxauTPYaxQQm1/yIXReLfiIT6yECJPuCRkivc8lI/x6iv+sNZRC96WRen0Eas8kLVerjoHS6SsjVSt9LlVq7ImWSnPfGtnbIKuV/QPAKfLSSQeP8eWFZoL0nQctys0bpjTfhEk7fqQgZkJrKPd0CauUk/vMkhjXC7EQ91Kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515465; c=relaxed/simple;
	bh=Ws3b7nGQYOK1DBD702AysYih0+ywSwzRoWrb12H9ynA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3iXBfD2XfLIgvUb/mbO4gOTLarKAt+LQgDfbODlDrWIOtVpv/RH8yDYFERSgClgOb6cdTquRs5Vd55b9zK4n/VcQRPviZP/2ftglgMpPy6oy6YChiOLl2o2OIn/5QSGTCVLzh3SCV1/BGytN/EfrGqMV6v4ZiTsS/E+HZflPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrENcQnU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrENcQnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5530FC19423
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774515465;
	bh=Ws3b7nGQYOK1DBD702AysYih0+ywSwzRoWrb12H9ynA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hrENcQnUCVFut4H2CjFtupt/v5/t8iwY93KKgBCnC9lsEdhsTTIRx8TObUB8ZdV8+
	 1HJDRKOgaBzERjfjUOPA2l3GFBfXVCqf0YBz0ms3FVxCTtVfXoboUk3qRPVMTURaMd
	 2E2FksweraGMeA39MfH/i70+HXHgD3kiBcE+mRqopHmaBNfA1/ERdMNj7C2KE6Nadv
	 /c1248MBHAn5c13p9yoIY6dCyUfLvsruQ0rqghhBpIWjydscdceAXxabAmwIAWxop1
	 ZVWoGCS0D91Qy4cpNM4Pn1TMvNeH5VSe4+AFCX1mXVqC2OJulM6dvgbABzRMROwQ69
	 SpiTYKDrNvbTw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a1443780c4so1603600e87.0
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 01:57:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL+Hob0F+JdtEtLCALwrpM6X5yaKVGbgClJ+ayXI4JVFHugDpvDGizDagN8SvG6+1e4VeIOgkihnPC@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLfL+6A6dJdQ/1HUIpRrZmRbtelZo8pu+gTbRe7G/WuEzjbT3
	KdE3tgPZTthJdh4Ft4gr7dhn+UdH6YZyD1VQdpaO9BjZvC/MsiHQyqmdM5TwGJc/7kJ6Js2HAhJ
	b/bhqBtawkWv2Ze59teEgs6Ci4FN9xqgcGHdriNbvgw==
X-Received: by 2002:a05:6512:2305:b0:5a2:858a:10f1 with SMTP id
 2adb3069b0e04-5a2a5050bf5mr375160e87.1.1774515464043; Thu, 26 Mar 2026
 01:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com> <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com> <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
In-Reply-To: <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 26 Mar 2026 09:57:31 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
X-Gm-Features: AQROBzBNLLHxtCNy9V7o0C4AT9cPhp-QyPTFtDSpHSqNAwoCTThHKHlTXbXXZok
Message-ID: <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:50=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Fri, Mar 6, 2026 at 1:31=E2=80=AFAM Kevin Hilman <khilman@kernel.org> =
wrote:
> >
> > Bartosz Golaszewski <brgl@kernel.org> writes:
> >
> > > On Thu, Feb 12, 2026 at 12:46=E2=80=AFPM Arnd Bergmann <arnd@kernel.o=
rg> wrote:
> > >>
> > >> On Thu, Feb 12, 2026, at 12:25, Bartosz Golaszewski wrote:
> > >> > Currently the board file for Nokia 770 creates dummy software node=
s not
> > >> > attached in any way to the actual GPIO controller devices and uses=
 the
> > >> > fact that GPIOLIB matching swnode's name to the GPIO chip's label =
during
> > >> > software node lookup. This behavior is wrong and we want to remove=
 it.
> > >> > To that end, we need to first convert all existing users to creati=
ng
> > >> > actual fwnode links.
> > >> >
> > >> > Create real software nodes for GPIO controllers on OMAP16xx and
> > >> > reference them from the software nodes in the nokia board file.
> > >> >
> > >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
> > >>
> > >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Aaro, Janusz: Can you please pick it up for v7.1?
> >
> > I can take this via the OMAP tree once I have confirmation from
> > Aaro/Janusz that they've tested.
> >
> > Kevin
>
> Gentle ping.
>
> Bart

Hi again! Any chance we could get this queued? Janusz, Aaro: any objections=
?

Bart
