From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Mon, 6 Dec 2010 09:54:45 -0800
Message-ID: <20101206175445.GF8345@atomide.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com>
 <4CFCBCF1.9010902@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E739404BCE3A1EC@dbde02.ent.ti.com>
 <4CFD19A7.5020902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32641 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab0LFRyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 12:54:52 -0500
Content-Disposition: inline
In-Reply-To: <4CFD19A7.5020902@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

* Sergei Shtylyov <sshtylyov@mvista.com> [101206 09:04]:
> Hello.
> 
> Gupta, Ajay Kumar wrote:
> 
> >>>As the control.h have been moved to new location and it's
> >>>uses are not allowed to drivers directly so moving the phy
> >>>control, interrupt clear and reset functionality to board
> >>>files.
> 
> >>    I'm not fond of the whole approach. I'm not sure why accesses to the
> >>control registers are such a no-no, taking into account that one needs to
> >>access such regisyter to clear the interrupt...

Because drivers should arch independent and any tinkering of the
platform level registers will lead into pains later on that
I end up having to deal with.

To me it seem you just init to separate out the transceiver,
right?
 
> >I think Tony is the right person to answer this :)
> 
>    Yeah, I thought he must be reading linux-omap...

I do yeah.. Might take a while to respond sometimes though :)

Tony
 
