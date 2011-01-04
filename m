From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Tue, 4 Jan 2011 23:41:05 +0800
Message-ID: <AANLkTinPEpMofTX0YWbv18gSdWtPLVFa85S1E=+QxFT=@mail.gmail.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	<4D21F3F2.6090302@mvista.com>
	<20110103163447.GB2911@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
	<4D220246.5020303@mvista.com>
	<19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
	<20110103204416.GA2240@legolas.emea.dhcp.ti.com>
	<4D231B5F.7030607@mvista.com>
	<1294149984.1822.9.camel@eowin>
	<AANLkTi=JyoQuP-OQtV1yO0WR1GCM1LieHUj5Sn=ZfVim@mail.gmail.com>
	<1294152988.1822.12.camel@eowin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33511 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1ADPlH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 10:41:07 -0500
Received: by wyb28 with SMTP id 28so14419238wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 07:41:06 -0800 (PST)
In-Reply-To: <1294152988.1822.12.camel@eowin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, balbi@ti.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

2011/1/4 Felipe Balbi <me@felipebalbi.com>:
> Hi,
>
> On Tue, 2011-01-04 at 22:40 +0800, Ming Lei wrote:
>> > The end goal is just to drop all these ad-hoc "APIs" for accessing=
 DMA
>> > on musb code.
>>
>> If this kind of DMA controllers are only used by MUSB, seems not
>> necessary to convert to dmaengine API. =A0Any benefit we can get
>> from the convert? =A0 MUSB is cross-platform already after all.
>
> <irony>
> correct, OMAP GPIO controller is only used on OMAPs, so why do we eve=
n
> bother having gpiolib, right ?

OMAP GPIOs have many usages or use cases, so we can use gpiolib
to simplify access to GPIOs.  If GPIOs has only one usage or use case,
it is not necessary to access GPIOs by gpiolib.

Now this kind of DMA controllers are only used by MUSB or only for
MUSB, so it doesn't matter to access them by dmaengine or not.

thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
