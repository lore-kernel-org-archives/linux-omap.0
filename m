From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Sensors and the input layer (was Re: [RFC] [PATCH V2 1/2]
 input: CMA3000 Accelerometer driver)
Date: Tue, 31 Aug 2010 10:53:37 +0100
Message-ID: <20100831105337.7ba1dcaa@lxorguk.ukuu.org.uk>
References: <15445.10.24.255.17.1274424777.squirrel@dbdmail.itg.ti.com>
	<20100829184904.GC26209@core.coreip.homeip.net>
	<36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
	<20100830162855.GA17325@core.coreip.homeip.net>
	<d6b6aa8195784d6baf3ffcdc365c6361@secure211.sgcpanel.com>
	<20100830172143.GA28275@core.coreip.homeip.net>
	<3fe11bc61e6a844b926ec4d32cec1474@secure211.sgcpanel.com>
	<20100830205011.GB28711@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100830205011.GB28711@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Hemanth V <hemanthv@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, igor.stoppa@nokia.com, kai.svahn@nokia.com, mathias.nyman@nokia.com
List-Id: linux-omap@vger.kernel.org

> > My hope is that we can make use of a well known and uniform
> > API for all input devices in a device, be it a keypad,
> > touchscreen, accelerometer, magnetometer, gyro, or whatever.
> > 
> 
> If only we could agree what input devices are...

Is that the right test for some of these devices.

Surely the question is "what devices can be meaningfully represented by
the input API". 

The device range is always going to be quite large and people want to use
the API because it means things just work. They can wire their home made
surfboard unit and tilt sensors up to the PC and tuxracer just goes. They
can wire pedals and a current meter to it and use it as the speed input in
bzflag to simulate bicycle tanks etc..

Alan
