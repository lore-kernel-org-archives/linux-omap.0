From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/4] fbdev: add a MIPI DSI header
Date: Thu, 20 May 2010 17:20:59 +0300
Message-ID: <1274365259.4246.52.camel@tubuntu.research.nokia.com>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
	 <Pine.LNX.4.64.1005071102440.4777@axis700.grange>
	 <1274255350.2307.159.camel@tubuntu.research.nokia.com>
	 <Pine.LNX.4.64.1005190955500.3099@axis700.grange>
	 <1274257308.2307.168.camel@tubuntu.research.nokia.com>
	 <Pine.LNX.4.64.1005200939030.26000@axis700.grange>
	 <1274344369.4246.28.camel@tubuntu.research.nokia.com>
	 <Pine.LNX.4.64.1005201251350.26000@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005201251350.26000@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-20 at 13:03 +0200, ext Guennadi Liakhovetski wrote:

> Yes, I'd use u8 too, because the specs define "transaction types" to take 
> 6 bits and "DCS commands" to be 8-bit ints. But, you know, doesn't our 
> case fall under case (b) of Chapter 5 "Typedefs" of CodingStyle?:) I mean, 

CodingStyle says: "if there is a clear reason for why it under certain
circumstances might be an "unsigned int" and under other configurations
might be "unsigned long", then by all means go ahead and use a typedef."

In our case the DSI transactions and DCS commands are always 6 and 8
bits, so I don't think it applies.

And the transaction datatypes and DCS commands are really just payload
sent to the peripheral, and the peripheral can do anything it wants with
those.

> wouldn't it make sense to create two typedefs for these to add some 

But wouldn't a typedef basically lock the possible transactions or DCS
commands that you can give to the functions? And that was the original
problem also.

> type-safety? In fact, transaction types cannot be user-defined / 
> proprietary, right? So, for that an enum would work. It's only DCS 

Why they cannot be? I don't see any technical problem there, at least.
And while I don't have any current use to extend transactions, I
wouldn't want to limit it for any possible future use either.

> But you only need specific panel drivers if you want to support their 
> proprietary commands? Otherwise you only need a set of parameters - 
> timeing requirements etc. - which you can perfectly just pass in platform 
> data?

That's true. I guess you've gotten it easy, if you only have DSI video
mode panels that do not need any special care =). Command mode panels
are usually slightly more complex, and especially early prototypes of
the panels can require quite a lot of trickery. And then there are DSI
hubs, which make DSI command mode panels look trivial...

 Tomi


