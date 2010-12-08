From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: tidspbridge: remove file handling functions
 for loader
Date: Wed, 8 Dec 2010 15:08:02 -0800
Message-ID: <20101208230802.GA8176@kroah.com>
References: <1291702146-17866-1-git-send-email-omar.ramirez@ti.com>
 <20101208222642.GA31802@kroah.com>
 <AANLkTikcuqWbV1xGhirL65YKRjVW=2JcdYw272a0AJSN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:47244 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107Ab0LHXIy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 18:08:54 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikcuqWbV1xGhirL65YKRjVW=2JcdYw272a0AJSN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Nishanth Menon <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ernesto Ramos Falcon <ernesto@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, Rene Sapiens <rene.sapiens@ti.com>

On Wed, Dec 08, 2010 at 05:02:20PM -0600, Ramirez Luna, Omar wrote:
> Hi,
>=20
> On Wed, Dec 8, 2010 at 4:26 PM, Greg KH <greg@kroah.com> wrote:
> > On Tue, Dec 07, 2010 at 12:09:06AM -0600, Omar Ramirez Luna wrote:
> >> Instead use request_firmware and friends to get a valid firmware
> >> image.
> >>
> >> Right now the image is supplied dynamically through udev and the
> >> following rule:
> >>
> >> KERNEL=3D=3D"omap-dsp", SUBSYSTEM=3D=3D"firmware", ACTION=3D=3D"ad=
d", =A0 =A0 \
> >> =A0 =A0 =A0 RUN+=3D"/bin/sh -c 'echo 1 > /sys/$DEVPATH/loading; =A0=
 =A0 =A0 \
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat $FIRMWARE > /sys/$DEVPATH/data; =A0=
 =A0 =A0 =A0 =A0 =A0 \
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > /sys/$DEVPATH/loading'"
> >
> > Why do you need a custom firmware rule?
>=20
> It was meant as an example, when I compiled my minimal file system it
> didn't supply the firmware.sh script nor created /lib/firmware... I
> thought that not everybody would have the firmware.sh, so I just
> provided a sample rule.

So, can I remove this from the changelog comment, as it's not really
needed at all?

> > =A0Why doesn't the default  firmware loading rule that comes with u=
dev work properly for you?
> > What are you needing different here that works properly for all oth=
er drivers?
>=20
> firmware.sh under /lib/udev/ and dsp binaries installed under
> /lib/firmware/, my rule is the brute version of firmware.sh so nothin=
g
> different in the script.
>=20
> Probably the only change would be to supply the firmware name only, a=
s
> of now the insmod parameter requires the entire path, e.g.:
>=20
> insmod bridgedriver.ko base_img=3D/lib/dsp/baseimage.dof
>=20
> if using firmware.sh and placing firmware files under /lib/firmware/,=
 then
>=20
> insmod bridgedriver.ko base_img=3Dbaseimage.dof

Ick, why use a module parameter name at all?  Why is this "special" and
different from all other firmware users?  They don't have to manually
specify a file name, the driver does that.

Please fix up the patch to not require a module parameter, distros hate
them, and users hate them even more.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
