From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: tidspbridge: remove file handling functions
 for loader
Date: Wed, 8 Dec 2010 15:49:40 -0800
Message-ID: <20101208234940.GA11587@kroah.com>
References: <1291702146-17866-1-git-send-email-omar.ramirez@ti.com>
 <20101208222642.GA31802@kroah.com>
 <AANLkTikcuqWbV1xGhirL65YKRjVW=2JcdYw272a0AJSN@mail.gmail.com>
 <20101208230802.GA8176@kroah.com>
 <AANLkTinGsYVTPV-kQHkA7U20pGX86Z-t46AGBe3pEkO7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45194 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033Ab0LHXup (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 18:50:45 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinGsYVTPV-kQHkA7U20pGX86Z-t46AGBe3pEkO7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Nishanth Menon <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ernesto Ramos Falcon <ernesto@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, Rene Sapiens <rene.sapiens@ti.com>

On Wed, Dec 08, 2010 at 05:32:50PM -0600, Ramirez Luna, Omar wrote:
> On Wed, Dec 8, 2010 at 5:08 PM, Greg KH <greg@kroah.com> wrote:
> > On Wed, Dec 08, 2010 at 05:02:20PM -0600, Ramirez Luna, Omar wrote:
> >> Hi,
> >>
> >> On Wed, Dec 8, 2010 at 4:26 PM, Greg KH <greg@kroah.com> wrote:
> >> > On Tue, Dec 07, 2010 at 12:09:06AM -0600, Omar Ramirez Luna wrot=
e:
> >> >> Instead use request_firmware and friends to get a valid firmwar=
e
> >> >> image.
> >> >>
> >> >> Right now the image is supplied dynamically through udev and th=
e
> >> >> following rule:
> >> >>
> >> >> KERNEL=3D=3D"omap-dsp", SUBSYSTEM=3D=3D"firmware", ACTION=3D=3D=
"add", =A0 =A0 \
> >> >> =A0 =A0 =A0 RUN+=3D"/bin/sh -c 'echo 1 > /sys/$DEVPATH/loading;=
 =A0 =A0 =A0 \
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat $FIRMWARE > /sys/$DEVPATH/data;=
 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > /sys/$DEVPATH/loading'"
> >> >
> >> > Why do you need a custom firmware rule?
> >>
> >> It was meant as an example, when I compiled my minimal file system=
 it
> >> didn't supply the firmware.sh script nor created /lib/firmware... =
I
> >> thought that not everybody would have the firmware.sh, so I just
> >> provided a sample rule.
> >
> > So, can I remove this from the changelog comment, as it's not reall=
y
> > needed at all?
>=20
> Yes it can be removed.
>=20
> BTW, I don't expect this pushed through staging yet, I need to includ=
e
> it to my branch first and then I'll send a pull request with the pile
> of patches. Sorry for the misunderstanding and thanks for the review.

Well, don't send me patches you don't want me to apply without a big "D=
O
NOT APPLY" in them, otherwise I might try to :)

> >> insmod bridgedriver.ko base_img=3Dbaseimage.dof
> >
> > Ick, why use a module parameter name at all? =A0Why is this "specia=
l" and
> > different from all other firmware users? =A0They don't have to manu=
ally
> > specify a file name, the driver does that.
>=20
> The thing is that there are N number of firmwares, e.g.:
>=20
> There is the official and usable firmware to play with multimedia
> "baseimage.dof"
>=20
> But there are also minimal firmwares to just ping or swap buffers wit=
h
> the dsp, when you just want to play around with basic features.

Then mess with the firmware symlink in userspace, don't have the driver
have to worry about it.

> > Please fix up the patch to not require a module parameter, distros =
hate
> > them, and users hate them even more.
>=20
> The driver is the one requiring the parameter (it was already this
> way), this patch doesn't introduce any parameter. I'll check what can
> be done and if nobody rejects I'll use the baseimage.dof  as firmware
> by default.

That would be good.  Again, you can put whatever firmware image you wan=
t
in that location if you wish to use different ones.  That is for
userspace to do, not have the kernel worry about.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
