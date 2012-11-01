From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Thu, 1 Nov 2012 13:51:48 +0000
Message-ID: <20121101135148.382aec00@pyramind.ukuu.org.uk>
References: <20121031212639.GQ12739@atomide.com>
	<8B058B00-6C21-4410-A24B-75651D49F6EC@antoniou-consulting.com>
	<20121031221402.GA29490@arwen.pp.htv.fi>
	<E4EE0D1F-C7AC-4620-86F2-D9C7C56E279F@antoniou-consulting.com>
	<50924DA3.1060901@ti.com>
	<F49CA12D-4DAC-4293-AD4D-FC7EDCEA6993@antoniou-consulting.com>
	<20121101110418.GF410@arwen.pp.htv.fi>
	<3AF5A6FC-61D9-40CA-85B3-81C2C788CB76@antoniou-consulting.com>
	<20121101124025.GA12489@arwen.pp.htv.fi>
	<A16B0ABF-AB9D-4F48-88BD-96F123FFEF2F@antoniou-consulting.com>
	<20121101131609.GC12489@arwen.pp.htv.fi>
	<E911D0B7-0397-4ED0-828E-71F9531E84E0@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E911D0B7-0397-4ED0-828E-71F9531E84E0@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: balbi@ti.com, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

> What they want, and what every user wants, is I plug this board in, a=
nd
> the driver make sure everything is loaded and ready. No, the end user=
s
> don't want to see any of the implementation details of how the bitfil=
e
> is transported; the driver can handle it.

That doesn't necessarily make it a bus merely some kind of hotplug
enumeration of devices. That should all work properly both for devices
and busses with spi and i=C2=B2c as the final bits needed for it got fi=
xed
some time ago.

In an ideal world you don't want to be writing custom drivers for stuff=
=2E
If your cape routes an i=C2=B2c serial device to the existing system i=C2=
=B2c
busses then you want to just create an instance of any existing driver =
on
the existing i=C2=B2c bus not create a whole new layer of goop.

It does need to do the plumbing and resource management for the plumbin=
g
but thats not the same as being a bus.

Alan
