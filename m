From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Thu, 16 May 2013 10:29:04 +0200
Message-ID: <CAGGh5h3WGGRcQgpns7EOso1yqvrzKmCAbQo9XZoMyhv0Q1KT4Q@mail.gmail.com>
References: <1368684720-26763-1-git-send-email-pekon@ti.com>
	<1368684720-26763-3-git-send-email-pekon@ti.com>
	<CAGGh5h16kxdPRtPQ4vRzLA4iMxjTurPpdzBiEHaM9zb+y8fJBg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9C4EC5@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34231 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335Ab3EPI3G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 04:29:06 -0400
Received: by mail-wi0-f178.google.com with SMTP id ey16so2439061wid.11
        for <linux-omap@vger.kernel.org>; Thu, 16 May 2013 01:29:04 -0700 (PDT)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9C4EC5@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Philip, Avinash" <avinashphilip@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>

2013/5/16 Gupta, Pekon <pekon@ti.com>:
>> >
>>
>> OMAP_ECC_BCH4_CODE_HW_DETECTION_SW and
>> OMAP_ECC_BCH4_CODE_HW
>> seems to exist in the code, but are not in the changelog, and not in
>> the device tree binding documentation.
>>
>
> Yes, I plan to omit them from code also, in next series as it does no=
t
> make sense to support both BCH4 and BCH8 at same time, when most
> users would opt for BCH8.
> Also, BCH4 was kept for legacy purposes, and was not tested on all de=
vices.
> Therefore I have purposely omitted it from documentation.
>

We have shipped devices with BCH4 nand.  This would be a regression for=
 us.

Regards,
Jean-Philippe Fran=C3=A7ois.

> with regards, pekon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
