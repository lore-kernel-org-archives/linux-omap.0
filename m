From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: Sensors and the input layer (was Re: [RFC] [PATCH V2 1/2] input:
 CMA3000 Accelerometer driver)
Date: Tue, 31 Aug 2010 19:24:20 +0200
Message-ID: <AANLkTi=G0m-kdET6PevFmw4DBkha1yG+FiqmiXUvdSnK@mail.gmail.com>
References: <36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
 <20100830214025.2f9677a1@lxorguk.ukuu.org.uk> <20100830204412.GA28711@core.coreip.homeip.net>
 <AANLkTims1CagvPZQjTmYrOVi8REeLVbyyt3kEY_tsCtx@mail.gmail.com>
 <20100830214355.GB28865@core.coreip.homeip.net> <AANLkTinPConD62Ky7mvMn2ZgS=V9+Q5YUdaF5Vma8mn+@mail.gmail.com>
 <20100830224352.GF28865@core.coreip.homeip.net> <20100831104446.321fd4f4@lxorguk.ukuu.org.uk>
 <20100831161730.GA30947@core.coreip.homeip.net> <20100831175937.70a59a91@lxorguk.ukuu.org.uk>
 <20100831170923.GB30947@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100831170923.GB30947@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <me@felipebalbi.com>, Hemanth V <hemanthv@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, "kai.svahn@nokia.com" <kai.svahn@nokia.com>, "matthias.nyman@nokia.com" <matthias.nyman@nokia.com>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
List-Id: linux-omap@vger.kernel.org

IMHO I think sensors no more can be considered as non-input-devices.
Things changed too much in recent years. Input "sources" have now a
very different use as before (smartphones, Tablets and handheld
devices...)
They all have much inputs that come mostly from sensors.

So the definition of an input device is something that the user can
interact on it ?
Maybe we should consider input devices to be made from 1 to N sensors
with some filtering blocks which only expose the useful data.

If we think like this an input device can be made from sub parts which
can be bare sensors. (Many sensors are exposed as
Human.Interface.Devices which are mainly input devices)

i
