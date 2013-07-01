From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every GPIO on DT
Date: Mon, 1 Jul 2013 13:01:54 +0200
Message-ID: <655D996E-9836-4919-B376-8A45490B3552@collabora.co.uk>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <CACRpkdZryWYZuOLx5E2njLNRd1SLj4VgtEyEETh88+3SS5ckyQ@mail.gmail.com> <CAAwP0s2jtVEoqMVE7ru-tcXMX8ZKZObnDz0UDWiS4QkbJODOHA@mail.gmail.com> <CACRpkdaQ+zvrYF6o65Emkf2yiMR4YOfutBv-LTDc0xOmnkZkBg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43156 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab3GALB7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 07:01:59 -0400
In-Reply-To: <CACRpkdaQ+zvrYF6o65Emkf2yiMR4YOfutBv-LTDc0xOmnkZkBg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>


On 01/07/2013, at 10:04, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Jun 30, 2013 at 2:25 AM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
> 
>> Yes, It doesn't apply cleanly to your "next" branch cleanly because
>> this patch-set depends on the following bugfix patch merged late on
>> the -rc cycle (3.10-rc7):
>> 
>> 397eada9 ("gpio/omap: don't use linear domain mapping for OMAP1")
> 
> Aha, well this fix was only CC:ed to Grant so I never saw it
> happen. Obviously it cannot be merged through my GPIO tree
> then.
> 

Yes, sorry about that. I didn't do a proper post of that patch but it was proposed on a very long thread [1] about a regression for GPIO in OMAP1 platforms.

Then Tony took the patch and send a pull request to Grant. I just saw you were not cc'ed.

>> So, I could change the patches so they can be applied cleanly on your
>> branch but then it will not apply cleanly when you send your pull
>> request to Torvalds.
> 
> That will probably not work as it would cause even more conflicts
> upstream, and now the merge window is open so no way can I
> rebase the tree either.
> 
> Let's see if we can cram it in as part of a late v3.11 merge or
> if we'll have to defer to v3.12.
> 

Ok no worries. Since these patches fixes an actual issue (using a GPIO as IRQ) I guess they still can be sent as part of the v3.11 -rc cycle gpio fixes.

> Yours,
> Linus Walleij

Thanks a lot and best regards,
Javier

[1]: http://comments.gmane.org/gmane.linux.ports.arm.kernel/236198