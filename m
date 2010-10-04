From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: tidspbridge broken?
Date: Mon, 4 Oct 2010 12:34:51 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304680CCA10@dlee03.ent.ti.com>
References: <AANLkTi=hD1m0jC64KW7gHdywd=2GseX8gqNwPTHOh6s2@mail.gmail.com>
	<27F9C60D11D683428E133F85D2BB4A5304680CC90F@dlee03.ent.ti.com>
 <AANLkTimH0+jeFx+zUh6u_uzqhL+rB5W6s3PYOatHMB6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52033 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512Ab0JDRe5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 13:34:57 -0400
In-Reply-To: <AANLkTimH0+jeFx+zUh6u_uzqhL+rB5W6s3PYOatHMB6b@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, "Menon, Nishanth" <nm@ti.com>, "ohad@wizery.com" <ohad@wizery.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>

Felipe Contreras wrote:
...
> 
> Anyway, first, I think I tried a version similar to that one, and
> doesn't apply on mainline any more, also, bootmem doesn't seem to be
> working on ARM either, so I had to move to memblock, and third, I
> don't think that platform device is correct since it depends on the
> headers of a driver.    

AFAIK, bootmem is going down (http://marc.info/?l=linux-omap&m=126955999303922&w=2), I succesfully tried LMB a while back when rebasing but for the latest RCs I haven't seen it around.

...
> 
> At least on my N900 the framebuffer is not working either, and I've
> heard the same on beagleboard. 
> 
> Maybe something like this:
> http://article.gmane.org/gmane.linux.kernel.mm/52757

Will look at it.

...

Regards,

Omar

