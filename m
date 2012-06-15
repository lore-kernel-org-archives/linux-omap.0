From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 2/3] ARM: OMAP2+: onenand: cleanup for gpmc driver
 conversion
Date: Fri, 15 Jun 2012 06:52:36 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A307@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <2d6f0fb31cde98cd700d7a4268683b4aeeee87f2.1339419244.git.afzal@ti.com>
 <4FD63AAE.90008@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D47@DBDE01.ent.ti.com>
 <4FD77CC8.4000003@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998781@DBDE01.ent.ti.com>
 <4FD8C217.2050006@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9993EF@DBDE01.ent.ti.com>
 <4FDA252C.4020708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47329 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab2FOGwp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 02:52:45 -0400
In-Reply-To: <4FDA252C.4020708@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Thu, Jun 14, 2012 at 23:23:48, Hunter, Jon wrote:
> On 06/14/2012 12:40 AM, Mohammed, Afzal wrote:

> > During gpmc driver probe, it will configure all the connected peripherals,
> > if configuration details are not present at that point of time, gpmc driver
> > will cry out saying that configuration & timings has not been configured,
> > (please see holler if no configuration patch). 
> 
> Sorry, I am not sure if I am missing something here, but isn't the
> chip-select requested during the gpmc probe? If so then we should not be
> programming the gpmc registers at all until the chip-select has been
> allocated. Hence, after the probe seems more appropriate.

This patch by itself has no much meaning other than preparing for driver
conversion so that driver conversion series would be simpler, if you read
it with gpmc driver conversion series and adapting peripherals to gpmc
driver series, hopefully you can make out what I am trying to express

with gpmc driver, first chip select request happens, then programming
gpmc registers happen, but note that both happen in probe

> >> I am not convinced we need to. Furthermore with your change you do not
> >> actually set async mode in the onenand until _set_sync() is called.
> > 
> > Yes, setting async mode in onenand is done in set_sync function, and it is
> > always called by onenand driver indirectly.
> > 
> > Seems if setting async mode in onenand is taken out of set_sync & placed
> > it before set_sync invocation in gpmc_onenand_setup, intention will be
> > clear, right ? (even though sequence wise same thing is happening now)
> 
> Exactly.

Ok, v2 will have this change

> >> Yes but as far as I can see, it seems that this is the intent of the
> >> onenand_setup() function to perform the necessary initialisation.
> > 
> > I believe doing it in gpmc_onenand_init is better, due to the reasons
> > mentioned above as well as because function name will correspond to what
> > it is doing, i.e. initialization
> 
> If the chip-select is allocating during the probe, then I don't agree.

I believe you were referring to gpmc driver probe, not onenand probe,
the changes has been done such that both old and new driver interface
can make use of most of existing code.

And only old interface will call gpmc_onenand_init, and with that gpmc
driver interface is not coming into picture, while with new gpmc driver
interface, function used would be different one as in [1]

> > Yes, on omap3evm, with help of local patches (as mainline doesn't have
> > those). It was mentioned in cover letter of gpmc driver conversion series
> 
> Great. Sorry but with 20+ patch spread across 3 series it is not always
> easy to find the details. So ideally it should be mentioned in this
> cover letter too.

I am sorry for that

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69919.html

