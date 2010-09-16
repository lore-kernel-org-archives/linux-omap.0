From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] overo twl4030: fix twl4030 IRQ (used for usb otg detection)
Date: Thu, 16 Sep 2010 10:46:56 -0700
Message-ID: <AANLkTinCAjpV21ySM+6OMB0GAHDQPDVzvvLQGkCxbw=z@mail.gmail.com>
References: <4C90F46D.2020902@artecdesign.ee>
	<AANLkTimG7i72PdjaX-2_EqhJkZBFm==StMJZKkzywCf=@mail.gmail.com>
	<20100916060731.GB3393@legolas.emea.dhcp.ti.com>
	<AANLkTi=jyrLHTKSP1UTxNzri2EHvkt8iXT1cW8LKNNM6@mail.gmail.com>
	<20100916174036.GB29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33193 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641Ab0IPRq6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 13:46:58 -0400
Received: by wwb18 with SMTP id 18so174232wwb.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 10:46:56 -0700 (PDT)
In-Reply-To: <20100916174036.GB29610@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, Anti Sullin <anti.sullin@artecdesign.ee>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

On Thu, Sep 16, 2010 at 10:40 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Steve Sakoman <sakoman@gmail.com> [100916 05:48]:
>>
>> Agreed. =A0Gumstix doesn't provide an easy way of determining the la=
yout
>> revision via software (the boards are marked with the rev number, bu=
t
>> that doesn't do much good!).
>
> Unless you use the camera interface during early init to detect that
> revision printed on the circuit board ;)

That was my first idea too :-)

>> I'm investigating methods to figure this out, but haven't yet found
>> anything reliable. =A0When I do I'll post a patch.
>
> How about add something to u-boot that allows setenv system_rev in
> u-boot? Maybe it already has this feature as system_rev is arm-linux
> generic atag.

The hard part is creating the code to figure out how the board is wired=
 :-)

I have some promising approaches, but nothing working yet.  Once that
is done the rest is easy!

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
