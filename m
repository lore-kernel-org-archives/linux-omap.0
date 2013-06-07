From: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Subject: RE: i2c issue on Panda with DT boot, v3.10-rc4
Date: Fri, 7 Jun 2013 18:31:22 +0000
Message-ID: <42EC710806A55841BBE342FAEBBEF172D26A1F@DNCE04.ent.ti.com>
References: <51B1C9D2.6060703@ti.com> <51B1D3D6.2020803@ti.com>
 <51B1D654.9070107@ti.com>,<20130607175705.GC3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37500 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755360Ab3FGSbY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 14:31:24 -0400
In-Reply-To: <20130607175705.GC3331@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Tony Lindgren [tony@atomide.com]:

> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130607 05:53]:

> > With that one, I don't get timeouts, but it still doesn't work (i.e.
> > behavior is the same as on -rc1).
> >
> > When I run i2cdump the first time, I see that it (probably) manages to
> > read the first byte, as that's "00". Everything after that are 'XX'es.
>
> Hmm I suggest git bisect, I'm pretty sure I was using my panda es
> with my omap4 DT conversion patches against v3.10-rc1.

As I mentioned, it doesn't work on v3.10-rc1 either. Note that DVI output
itself works fine, it's the EDID read that fails. So if you force the
videomode, you won't notice anything.

I didn't try with v3.9 (does DT boot work on that one?), though. So I don't
know if reading EDID has ever worked with DT boot.

 Tomi

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


