From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: remove file handling functions for loader
Date: Wed, 8 Dec 2010 17:02:20 -0600
Message-ID: <AANLkTikcuqWbV1xGhirL65YKRjVW=2JcdYw272a0AJSN@mail.gmail.com>
References: <1291702146-17866-1-git-send-email-omar.ramirez@ti.com>
	<20101208222642.GA31802@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101208222642.GA31802@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Nishanth Menon <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ernesto Ramos Falcon <ernesto@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, Rene Sapiens <rene.sapiens@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Dec 8, 2010 at 4:26 PM, Greg KH <greg@kroah.com> wrote:
> On Tue, Dec 07, 2010 at 12:09:06AM -0600, Omar Ramirez Luna wrote:
>> Instead use request_firmware and friends to get a valid firmware
>> image.
>>
>> Right now the image is supplied dynamically through udev and the
>> following rule:
>>
>> KERNEL=3D=3D"omap-dsp", SUBSYSTEM=3D=3D"firmware", ACTION=3D=3D"add"=
, =A0 =A0 \
>> =A0 =A0 =A0 RUN+=3D"/bin/sh -c 'echo 1 > /sys/$DEVPATH/loading; =A0 =
=A0 =A0 \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat $FIRMWARE > /sys/$DEVPATH/data; =A0 =
=A0 =A0 =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > /sys/$DEVPATH/loading'"
>
> Why do you need a custom firmware rule?

It was meant as an example, when I compiled my minimal file system it
didn't supply the firmware.sh script nor created /lib/firmware... I
thought that not everybody would have the firmware.sh, so I just
provided a sample rule.

> =A0Why doesn't the default  firmware loading rule that comes with ude=
v work properly for you?
> What are you needing different here that works properly for all other=
 drivers?

firmware.sh under /lib/udev/ and dsp binaries installed under
/lib/firmware/, my rule is the brute version of firmware.sh so nothing
different in the script.

Probably the only change would be to supply the firmware name only, as
of now the insmod parameter requires the entire path, e.g.:

insmod bridgedriver.ko base_img=3D/lib/dsp/baseimage.dof

if using firmware.sh and placing firmware files under /lib/firmware/, t=
hen

insmod bridgedriver.ko base_img=3Dbaseimage.dof

Should be enough.

Regards,

Omar
