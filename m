From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] OMAP1: clock_data: use runtime cpu / machine checks
Date: Thu, 16 Dec 2010 14:16:28 -0800
Message-ID: <AANLkTik88QZoNeCKZwUYDjq6oEiiyZE+_fmo+YoE+f85@mail.gmail.com>
References: <201012112150.33831.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50399 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab0LPWQu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 17:16:50 -0500
Received: by wwa36 with SMTP id 36so44746wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 14:16:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Mon, Dec 13, 2010 at 1:24 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hello Janusz, Cory,
>
> On Sat, 11 Dec 2010, Janusz Krzysztofik wrote:
>
> > Otherwise multi-omap1 configurations may set wrong clock speed.
> >
> > Created and tested against l-o master on Amstrad Delta.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> Thanks, this is a significant step forward in building a good
> omap1_defconfig. =C2=A0Cory, do you mind testing this out? =C2=A0If i=
t works for you
> also, let's plan to take this for 2.6.38.
>

Sure, no problem, I'll add it to my testing queue.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
