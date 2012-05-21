From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 09:01:15 -0700
Message-ID: <CA+Bv8XZDz=tvAqAYLhJqpuzy=2kwQj1O8a87ZqBVr8MPw1SEAQ@mail.gmail.com>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
	<CA+Bv8XYYe_3xprvVORXkdX2N54iDn_2v7GXndB6+cCtU0bLhcA@mail.gmail.com>
	<1337615716.2717.9.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45036 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754564Ab2EUQBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 12:01:17 -0400
Received: by lahd3 with SMTP id d3so3592130lah.19
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 09:01:16 -0700 (PDT)
In-Reply-To: <1337615716.2717.9.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Mon, May 21, 2012 at 8:55 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-05-21 at 08:52 -0700, Russ Dill wrote:
>> The correct patch for this was sent earlier:
>>
>> http://www.spinics.net/lists/linux-omap/msg70042.html
>> "[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio"
>>
>> On Mon, May 21, 2012 at 2:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > Tony,
>> >
>> > There is a bug in the for-l-o-3.5 branch I sent earlier, causing the DVI driver
>> > to fail to request the power-down GPIO. This patch fixes it.
>>
>>
>> The correct patch for this was sent earlier:
>>
>> http://www.spinics.net/lists/linux-omap/msg70042.html
>> "[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio"
>
> Right, and I was cc'd. Sorry, I somehow totally forgot about that =).
>
> So ignore my patch.

Did you also get the 'OMAPDSS: TFP410: use gpio_set_value_cansleep'?
