From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: Re: [PATCHv2 2/4] OMAP4: Keyboard: Fix section mismatch in the board file
Date: Wed, 14 Sep 2011 09:12:58 +0200
Message-ID: <CAFULf_yWUwSf8kgtJmMeNx04axG1FoRBAy2b=ApYjGfcEvvAhg@mail.gmail.com>
References: <CAFULf_zAqFGcUfgfOMyrm8DLJhg1qXG+48W5u+pjBUwa=PmrRg@mail.gmail.com>
	<CAFULf_x_7GXMRY_rNDFk377R-ZWSOvM5KBqOe0a4cYbzGARnYA@mail.gmail.com>
	<20110816065332.GC2305@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:49656 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab1INHUD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 03:20:03 -0400
Received: by vwl1 with SMTP id 1so2205317vwl.1
        for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 00:20:02 -0700 (PDT)
In-Reply-To: <20110816065332.GC2305@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, balbi@ti.com

I can't see this one queued up anywhere.  Did it just slip through the
cracks, or are there any problems with it?

BR,

Bjarne Steinsbo

On Tue, Aug 16, 2011 at 8:53 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Aug 12, 2011 at 05:27:52PM +0200, Bjarne Steinsbo wrote:
>> `keypad_pads' is referred to by `keypad_data' which is
>> not __initdata, so `keypad_pads' should not be __initdata either.
>>
>> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
>
> --
> balbi
>
