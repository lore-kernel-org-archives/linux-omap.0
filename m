From: "Kamat, Nishant" <nskamat@ti.com>
Subject: RE: FSUSB Port on OMAP2430 SDP
Date: Wed, 1 Aug 2007 13:15:35 -0500
Message-ID: <6E3DC4E6E09EF440B55B7AD683608D6D017BA969@dlee13.ent.ti.com>
References: <78d6ed630707312218w60198970rd8e98f1feb8261f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <78d6ed630707312218w60198970rd8e98f1feb8261f0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Amit Gupta <amitjobs05@gmail.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Amit,

> -----Original Message-----
> From: Amit Gupta
> Sent: Wednesday, August 01, 2007 12:19 AM
>=20
> As per the reference manual, I saw the FSUSB port 0 being OTG=20
> port which has connections with FS - host controller and FS-=20
> device controller. Also as you mentioned the routing of=20
> signals beteween OTG and mini AB receptacle J51 happens=20
> through ISP 1301(OTG transceiver). I have included :-
>=20
> CONFIG_USB_OTG , CONFIG_USB_OHCI_HCD,=20
> CONFIG_USB_OMAP24XX_FS_PORT0 , CONFIG_ARCH_OMAP243X and=20
> CONFIG_ISP1301_OMAP
>=20

Don't enable CONFIG_USB_OTG. That won't work without the gadget side =
driver, plus its not tested.

Also don't enable CONFIG_USB_MUSB_HDRC (Mentor/Inventra HS USB), in case =
you have, as it uses the same pins as FS USB port 0.

> As of now my device is not getting powered ON( the mass=20
> storage poer LED is not glowing which reqires 5 volts ) =20
> itself and its not registering any of the interrupts. Kindly=20
> tell me the reason for the same
>=20

Try plugging in some other device, or a powered hub. The board might =
provide enough current for your device.

>=20
> Also if possible, kindly let me know if I can configure any=20
> of the other ports on OMAP 2430 SDP v4.0 as host ports.
>=20
> Thanks & Regards
>=20
> Aman
>=20
>=20
>=20
> On 7/31/07, Kipisz, Steven <s-kipisz2@ti.com> wrote:
> >
> > Amit,
> > I think that port is either host or client.  You have to=20
> choose either=20
> > host or Gadget, and not OTG.
> >
> > Make sure you have the ISP1301 enabled in the I2C drivers.  Do not=20
> > select the TWL4030 USB transceiver.
> >
> > Under USB, make sure you only have host selected (deselect Gadget).
> > Also make sure you select OHCI and NOT the Inventra.
> >
> > Steve K.
> >
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> > [mailto: linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of=20
> > Amit Gupta
> > Sent: Monday, July 30, 2007 2:34 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: FSUSB Port on OMAP2430 SDP
> >
> > Hello
> >
> > I am using OMAP 2430 SDP v4.0 and trying to configure the=20
> FS USB port
> > 0(J51
> > on the main board) as host. I am using kernel v2.6.14
> >
> >
> >
> > I am not getting any of the interrupts after connecting the=20
> cable/and=20
> > device. And the device (mass storage device) is not getting=20
> configured.
> >
> >
> >
> > *        Does the port need to configure as OTG port and=20
> then make it as
> > host? That's how it seems to me from the code.
> >
> >
> >
> > *        Do we need to make any changes in the files for=20
> making it to
> > work?
> > Also kindly send the config file for the same.
> >
> > Thanks & Regards
> >
> > Amit
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
