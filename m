Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161019;
	b=ETE62bJr1DdESxRn+e2Ni3jW57DzLlOyYnlDTLlOOXJpXXrcq5oHpLJpfV+DgubkdbKN
	 ddQ+rdcNxFgnlW29du8lf7kGITB3ueA8FG6Zop012GD3ERBJKhDIUm/EOUNwXPSu4H0DJ
	 WHRbzPhke1a6ArKtSHpndRMQsYiiQRw2ABv9SF2M3EDMdGklvhmTsW0rD/sNK99P09lxu
	 OAoj8m6B4LJQYA0bH4qCLIHifkUL8ubzHGGzmAdWzf2Z9Ojk2GYxPhJVRNFBTAIdsRGCD
	 NLZMBKCrfvxVUVjZZ0ZXfd/If6wzMMYihhOaVXG1DE1GnA9EjFeEXsWZP4SqV9+JIww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161019;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Vu6IMQbhyMpXX+yWtY4enAtEpk8kj3N3fFV230nsSvs=;
	b=ivyTfJk5zAvk9oTaMe9ViIH6nN6df2vT6jU3+iu19ulQTKwuXOq2zLee4iHoYzCbNm/g
	 UZhF2MOkxnlesbuOBb89LXegYVXDPGczAzwj6WC2hjE52rC5yatra2BcClBCeTCg/mshE
	 7iQ90ExJzXBa/xJegIWFagu/4znzJ3V8fctHa0Q29HoKQqqrdLNrJURHO1rmaQhetJW/e
	 ZV1zNfZr3/GqCm3HZ5rV/WSpS7xUwD/tC0NqGbfAZf5BddgmqsOof+A9xD9mxWpgN9+zD
	 NzHHdTEbEgM2OdURS2tRZjjFDZwfQs/1y7OiEiVoDUo7m3KN55CwRDCwE30oeVFDJTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1D606A320
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 07:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB1D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-94965745d92so65064585a.2
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 23:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795161018; x=1795765818;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vu6IMQbhyMpXX+yWtY4enAtEpk8kj3N3fFV230nsSvs=;
        b=TMyHgoGZoBTqZcHoLEOkNNLHTs7tUchac3uCj528CAx5v7q/j+OlE346u5yinMcD27
         Vw9E/zZuYAlNXDHmqqnNObtVz91P239ktdnuJ0UD47i0Q0b+FOfdBm2gpct0Ps9xaaBB
         kBt0898tWX6Ijk6UZM+j6jExzBYBUsMBT1i5dbpcfGzriyt10ye/WSlWXM9tnfZ3VqG3
         PvmhtOWFSy8C4tq3A0M7TJBDJ+IIw65ztXC3TyTfZrqotj6/lzk/kRgHNDgJPANRC3Rh
         NwyDOUBsZeJ0fA++lH92mk6VCZR+gi9wbPj0CIMIrTAHO1GhGHav4JO25qAv75usDqNH
         6POg==
X-Forwarded-Encrypted: i=1; AL+hErHtCWk1E7LDK1Ue4W19ta5OBWLUuh6aTQV0NePUp+6J1Z2F7KLgPTMYpXFDT1huk8BALq5xoSGy8B1H@vger.kernel.org
X-Gm-Message-State: APuU4Z8rxuW7qpWTk3Oi0Si7nnRpr2cBTtoLXbOFYBtn+3HOUUWbNNeN
	bLQm6dvMaBRqE4WdVECAJNaq8LbhqO/UjqGRl12kzLEetlbJUe9FIY1CUpDFKppj
X-Gm-Gg: AYBFou1N4PIozb7Lt7KvPjIdv5Xe9S4dogZEaf74QOxF9h+mnONJw4NC2DdlSaq3UDo
	nauTiysIV5w42j+i/mSA2fe26JEhsZI1oacoq0Ohqm1bpF3J9heMdL+doPCxvvh3K54VqLGJqn7
	x38D5fAykHEIOhL4F+FBBNBQ4HG6MQL+x/AyxP63dXDWV/stXGNwPz2Yp9k0RvafajkAAhzep6w
	KNunNOOWAjV1h6xVgpJwomju9tnUM8toX4rVX8Ge43egM0KQvCECCJAX/4d4A9ZSHHAU9AlZKzx
	nUexarXyvyVTrQv61fRhXlnZPmWwrBjea3xsQ0C0amyZZcPnx41ElJte11wzw1WfrHaBKwjOFGy
	20FDglpL4OurLXgS0XZJVQlnxx7hPaS0BhHmrSrRlNA7fI/W0CIY4WFXjp5ueZjF9mlL49LVSXv
	8COoUsT/Ikmroj57AQv8dC56Di2W6Thj4xX8wzYALIKKm0rghfwKeXD+0u+ZHuD7r5L/fU2zohK
	oPaTf0BBPN44Nn8VSAoAo1EH3Vt9kjf+vrwNc4VKuSJCmYG8SVfuR118jiyWpZWSYzIm2+2eLGw
	1D1z75kQZNTykrK1Nc+lEmeB/xC0HaDog2umhRqyr5JjbKhuvjyUo6T8N6IlOo/SkRnCYEuRJ0K
	X7sK7Mbj+tK0IOGGl
X-Received: by 2002:a05:620a:6491:b0:93e:5dcb:eb9b with SMTP id af79cd13be357-949ba9b3b89mr314494085a.42.1795161017793;
        Thu, 19 Nov 2026 23:50:17 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0354a9sm147998485a.5.2026.11.19.23.50.17
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 23:50:17 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-94965745d92so65064085a.2
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 23:50:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF+Iy9OeP3RqYkVY+xWjcCFhxiJnijFSSjpM0Y4e9Iu3uAOczfH5bmRmkn7vgwCwzevAeaXMGikFB1q@vger.kernel.org
X-Received: by 2002:a05:6102:441e:b0:7cb:bda3:27ab with SMTP id
 ada2fe7eead31-7d7393925f5mr941037137.13.1795160681386; Thu, 19 Nov 2026
 23:44:41 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795094688.git.geert+renesas@glider.be> <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
 <179513882271.284394.17357508909448455391.b4-review@b4>
In-Reply-To: <179513882271.284394.17357508909448455391.b4-review@b4>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 08:44:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
X-Gm-Features: Aa3M54p6yw1Lhc431P_jQfP5g0YMf_od8mct8UUR6SclOJC7dcSgYi-awR9w8qQ
Message-ID: <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
To: Brian Masney <masneyb@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

On Fri, 20 Nov 2026 at 02:40, Brian Masney <masneyb@kernel.org> wrote:
> > This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> > about consumer devices").
> >
> > This commit added a struct device pointer member to struct clk and a
> > parameter to clk_hw_create_clk(), but the new member was never used
> > beyond setting.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/clk/clk.h
> > +++ b/drivers/clk/clk.h
> > @@ -5,8 +5,6 @@
> >   */
> >
> >  struct clk_hw;
> > -struct device;
> > -struct of_phandle_args;
>
> Did you mean to remove of_phandle_args?

Yes, it was added by efa850487a6b6742, too (although it was
used in that header file before). Currently it's not used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
