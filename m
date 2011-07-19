From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Tue, 19 Jul 2011 14:13:29 +0530
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC0093@dbde03.ent.ti.com>
References: <1311033103-15854-1-git-send-email-vikram.pandita@ti.com>
 <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC000B@dbde03.ent.ti.com>
 <CAFm5wm1kruM0WCoAsC7Ps09TsaCUA6G6NBT24q0QY6-_B9AAog@mail.gmail.com>
 <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC0054@dbde03.ent.ti.com>
 <CAFm5wm1xVbC_=+hUnHp4g7XVihhN_=qyJDPzD3zz32Zt7jEtJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47197 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab1GSInj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 04:43:39 -0400
In-Reply-To: <CAFm5wm1xVbC_=+hUnHp4g7XVihhN_=qyJDPzD3zz32Zt7jEtJw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

Pandita, Vikram wrote:
> On Tue, Jul 19, 2011 at 12:46 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> > Pandita, Vikram wrote:
> >> On Mon, Jul 18, 2011 at 11:22 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> <snip>
> > But you can't just change authorship when the entire functional code
> > is the same. (It doesn't matter much to me - I'm not as active on
> > MUSB as I used to be; it's just the principle of the thing).
> 
> Moiz fixed the second part of your patch - which was not there on your
> original work:
> 
> <snip>

...

> <snip end>
> 
> The history is:
> 
> Original author on .35 or .32 kernel : Anand Gadiyar
> Fixes done by and some more forward ports: Moiz Sonasath
> Tested on 3.0 and code cleanups, commit message updates, community
> comment fixes: Vikram Pandita
> 
> Wonder if original author did not act all this while, is there
> anything wrong in changing authorship with proper accreditation to
> original author?
> For future pushes, i would really like to learn what the linux
> community suggests the right approach for such cases.
> 
> As i said, i am open to change and will repost as decided - there is
> no attempt to sabotage anyone's work here :-)

Checking the git tree history and the patch you just posted, you're right.
I missed Moiz's changes.

(but that same git tree shows you've got my sign-off on all the
internal patches Moiz posted - and I don't remember if the
original debugging was done by me or not)

I'm withdrawing my objection - let's just get the patch merged. It's
stayed out-of-tree for far too long.

- Anand
