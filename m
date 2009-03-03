From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [alsa-devel] [PATCH 1/3] ASoC: Add GPIO support for jack
	reporting interface
Date: Mon, 2 Mar 2009 18:47:50 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECD6D7B9@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
 <20090226115243.GC4229@sirena.org.uk>
 <2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com>
 <20090227130502.GA4415@sirena.org.uk>
 <2C7D3DF36ADFFC479B44490D912B616705ECC77374@dlee07.ent.ti.com>
 <20090302113845.GA19744@sirena.org.uk>
 <2C7D3DF36ADFFC479B44490D912B616705ECC77862@dlee07.ent.ti.com>
 <20090302225527.GA6390@sirena.org.uk>
 <2C7D3DF36ADFFC479B44490D912B616705ECD6D789@dlee07.ent.ti.com>
 <20090303004319.GA10159@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60263 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbZCCAsP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 19:48:15 -0500
In-Reply-To: <20090303004319.GA10159@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> > Then, when to trigger the callback? Every time jack status 
> > is going to be updated?

> Yes.  Note that if we're going to add a callback it should be 
> done as a separate patch since it's a separate feature.  It's
> probably as well to get the GPIO jack detection and support for
> your system merged and then worry about any callback separately.

Ok, then I'll post again GPIO patches. Thanks.