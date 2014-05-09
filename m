From: Nishanth Menon <nm@ti.com>
Subject: Re: omap4-panda-es boot issues with v3.15-rc4
Date: Fri, 9 May 2014 07:33:47 -0500
Message-ID: <CAGo_u6rz96boeCFjLTjuJ185ru=xOuz6__y-wMpwphcXu32Wsg@mail.gmail.com>
References: <536B7E44.2040303@ti.com>
	<7hppjos2w2.fsf@paris.lan>
	<CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>
	<536BBAF5.8070906@ti.com>
	<536C9208.6000704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:62244 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaEIMds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 08:33:48 -0400
Received: by mail-wi0-f181.google.com with SMTP id n15so1234768wiw.14
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2014 05:33:47 -0700 (PDT)
In-Reply-To: <536C9208.6000704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, "Kristo, Tero" <t-kristo@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, May 9, 2014 at 3:30 AM, Roger Quadros <rogerq@ti.com> wrote:
>
> Stupid question, is hearbeat LED even supposed to stop blinking in C3 state?
> It would make a user think that the board is dead.

I believe yes - we have tick suppression. else we'd be just wasting
power by waking up just to blink an LED. some deeper C states need
higher latencies.

Regards,
Nishanth Menon
