From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
Date: Fri, 21 Nov 2008 09:29:20 +0200
Message-ID: <1227252560.9951.111.camel@kj-ubuntu>
References: <87d4grdxqh.fsf@deeprootsystems.com>
	 <345163910811200045n3af8b3b5mbd30601aeeee31e@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>
	 <8966B984-6139-467A-BF52-EDD0D9BF91B5@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29241 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbYKUH1J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 02:27:09 -0500
In-Reply-To: <8966B984-6139-467A-BF52-EDD0D9BF91B5@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <k.kooi@student.utwente.nl>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Reid <ppeter.reid@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On to, 2008-11-20 at 15:48 +0100, ext Koen Kooi wrote:
> Op 20 nov 2008, om 15:13 heeft Premi, Sanjeev het volgende geschreven:
> >>
> > These are my observations on OMAP3EVM:
> >
> > 1) Very frequently I see these messages:
> >
> > <4>__ratelimit: 6736 callbacks suppressed
> > __ratelimit: 6736 callbacks suppressed
> > <3>omapfb omapfb: irq error status 00c2
> > omapfb omapfb: irq error status 00c2
> 
> There should be a workaround for those in 2.6.28rc3.  Rick Bronson  
> posted a message about it on 7 november titled "Fix for dispc's error  
> "omapfb omapfb: irq error status 4020"

This interrupt is from SYNCLOST, which is different than what Premi had
(GFX fifo underflow). For that underflow one needs to set higher fifo
thresholds, like I described in my earlier mail.

- Kalle

> 
> regards,
> 
> Koen
> 
> regards,
> 
> Koen
