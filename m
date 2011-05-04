From: Vladimir Pantelic <vladoman@gmail.com>
Subject: Re: [RFC] About ARM expansion boards and others things
Date: Wed, 04 May 2011 12:28:41 +0200
Message-ID: <4DC12A59.2010608@gmail.com>
References: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42567 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab1EDK2o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 06:28:44 -0400
In-Reply-To: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?RW5yaWMgQmFsbGV0YsOyIGkgU2VycmE=?= <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm@vger.kernel.org

Enric Balletb=C3=B2 i Serra wrote:
> Hi guys,
> I'm thinking probably in a crazy idea, I hope someone can help me or
> kill definitely this idea from my mind.
>
> I'll explain a little more, the real problem is I don't know how to
> add support for an expansion board for IGEP v2 board. I see most of
> boards adds the support inside the board-xxxxx.c file, for example if
> the expansion board has a Touchscreen interface using ADS7846/TSC2046
> they register ads7846 platform data in board-xxxx.c file. This is ok
> beacause the ads7846 can be detected and if expansion board is not
> present  the detection fails, but maybe other devices in expansion
> board can't be detected (for example an I/O expansion). So which is
> the best form to do this ?
>
> I'm thinking in create a kernel module for the expansion board that
> add all the new features, the expansion board should come with a I2C
> E2PROM for board ID storage, so the idea is create an i2c driver that
> reads the E2PROM and if found the Board ID inits all the expansion
> board devices.

don't know if you are aware of that:

http://elinux.org/BeagleBoardPinMux#Expansion_boards

also beagle.c board file has support for some expansion boards
already, maybe there is some code to be shared.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
