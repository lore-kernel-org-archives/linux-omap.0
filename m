From: Alex Tomas <bzzz.tomas@gmail.com>
Subject: Re: is there way to control dss output bits?
Date: Mon, 19 Mar 2012 12:27:29 +0300
Message-ID: <CAOaPdDYqPS=0aKTXatvhXgpAfXXHRRNeCFBxyCy6hbZF1k41=w@mail.gmail.com>
References: <CAOaPdDZw0yEXonpWkvr0Q+zNVzfC6myQPpjkE+k0Yg0ZFg7bkQ@mail.gmail.com>
	<1332148733.2144.3.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51907 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757066Ab2CSJ1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 05:27:30 -0400
Received: by lbbgm6 with SMTP id gm6so3171798lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 02:27:29 -0700 (PDT)
In-Reply-To: <1332148733.2144.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Mar 19, 2012 at 12:18 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> I'm trying to build simple DAC to generate RGsB signal on a beagleboard.
>> say, the output is filled with green, then at "green" pins I get 1 all the time
>> while I'd like to get 0 while hsync/vsync are active. is it possible with OMAP?
>> I found UNUSEDBITS in the documentation, but that seem to be related to
>> RFBI and not to regular parallel output ?
>
> I'm not aware of such functionality. Why do you care what the green pins
> are during hsync/vsync? The color pins should be used only when the
> data-enable pin indicates that there's valid data there.

I see... I tried to re-used a schema which relies on this as that primitive DAC
basically sums "color" current with "sync" current.

(tested that on samsung chips).

thanks, Alex
