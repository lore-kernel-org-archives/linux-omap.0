From: Laine Walker-Avina <lwalkera-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH RFC 2/2] usb: ehci-omap: add suspend/resume support
Date: Thu, 7 Oct 2010 12:47:58 -0700
Message-ID: <AANLkTi=EoEUDsSVjo7somYESe6k8ziB+FGKrnMAZ2OAC@mail.gmail.com>
References: <1273762822-23073-2-git-send-email-gadiyar@ti.com>
	<Pine.LNX.4.44L0.1005131305320.1731-100000@iolanthe.rowland.org>
	<5A47E75E594F054BAF48C5E4FC4B92AB0322D7D8AA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D8AA-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 7:01 AM, Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org> wrote:
> Alan Stern wrote:
>> On Thu, 13 May 2010, Anand Gadiyar wrote:
>>
>> > Add support for suspend and resume to the ehci-omap driver.
>> > Added routines for platform_driver suspend/resume and
>> > wrappers around ehci_bus_suspend/resume.
>>
>> > +#ifdef CONFIG_PM
>> >
>> /*------------------------------------------------------------------=
-------*/
>> > +static int ehci_omap_dev_suspend(struct device *dev)
>> > +{
>> > + =C2=A0 struct ehci_hcd_omap *omap =3D dev_get_drvdata(dev);
>> > +
>> > + =C2=A0 if (!omap->suspended)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ehci_omap_enable(omap, 0);
>> > + =C2=A0 return 0;
>> > +}
>> > +
>> > +static int ehci_omap_dev_resume(struct device *dev)
>> > +{
>> > + =C2=A0 struct ehci_hcd_omap *omap =3D dev_get_drvdata(dev);
>> > +
>> > + =C2=A0 if (omap->suspended)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ehci_omap_enable(omap, 1);
>> > + =C2=A0 return 0;
>> > +}
>> > +
>> > +static int ehci_omap_bus_suspend(struct usb_hcd *hcd)
>> > +{
>> > + =C2=A0 struct usb_bus *bus =3D hcd_to_bus(hcd);
>> > + =C2=A0 int ret;
>> > +
>> > + =C2=A0 ret =3D ehci_bus_suspend(hcd);
>> > +
>> > + =C2=A0 ehci_omap_dev_suspend(bus->controller);
>> > +
>> > + =C2=A0 return ret;
>> > +}
>> > +static int ehci_omap_bus_resume(struct usb_hcd *hcd)
>> > +{
>> > + =C2=A0 struct usb_bus *bus =3D hcd_to_bus(hcd);
>> > + =C2=A0 int ret;
>> > +
>> > + =C2=A0 ehci_omap_dev_resume(bus->controller);
>> > +
>> > + =C2=A0 ret =3D ehci_bus_resume(hcd);
>> > +
>> > + =C2=A0 return ret;
>> > +}
>>
>> You could use the runtime-PM interface instead of explicitly suspend=
ing
>> and resuming the controller. =C2=A0It is now standard.
>>
>
> Will work on this. I'll be out for a while, so it could be some time
> before I repost.
>
> Thanks,
> Anand

Any more developments on this?

--=20
Laine Walker-Avina
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
