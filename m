From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 0/5] Sensor drivers for OMAP3430SDP and LDP camera
Date: Wed, 4 Mar 2009 16:28:00 -0800
Message-ID: <200903041628.00828.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE89442E296F97@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE89442E296F97@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Menon, Nishanth" <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 04 March 2009, Aguirre Rodriguez, Sergio Alberto wrote:
> 
> > I'd much rather see these drivers just use the regulator
> > framework to switch any sensor power rails on/off.
> 
> Hi,
> 
> Sounds interesting.
> 
> Is there any documentation on how to use this?

Documentation/DocBook/regulator.tmpl
Documentation/power/regulator/*

I don't quite know how clear that is; the framework is still
sorting itself out, a bit.  The 2.6.30 kernel has some updates
to programming interfaces, few of which should matter to any
sensor code ... sensors would be "consumers" in that framework,
calling regulator_get() and friends.

The tricksy bits would be coupling the regulators to the
sensor device nodes in the board-specfiic setup code.  At
some point I expect to see some cases where that setup needs
framework updates, but so far that hasn't happened.

- Dave


