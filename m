From: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Subject: Re: Sensors and the input layer (was Re: [RFC] [PATCH V2 1/2] input:
 CMA3000 Accelerometer driver)
Date: Tue, 31 Aug 2010 19:14:57 +0100
Message-ID: <4C7D46A1.7070101@jic23.retrosnub.co.uk>
References: <36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com> <20100830214025.2f9677a1@lxorguk.ukuu.org.uk> <20100830204412.GA28711@core.coreip.homeip.net> <AANLkTims1CagvPZQjTmYrOVi8REeLVbyyt3kEY_tsCtx@mail.gmail.com> <20100830214355.GB28865@core.coreip.homeip.net> <AANLkTinPConD62Ky7mvMn2ZgS=V9+Q5YUdaF5Vma8mn+@mail.gmail.com> <20100830224352.GF28865@core.coreip.homeip.net> <20100831104446.321fd4f4@lxorguk.ukuu.org.uk> <20100831161730.GA30947@core.coreip.homeip.net> <20100831175937.70a59a91@lxorguk.ukuu.org.uk> <20100831170923.GB30947@core.coreip.homeip.net> <AANLkTi=G0m-kdET6PevFmw4DBkha1yG+FiqmiXUvdSnK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=G0m-kdET6PevFmw4DBkha1yG+FiqmiXUvdSnK@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <me@felipebalbi.com>, Hemanth V <hemanthv@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, "kai.svahn@nokia.com" <kai.svahn@nokia.com>, "matthias.nyman@nokia.com" <matthias.nyman@nokia.com>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
List-Id: linux-omap@vger.kernel.org

On 08/31/10 18:24, Mohamed Ikbel Boulabiar wrote:
> IMHO I think sensors no more can be considered as non-input-devices.
> Things changed too much in recent years. Input "sources" have now a
> very different use as before (smartphones, Tablets and handheld
> devices...)
> They all have much inputs that come mostly from sensors.
> 
> So the definition of an input device is something that the user can
> interact on it ?
Sadly it is no where near as clean a definition as we would like.
There are too many fuzzy regions.  Lots of the devices are used for
both consumer devices and for other forms of high end input.  A lot
of consumer devices use general purpose ADCs at a tiny percentage of
their maximum data rates because they are cheap and standard.
> Maybe we should consider input devices to be made from 1 to N sensors
> with some filtering blocks which only expose the useful data.
That's what you get via input (to a certain extent).  But a lot of what
people want in applications is derived data and some of the algorithms
to do that are very complex and certainly should not be in the kernel.

Again this may be a case for using uinput to push your derived data back
into kernel space.  (Did I mention that I rather like uinput now I've
started playing with it :)
> 
> If we think like this an input device can be made from sub parts which
> can be bare sensors. (Many sensors are exposed as
> Human.Interface.Devices which are mainly input devices)
HID is just fine if the aggregation is nicely handled by a separate
processor on the device (which is what is actually happening). It
is large, messy and an enormous number of devices abuse it for things
that aren't input.  They have exactly the same issue that Dmitry
is trying to avoid.  Just because you can use an interface to handle
your data, doesn't make it the right thing to do!

Hence HID is a very nice illustration in lots of ways ;)

Jonathan
