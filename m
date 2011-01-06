From: Kevin Hilman <khilman@ti.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Thu, 06 Jan 2011 10:15:41 -0800
Message-ID: <87pqs9vqya.fsf@ti.com>
References: <20101223171859.f6842045.sfr@canb.auug.org.au>
	<4D139517.3010608@ti.com>
	<AANLkTi=pTNg2iWN+=uEv=CyZHHCoddF51pmmCMjPeMUF@mail.gmail.com>
	<4ce0f816f951f24ca3de9c84d9f70842@mail.gmail.com>
	<4D25E313.4060202@heeltoe.com>
	<8B3471BB-CB3F-4CE6-B523-D9C5E87B9CEC@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8B3471BB-CB3F-4CE6-B523-D9C5E87B9CEC@dominion.thruhere.net>
	(Koen Kooi's message of "Thu, 6 Jan 2011 17:59:21 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Brad Parker <brad@heeltoe.com>, Anand Gadiyar <gadiyar@ti.com>, Ming Lei <tom.leiming@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>, Greg KH <greg@kroah.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Koen Kooi <koen@dominion.thruhere.net> writes:

> Op 6 jan 2011, om 16:43 heeft Brad Parker het volgende geschreven:
>
>> It's probably expected, but I can't get the EHCI USB port  to work
>> on a beagle board XM (36xx) using the current omap tree.
>> 
>> It this most likely due to these clock issues?
>
> You need this patch: http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
>
> I'm currently too lazy to split it up like Nishant wants as I don't
> see the point splitting for the sake of splitting.--

IMO, it doesn't need to be split up.

But it does have to fix the other comments I made on the same thread[1]

1) add a descriptive changelog, and
2) Cc linux-arm-kernel

Kevin

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/48920
