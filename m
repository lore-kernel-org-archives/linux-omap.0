From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Tue, 04 Jan 2011 16:06:24 +0200
Message-ID: <1294149984.1822.9.camel@eowin>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	 <4D21F3F2.6090302@mvista.com>
	 <20110103163447.GB2911@n2100.arm.linux.org.uk>
	 <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
	 <4D220246.5020303@mvista.com>
	 <19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
	 <20110103204416.GA2240@legolas.emea.dhcp.ti.com>
	 <4D231B5F.7030607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41030 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab1ADOGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 09:06:32 -0500
In-Reply-To: <4D231B5F.7030607@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: balbi@ti.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

(using personal email, left the office)

On Tue, 2011-01-04 at 16:06 +0300, Sergei Shtylyov wrote:
> >> I think we will get more clarity once we start on this activity.
> 
> > I agree, but I personally don't see that many limiting factors.
> > dmaengine is just a generic API for doing DMA transfers. If it's not
> > enough for us currently, we extend it.
> 
>     Putting MUSB DMA enignes into drivers/dma/ is the same as taking *any* 
> chip capable of bus-mastering DMA, "separating" its bus mastering related code 
> from its driver and putting this code into drivers/dma/. This doesn't make 
> sense, in my opinion. drivers/dma/ is for the dedicated DMA controllers (which 
> can *optionally* serve the slave devices).

Do I really have to spell it out ? Really ?

You don't need to physically move the part of the code to drivers/dma,
but it has to use the API. The mentor DMA is internal to MUSB.
tusb6010_omap.c isn't.

Where it makes sense to move the code under drivers/dma, it will be
done, where it doesn't, it won't be done, but it will use the same API.
That's all.

The end goal is just to drop all these ad-hoc "APIs" for accessing DMA
on musb code.

-- 
balbi

