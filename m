From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP1: camera core : Use platform driver structure
Date: Fri, 24 Feb 2006 08:28:49 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5047B4D5F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, "Zhang, Jian" <jzhang@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

? Just because the platform bus is convenient for PC's doesn't
necessarily mean its right for all.  One nice property of using the
platform bus is the community keeps it up to date.  Perhaps it makes it
also slightly easier to port code from device to device if they all use
the same bus code.

One reason we have kept the OMAP bus structure is that it does reflect
the hardware and it allows for grouping of devices.  For power calls
this provides some way to group devices with their true buses.

The current buses reflect real buses and clock domains for peripherals.
There are controllable aspects per bus and definite per clock domain
controllable attributes which effect devices.  How effectively these
have been utilized in open tree's is something else.

Regards,
Richard W.

> -----Original Message-----
> From: =
linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.com
>
[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.co=
m
]
> On Behalf Of Komal Shah
> Sent: Friday, February 24, 2006 4:36 AM
> To: Zhang, Jian; linux-omap-open-source@linux.omap.com
> Subject: RE: [PATCH] OMAP1: camera core : Use platform driver
structure
>=20
> --- "Zhang, Jian" <jzhang@ti.com> wrote:
>=20
> > Komal,
> >
> > Is there any guideline on the way a driver is registered with LDM?
> > e.g.
> > via driver_register() or platform_driver_register()? We are now
> > always
> > using omap_driver_register() which is a wrapper to
driver_register().
> >
> > Again, is this the trend to move the bulk of init code to probe()
> > function?
>=20
> This one is very tricky question :) May be GregKH and RMK can do
better
> justice :)
>=20
> But I don't understand the need for you to wrap-up the arch specific
> register function around driver_register, may be you were defining
your
> bus type? I also feel, that this wrapper came much before in your
> kernel (2.6.9 and .8 series) than the platform_driver addition.
>=20
> platform_driver structure does wraps the all the members except the
> devid, bus and shared clocks, and devid can be assigned using the
> platform_device structure, and bus assignment may not be required as
we
> connect them under common platform bus.
>=20
> And platform_driver_register does call driver_register similar to your
> omap_driver_register with few more wrapper functions inside. But as
> platform_driver interface wrappers was added recently (Nov'05) by RMK,
> which allows to platform device driver methods to be passed a platform
> device structure instead a plain device structure and which will
> introduce casting in every platform driver. (Last sentence is copied
> from RMK's patch comment :) ).
>=20
> But using driver_register directly doesn't break anything yet.
>=20
> >
> > If these are what other drivers do, I certainly don't want to see
> > camera
> > driver being different.
> >
>=20
> I don't see this as 'must have' kind of things, but if I look back at
> what my camera patch gained having those modifications as of current
> state of usage for OMAP1610/1710 camera arch, it is 'nothing' except
> (void *) casting.
>=20
> Just FYI.
>=20
> [1] http://lwn.net/Articles/161236/
> [2] http://lwn.net/Articles/158747/
> [3] http://lwn.net/Articles/158781/
>=20
>=20
> ---Komal Shah
> http://komalshah.blogspot.com/
>=20
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
