From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 19:07:21 +0200
Message-ID: <AANLkTim1DD5FOqqxfdV+BoMiq2wmzz6ZuDV6u5_=zUeb@mail.gmail.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
	<87sk19eneu.fsf@deeprootsystems.com>
	<4C92386F.2070600@ti.com>
	<87vd65bsfs.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61527 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab0IPRHW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 13:07:22 -0400
Received: by qyk36 with SMTP id 36so5132070qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 10:07:21 -0700 (PDT)
In-Reply-To: <87vd65bsfs.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2010/9/16 Kevin Hilman <khilman@deeprootsystems.com>:

> lib/opp/* seems more appropriate to me with the header at
> include/linux/opp.h as Linus suggested.

I second this. I would love to see the generic OPP stuff in
lib/opp/* so we put it in the right place from the beginning and
don't have to painfully refactor everything later (clk.h
especially comes to mind.)

Yours,
Linus Walleij
