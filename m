From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Fri, 7 Jan 2011 22:15:45 +0800
Message-ID: <AANLkTikLQRHyp-TS_idEp5Fr74qC3vDoMqqsAA2v_oV8@mail.gmail.com>
References: <20101223171859.f6842045.sfr@canb.auug.org.au>
	<4D139517.3010608@ti.com>
	<AANLkTi=pTNg2iWN+=uEv=CyZHHCoddF51pmmCMjPeMUF@mail.gmail.com>
	<4ce0f816f951f24ca3de9c84d9f70842@mail.gmail.com>
	<AANLkTimA5UOVn6+xe0ofV1F3_XhAP0daBvOAX2k1u_dU@mail.gmail.com>
	<AANLkTimzQ1PHN986fqPF0yjd1M+390nSUDYJ65pu0z_f@mail.gmail.com>
	<4D271E0E.8050401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4D271E0E.8050401@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>, Greg KH <greg@kroah.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Anand,

2011/1/7 Anand Gadiyar <gadiyar@ti.com>:
> Hi Ming Lei,
>
> I'm able to reproduce this on my panda, and I have it working as of
> linux-next-20101221 (the last version I tested last year) and failing
> on linux-next-20101227 (which was the very next linux-next release).
>
> Not sure why, but my Panda manages to get the VID:PID of the hub as
> well, while yours does not even get there.
>
> I may need a few more hours to debug this, unless someone beats me
> to it. ;)

Is it caused by the below?

[   46.580200] ehci-omap ehci-omap.0: failed to get ehci port0 regulator

thanks,
-- 
Lei Ming
