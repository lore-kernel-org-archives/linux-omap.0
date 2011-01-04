From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Tue, 04 Jan 2011 21:50:43 +0300
Message-ID: <4D236C03.9040707@mvista.com>
References: <20110103163447.GB2911@n2100.arm.linux.org.uk> <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com> <4D220246.5020303@mvista.com> <19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com> <20110103204416.GA2240@legolas.emea.dhcp.ti.com> <4D231B5F.7030607@mvista.com> <1294149984.1822.9.camel@eowin> <AANLkTi=JyoQuP-OQtV1yO0WR1GCM1LieHUj5Sn=ZfVim@mail.gmail.com> <1294152988.1822.12.camel@eowin> <AANLkTinPEpMofTX0YWbv18gSdWtPLVFa85S1E=+QxFT=@mail.gmail.com> <20110104184244.GC2647@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34711 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab1ADSwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:52:09 -0500
Received: by eye27 with SMTP id 27so6438414eye.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:52:08 -0800 (PST)
In-Reply-To: <20110104184244.GC2647@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Ming Lei <tom.leiming@gmail.com>, Felipe Balbi <me@felipebalbi.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello.

Felipe Balbi wrote:

> On Tue, Jan 04, 2011 at 11:41:05PM +0800, Ming Lei wrote:
>> OMAP GPIOs have many usages or use cases, so we can use gpiolib
>> to simplify access to GPIOs.  If GPIOs has only one usage or use case,
>> it is not necessary to access GPIOs by gpiolib.

>> Now this kind of DMA controllers are only used by MUSB or only for
>> MUSB, so it doesn't matter to access them by dmaengine or not.

> Not entirely true. TUSB uses OMAP system DMA and AFAICT CPPI is used
> also for ethernet.

    Yes, but the CPPI registers are not compatible between MUSB and EMAC, only 
the descriptors are, AFAIK.

WBR, Sergei
