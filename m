From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Thu, 9 Sep 2010 09:49:08 +0800
Message-ID: <AANLkTimBBRC7-kg_L7FpS1E5i63NPMi08g9rrG=jtWeD@mail.gmail.com>
References: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
	<AANLkTiksb1AudCzs8-TWdXb11T-QcPx1G_qu6eUtJ74C@mail.gmail.com>
	<AANLkTin7eVyosgK4XhuB_yqR2ao=YJGVidHB1x2802cr@mail.gmail.com>
	<AANLkTinrecJXH+uDxtBsskFLpBCz0VSZMtSiWGFW9YCr@mail.gmail.com>
	<AANLkTinkhY-y6Qv6HJnGbggksdEmULgQ9DTOrNmu1tLp@mail.gmail.com>
	<AANLkTikZK=8HCtXDR_2dSBce1E10xNfBtyXGOJqykV83@mail.gmail.com>
	<AANLkTin8bXvPqdkYQq++wf0iCK=ZAfZ2jnqbgL=xj8yq@mail.gmail.com>
	<AANLkTimwMiOfvCpUfeXPSF8zh3t3YsM_8nDZbuWFcKM4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39819 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266Ab0IIBtK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 21:49:10 -0400
In-Reply-To: <AANLkTimwMiOfvCpUfeXPSF8zh3t3YsM_8nDZbuWFcKM4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: venki kaps <venkiece2005@gmail.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <me@felipebalbi.com>, Anand Gadiyar <gadiyar@ti.com>

2010/9/8 venki kaps <venkiece2005@gmail.com>:

> =A0To resolve the above issue, we have made "PHY power on" in battery
> adc on function
> =A0and "PHY power down" in battery adc off function.

Good news, the temperature is bad value from battery adc if otg phy is =
power
down. Maybe you only need to power on otg phy before reading battery ad=
c, then
power down otg phy after the reading if no usb calbe is connected with =
musb
for decreasing power consumption. (I am not familiar with battery adc, =
just
for your refrerence)

Anyway, your issue(reading mistaken temperature) is nothing to do with
twl_4030 otg driver and the patch, we does need to power down otg phy
if no vbus or ID event detected.

--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
