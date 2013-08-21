From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 2/3] usb: phy: Add Qualcomm SS-USB and HS-USB drivers
 for DWC3 core
Date: Wed, 21 Aug 2013 16:06:04 +0300
Message-ID: <1377090364.15070.13.camel@iivanov-dev.int.mm-sol.com>
References: <1376992565-22292-1-git-send-email-iivanov@mm-sol.com>
	 <1376992565-22292-3-git-send-email-iivanov@mm-sol.com>
	 <20130820122907.GU26587@radagast>
	 <1377005543.26268.22.camel@iivanov-dev.int.mm-sol.com>
	 <20130820133712.GC26587@radagast>
	 <1377007751.26268.27.camel@iivanov-dev.int.mm-sol.com>
	 <20130820143319.GG26587@radagast>
	 <1377010458.26268.30.camel@iivanov-dev.int.mm-sol.com>
	 <8691FDFE-326E-4198-838A-202D9EC988E1@codeaurora.org>
	 <1377011163.31445.30.camel@hornet> <1377018092.31445.42.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377018092.31445.42.camel@hornet>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "idos-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <idos-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>Paul Zimmerman <p>
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-08-20 at 18:01 +0100, Pawel Moll wrote:=20
> On Tue, 2013-08-20 at 16:06 +0100, Pawel Moll wrote:
> > On Tue, 2013-08-20 at 16:01 +0100, Kumar Gala wrote:
> > > On Aug 20, 2013, at 9:54 AM, Ivan T. Ivanov wrote:
> > >=20
> > > >=20
> > > > Hi,=20
> > > >=20
> > > > On Tue, 2013-08-20 at 09:33 -0500, Felipe Balbi wrote:=20
> > > >> On Tue, Aug 20, 2013 at 05:09:11PM +0300, Ivan T. Ivanov wrote=
:
> > > >>> Hi,
> > > >>>=20
> > > >>> On Tue, 2013-08-20 at 08:37 -0500, Felipe Balbi wrote:=20
> > > >>>> Hi,
> > > >>>>=20
> > > >>>> On Tue, Aug 20, 2013 at 04:32:23PM +0300, Ivan T. Ivanov wro=
te:
> > > >>>>>> On Tue, Aug 20, 2013 at 12:56:04PM +0300, Ivan T. Ivanov w=
rote:
> > > >>>>>>> From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> > > >>>>>>>=20
> > > >>>>>>> These drivers handles control and configuration of the HS
> > > >>>>>>> and SS USB PHY transceivers. They are part of the driver
> > > >>>>>>> which manage Synopsys DesignWare USB3 controller stack
> > > >>>>>>> inside Qualcomm SoC's.
> > > >>>>>>>=20
> > > >>>>>>> Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> > > >>>>>>> ---
> > > >>>>>>> drivers/usb/phy/Kconfig           |   11 ++
> > > >>>>>>> drivers/usb/phy/Makefile          |    2 +
> > > >>>>>>> drivers/usb/phy/phy-msm-dwc3-hs.c |  327 ++++++++++++++++=
++++++++++++++++
> > > >>>>>>> drivers/usb/phy/phy-msm-dwc3-ss.c |  374 ++++++++++++++++=
+++++++++++++++++++++
> > > >>>>>>=20
> > > >>>>>> please rename these PHY drivers, they have nothing to do w=
ith DWC3. PHYs
> > > >>>>>> don't care about the USB controller.
> > > >>>>>=20
> > > >>>>> I think they are SNPS DesignWare PHY's, additionally
> > > >>>>> wrapped with Qualcomm logic. I could substitute "dwc3"
> > > >>>>> with just "dw", which will be more correct.
> > > >>>>=20
> > > >>>> alright, thank you. Let's add Paul to the loop since he migh=
t have very
> > > >>>> good insight in the synopsys PHYs.
> > > >>>>=20
> > > >>>> mental note: if any other platform shows up with Synopsys PH=
Y, ask them
> > > >>>> to use this driver instead :-)
> > > >>>=20
> > > >>> I really doubt that this will bi possible. Control of the PHY=
's is
> > > >>> not directly trough ULPI, UTMI or PIPE3 interfaces, but troug=
h
> > > >>> QSCRATCH registers, which of course is highly Qualcomm specif=
ic.
> > > >>=20
> > > >> isn't it a memory mapped IP ? doesn't synopsys provide their o=
wn set of
> > > >> registers ?
> > > >=20
> > > > From what I see it is not directly mapped. How QSCRATCH write a=
nd
> > > > reads transactions are translated to DW IP is unclear to me.
> > >=20
> > >=20
> > > I think the question is how does SW access them?
> >=20
> > I afraid the answer may be: "it depends on the SOC". In my past I h=
ad to
> > initialize a (SATA) PHY by implementing a software JTAG state machi=
ne,
> > as the PHY's registers were not memory mapped *at all*. And the IP
> > itself came from Synopsys, Cadence or yet another EDA company...
>=20
> Having said all that... If the PHY's spec at least defined layout of =
the
> registers in question and driver was using regmap API to talk to the
> device (initially regmap-mmio), it has some chances to become univers=
al.
> The SOCs designed like "my" one would have to provide a custom regmap
> implementation.

Sound reasonable. Unfortunately I don't have PHY's IP spec.=20

Regards,
Ivan

>=20
> Pawe=C5=82
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
