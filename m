From: Praveena Nadahally <praveen.nadahally@stericsson.com>
Subject: Re: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Wed, 26 Sep 2012 11:22:11 +0530
Message-ID: <CAPe0uWoX92e6Hbazji+s9DPiZnfxqE=a=5Hnu39SrD6qZnRWzg@mail.gmail.com>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
	<20120924121538.GH2892@arwen.pp.htv.fi>
	<CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
	<20120924130216.GA5603@arwen.pp.htv.fi>
	<20120924160914.GB28835@atomide.com>
	<20120925080420.GH9137@arwen.pp.htv.fi>
	<CAPsFW+T_ezWAxO9StSf9cu9nJ6Gw8T9Dk1H3g6+bwJ-PKtn-cQ@mail.gmail.com>
Reply-To: praveen.nadahally@stericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58613 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab2IZFwN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 01:52:13 -0400
In-Reply-To: <CAPsFW+T_ezWAxO9StSf9cu9nJ6Gw8T9Dk1H3g6+bwJ-PKtn-cQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philippe De Swert <philippedeswert@gmail.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Philippe De Swert <philippe.deswert@jollamobile.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, heikki.krogerus@linux.intel.com, kishon@ti.com, marek.vasut@gmail.com, leoli@freescale.com, s.hauer@pengutronix.de, shubhrajyoti@ti.com, nsekhar@ti.com, notasas@gmail.com, vikram.pandita@ti.com, ravibabu@ti.com, mina86@mina86.com, mian.yousaf.kaukab@stericsson.com

On Tue, Sep 25, 2012 at 2:39 PM, Philippe De Swert
<philippedeswert@gmail.com> wrote:
> Hi,
> On 25/09/2012, Felipe Balbi <balbi@ti.com> wrote:

>> Then maybe it's best to just remove the ifdefs and always provide
>> generic_interrupt() ?
>>
>> Anyone against it ?

Providing generic_interrupt seems fine.

> Well it seems there are only two drivers that use it omap2430 and
> ux500. Maybe we somehow link it to the drivers that need it? (I might
> have missed other drivers but it looks like it is just those two)

One way I see is that omap2430 and ux500 implement the isr handler
in platform glue driver and then call the musb_interrupt() as done in
daxxx, amxxx, ti8xxx platforms. Then generic_interrupt can be removed.
