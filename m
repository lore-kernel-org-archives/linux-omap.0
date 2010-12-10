From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: remove file handling functions for loader
Date: Fri, 10 Dec 2010 12:43:11 -0600
Message-ID: <AANLkTimttTM=OA=7zQ0H=j_YeM6JCTAKecvwoY4c6Fox@mail.gmail.com>
References: <1291702146-17866-1-git-send-email-omar.ramirez@ti.com>
	<20101208222642.GA31802@kroah.com>
	<AANLkTikcuqWbV1xGhirL65YKRjVW=2JcdYw272a0AJSN@mail.gmail.com>
	<20101208230802.GA8176@kroah.com>
	<AANLkTinGsYVTPV-kQHkA7U20pGX86Z-t46AGBe3pEkO7@mail.gmail.com>
	<20101208234940.GA11587@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101208234940.GA11587@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Nishanth Menon <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ernesto Ramos Falcon <ernesto@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, Rene Sapiens <rene.sapiens@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 8, 2010 at 5:49 PM, Greg KH <greg@kroah.com> wrote:
>> BTW, I don't expect this pushed through staging yet, I need to inclu=
de
>> it to my branch first and then I'll send a pull request with the pil=
e
>> of patches. Sorry for the misunderstanding and thanks for the review=
=2E
>
> Well, don't send me patches you don't want me to apply without a big =
"DO
> NOT APPLY" in them, otherwise I might try to :)

Will do.

> Then mess with the firmware symlink in userspace, don't have the driv=
er
> have to worry about it.

Ok, agree.

> That would be good. =A0Again, you can put whatever firmware image you=
 want
> in that location if you wish to use different ones. =A0That is for
> userspace to do, not have the kernel worry about.

Agree.

Regards,

Omar
