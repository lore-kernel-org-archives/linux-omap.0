From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH v4 2/3] usb: phy: Add Qualcomm SS-USB and HS-USB drivers
 for DWC3 core
Date: Tue, 20 Aug 2013 18:01:32 +0100
Message-ID: <1377018092.31445.42.camel@hornet>
References: <1376992565-22292-1-git-send-email-iivanov@mm-sol.com>
	 <1376992565-22292-3-git-send-email-iivanov@mm-sol.com>
	 <20130820122907.GU26587@radagast>
	 <1377005543.26268.22.camel@iivanov-dev.int.mm-sol.com>
	 <20130820133712.GC26587@radagast>
	 <1377007751.26268.27.camel@iivanov-dev.int.mm-sol.com>
	 <20130820143319.GG26587@radagast>
	 <1377010458.26268.30.camel@iivanov-dev.int.mm-sol.com>
	 <8691FDFE-326E-4198-838A-202D9EC988E1@codeaurora.org>
	 <1377011163.31445.30.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1377011163.31445.30.camel@hornet>
Sender: linux-doc-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>, "balbi@ti.com" <balbi@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Mark Rutland <Mark.Rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob@landley.net" <rob@landley.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "idos@codeaurora.org" <idos@codeaurora.org>, "mgautam@codeaurora.org" <mgautam@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Paul
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-08-20 at 16:06 +0100, Pawel Moll wrote:
> On Tue, 2013-08-20 at 16:01 +0100, Kumar Gala wrote:
> > On Aug 20, 2013, at 9:54 AM, Ivan T. Ivanov wrote:
> >=20
> > >=20
> > > Hi,=20
> > >=20
> > > On Tue, 2013-08-20 at 09:33 -0500, Felipe Balbi wrote:=20
> > >> On Tue, Aug 20, 2013 at 05:09:11PM +0300, Ivan T. Ivanov wrote:
> > >>> Hi,
> > >>>=20
> > >>> On Tue, 2013-08-20 at 08:37 -0500, Felipe Balbi wrote:=20
> > >>>> Hi,
> > >>>>=20
> > >>>> On Tue, Aug 20, 2013 at 04:32:23PM +0300, Ivan T. Ivanov wrote=
:
> > >>>>>> On Tue, Aug 20, 2013 at 12:56:04PM +0300, Ivan T. Ivanov wro=
te:
> > >>>>>>> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> > >>>>>>>=20
> > >>>>>>> These drivers handles control and configuration of the HS
> > >>>>>>> and SS USB PHY transceivers. They are part of the driver
> > >>>>>>> which manage Synopsys DesignWare USB3 controller stack
> > >>>>>>> inside Qualcomm SoC's.
> > >>>>>>>=20
> > >>>>>>> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > >>>>>>> ---
> > >>>>>>> drivers/usb/phy/Kconfig           |   11 ++
> > >>>>>>> drivers/usb/phy/Makefile          |    2 +
> > >>>>>>> drivers/usb/phy/phy-msm-dwc3-hs.c |  327 ++++++++++++++++++=
++++++++++++++
> > >>>>>>> drivers/usb/phy/phy-msm-dwc3-ss.c |  374 ++++++++++++++++++=
+++++++++++++++++++
> > >>>>>>=20
> > >>>>>> please rename these PHY drivers, they have nothing to do wit=
h DWC3. PHYs
> > >>>>>> don't care about the USB controller.
> > >>>>>=20
> > >>>>> I think they are SNPS DesignWare PHY's, additionally
> > >>>>> wrapped with Qualcomm logic. I could substitute "dwc3"
> > >>>>> with just "dw", which will be more correct.
> > >>>>=20
> > >>>> alright, thank you. Let's add Paul to the loop since he might =
have very
> > >>>> good insight in the synopsys PHYs.
> > >>>>=20
> > >>>> mental note: if any other platform shows up with Synopsys PHY,=
 ask them
> > >>>> to use this driver instead :-)
> > >>>=20
> > >>> I really doubt that this will bi possible. Control of the PHY's=
 is
> > >>> not directly trough ULPI, UTMI or PIPE3 interfaces, but trough
> > >>> QSCRATCH registers, which of course is highly Qualcomm specific=
=2E
> > >>=20
> > >> isn't it a memory mapped IP ? doesn't synopsys provide their own=
 set of
> > >> registers ?
> > >=20
> > > From what I see it is not directly mapped. How QSCRATCH write and
> > > reads transactions are translated to DW IP is unclear to me.
> >=20
> >=20
> > I think the question is how does SW access them?
>=20
> I afraid the answer may be: "it depends on the SOC". In my past I had=
 to
> initialize a (SATA) PHY by implementing a software JTAG state machine=
,
> as the PHY's registers were not memory mapped *at all*. And the IP
> itself came from Synopsys, Cadence or yet another EDA company...

Having said all that... If the PHY's spec at least defined layout of th=
e
registers in question and driver was using regmap API to talk to the
device (initially regmap-mmio), it has some chances to become universal=
=2E
The SOCs designed like "my" one would have to provide a custom regmap
implementation.

Pawe=C5=82


