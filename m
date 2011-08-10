From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: How to handle named resources with DT?
Date: Wed, 10 Aug 2011 14:12:06 -0600
Message-ID: <CACxGe6sX9n5YBXsWyK=prCCssw169Tga3D+9hwc+qa1zFr3CMQ@mail.gmail.com>
References: <4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
 <20110809205723.GE11568@ponder.secretlab.ca> <4E41A1B9.1060400@ti.com>
 <20110809211747.GJ11568@ponder.secretlab.ca> <4E41AA43.1000506@ti.com>
 <20110809214905.GK11568@ponder.secretlab.ca> <4E41AC5C.20301@ti.com>
 <20110810015214.GD23511@yookeroo.fritz.box> <CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
 <20110810195753.GA29134@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f52.google.com ([209.85.212.52]:35475 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab1HJUM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 16:12:26 -0400
Received: by vws16 with SMTP id 16so1749612vws.11
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 13:12:26 -0700 (PDT)
In-Reply-To: <20110810195753.GA29134@huya.qualcomm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 10, 2011 at 1:57 PM, David Brown <davidb@codeaurora.org> wr=
ote:
> On Wed, Aug 10, 2011 at 01:22:16PM -0600, Grant Likely wrote:
>
>> Please, stick with the established convention and explicitly order
>> 'reg' and 'interrupts' properties. =A0If there is a specific use cas=
e
>> where this doesn't work, then bring it up, but I haven't seen any ye=
t.
>> =A0The current users of _byname that I've looked seem to only use it=
 for
>> convenience, not because a register range may be optional. =A0ie. th=
ey
>> all fail out if a reg resource isn't present.
>
> The msm_serial driver uses the presence of one of it's _byname reg
> regions to distinguish between two different types of the controller.
> Fortunately, it is the last register range that has this.
>
> It's probably best to make the DT code depend on compatible (or some
> attribute) to determine if this functionality is available, or in thi=
s
> case, even make it a separate memory region. =A0I'm not sure what the
> cleanest way is to implement this, and still have the driver work wit=
h
> non-DT systems.

You can use the .data field in the match table to add in
compatible-specific configuration data.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
