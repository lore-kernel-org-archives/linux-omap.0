From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 1/2] OMAP: DSS2: Add support for LG Philips LB035Q02 panel
Date: Fri, 4 Mar 2011 09:08:07 -0800
Message-ID: <AANLkTinkMAU1aDLRC416bvSCbNvAoYedq2y5VTJeL=uv@mail.gmail.com>
References: <1299195980-17057-1-git-send-email-steve@sakoman.com>
	<1299195980-17057-2-git-send-email-steve@sakoman.com>
	<1299225323.2196.20.camel@deskari>
	<AANLkTinTUtC_XDgCe79Aju4rdsDYHDWa9N682PDDEL5C@mail.gmail.com>
	<1299253262.2053.15.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50244 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab1CDRII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 12:08:08 -0500
Received: by vxi39 with SMTP id 39so2183351vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 09:08:07 -0800 (PST)
In-Reply-To: <1299253262.2053.15.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Mar 4, 2011 at 7:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Fri, 2011-03-04 at 09:29 -0600, Steve Sakoman wrote:
>> Do you want me to try to address this in this initial submission, or
>> is it something we can revisit in a subsequent "fix-it" patch for all
>> panels with SPI init?
>
> If you have extra time and a good solution, then of course I want you to
> address it =). But most likely we'll just revisit it later. It's not
> critical now and we may also have to look at how DSS manages the panel
> drivers.

Not a lot of extra time right now :-)

Let's try to get Overo DSS2 support in this merge window and revisit
all of the SPI config panels later.

I'll submit a V2 that addresses the locking issue later today.

Steve
