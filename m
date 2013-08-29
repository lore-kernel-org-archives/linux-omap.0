From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5] gpio: pcf857x: Add OF support
Date: Thu, 29 Aug 2013 20:24:32 +0200
Message-ID: <CACRpkda=pZ6xQ2XJke=MBLiH_DAS8CXW+JOZ856ohGZi+fOCzA@mail.gmail.com>
References: <1377590559-14279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<2400176.9Vcd5TUYl9@avalon>
	<20130827171854.GA2988@katana>
	<7583101.2yAsZLOucV@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36858 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3H2SYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 14:24:32 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so868905obb.37
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 11:24:32 -0700 (PDT)
In-Reply-To: <7583101.2yAsZLOucV@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomasz Figa <t.figa@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Archit Taneja <archit@ti.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Aug 28, 2013 at 1:58 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 27 August 2013 19:18:55 Wolfram Sang wrote:
>> > The driver should support the same chip models reardless of whether it's
>> > used with or without DT. If an entry in the OF table has no corresponding
>> > entry in the I2C table I would consider that as a driver bug.
>>
>> Linus Walleij posted a patch to support DT only probing, but too many
>> side-effects showed up. Some were fixable (probe regressions) and some
>> need more work, if feasible at all. Most prominent is that runtime
>> instantiation of i2c slaves currently needs an entry in the i2c table.
>
> Linus, I'd like to get this in v3.12 if it's not too late. Could you please
> provide your input ?

Provided some input on the v4 version, due to being a bit overloaded
my patch queue is overloaded...

Yours,
Linus Walleij
