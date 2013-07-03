From: "Patel, Satish" <satish.patel@ti.com>
Subject: RE: [PATCH v9 0/8] Generic PHY Framework
Date: Wed, 3 Jul 2013 09:32:58 +0000
Message-ID: <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E@DBDE04.ent.ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1372247257-30186-1-git-send-email-kishon@ti.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, "swarren@nvidia.com" <swarren@nvidia.com>, "sylvester.nawrocki@gmail.com" <sylvester.nawrocki@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "mchehab@redhat.com" <mchehab@redhat.com>, "cesarb@cesarb.net" <cesarb@cesarb.net>, "davem@davemloft.net" <davem@davemloft.net>, "Nayak, Rajendra" <rnayak@ti.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "Cherian, George" <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

> -----Original Message-----
> From: ABRAHAM, KISHON VIJAY
> Sent: Wednesday, June 26, 2013 5:17 PM
> To: grant.likely@linaro.org; tony@atomide.com; Balbi, Felipe; ABRAHAM=
,
> KISHON VIJAY; arnd@arndb.de; swarren@nvidia.com;
> sylvester.nawrocki@gmail.com; linux-kernel@vger.kernel.org; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> usb@vger.kernel.org; gregkh@linuxfoundation.org; akpm@linux-
> foundation.org
> Cc: rob.herring@calxeda.com; rob@landley.net; linux@arm.linux.org.uk;
> benoit.cousson@linaro.org; mchehab@redhat.com; cesarb@cesarb.net;
> davem@davemloft.net; Nayak, Rajendra; shawn.guo@linaro.org; Shilimkar=
,
> Santosh; devicetree-discuss@lists.ozlabs.org; linux-
> doc@vger.kernel.org; Nori, Sekhar; Krishnamoorthy, Balaji T; Cherian,
> George
> Subject: [PATCH v9 0/8] Generic PHY Framework
>=20
> Added a generic PHY framework that provides a set of APIs for the PHY
> drivers
> to create/destroy a PHY and APIs for the PHY users to obtain a
> reference to
> the PHY with or without using phandle.
>=20
> This framework will be of use only to devices that uses external PHY
> (PHY
> functionality is not embedded within the controller).
>=20
> The intention of creating this framework is to bring the phy drivers
> spread
> all over the Linux kernel to drivers/phy to increase code re-use and
> to
> increase code maintainability.

I would like to use this framework for a smart-card controller connecte=
d to a
smart-card phy. I have some questions and would like to get feedback on=
 the same.

I am using =93TDA8026" Smartcard PHY from NXP. Here is the link for dat=
asheet
and app note for the same. The smart card controller is inside the TI S=
oC
I am working with.

Datasheet :=20
www.nxp.com/documents/data_sheet/TDA8026.pdf?

Appnote :
http://www.nxp.com/documents/application_note/AN10724.pdf

The TI SoC details are not public (yet). I can provide details to you o=
ffline.

Brief about operation:
-	The controller can work with and without a PHY
-	When not using PHY, it is limited to talking to a single
	smart card. There is also a need to put external de-activation logic
	on card removal for this case.
-	With a PHY you can use more than one smart card.
-	Phy has 5 slots :  1 for smart card (credit/debit/other card with chi=
p)=20
      and others for SAM =96 SIM like modules
- 	Once the PHY is initialized, there are some operations that the cont=
roller
	can request of the PHY like:
	- Card configurations  - set voltage
	- Activation of card
	- ATR =96 Answer to reset
	- Warm reset
	- ADPU exchange
	- Deactivation ( Normal/Emergency)
- 	In the mode when smartcard controller talks directly to the card	wit=
hout the need
	for a PHY, all the above operations will be carried	out by the control=
ler itself

My current thought process is to make the controller driver provide the=
 user interface
and talk to the PHY using the generic PHY framework you proposed. In th=
e case where there
is no PHY, my idea is to create a "dummy" PHY which uses the controller=
 functionality itself.

What I seem to be missing from the PHY framework is support for event d=
etection and generic
read/write API which will enable the controller to talk to the PHY for =
the operations listed
above and also react to events from the PHY.

Is there a reason why such functionality has not been included. If it w=
as only a case
of lack of use case, then do you think it will be useful to extend the =
framework to add
such functionality? I can help with the development.

Thanks,
Satish

