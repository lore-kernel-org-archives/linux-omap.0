From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/20] mfd: Add devm_ apis for mfd_add_devices and
 mfd_release_devices
Date: Thu, 7 Apr 2016 12:42:50 +0100
Message-ID: <20160407114250.GA3323@x1>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
 <1459856912-17859-2-git-send-email-ldewangan@nvidia.com>
 <20160407104403.GZ3323@x1>
 <57063A12.4080200@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57063A12.4080200@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

On Thu, 07 Apr 2016, Laxman Dewangan wrote:

> Hi Lee,
> Thanks for review.
> I will send another patch with incorporating your comments.
>=20
>=20
> On Thursday 07 April 2016 04:14 PM, Lee Jones wrote:
> >On Tue, 05 Apr 2016, Laxman Dewangan wrote:
> >
> >+	if (!ret) {
> >+		*ptr =3D dev;
> >+		devres_add(dev, ptr);
> >+	} else {
> >+		devres_free(ptr);
> >+	}
> >Switch these round.  If you encounter a problem, free and return.  I=
f
> >not, skip the error handling and add the device outside of the if().
>=20
> Like below?
>=20
> if (ret) {
>      devres_free(ptr);
>      return ret;
> }
>=20
> *ptr =3D dev;
> devres_add(dev, ptr);
>=20
> return ret;

This is more in line with what I expect, yes.

> >>+ * Remove all mfd devices added on the device.
> >s/mfd/MFD/
> >
> >'D' already means devices, so here you are saying "devices devices".
> >Please re-word.  Besides, you need to be more specific as to which
> >"devices on the devices" you are detailing, since this sentence
> >doesn't really make a great deal of sense.
> Wanted to say
> Remove all devices added by mfd_add_devices()  from parent device.

Remove all chlid-devices?

> >>+ * Normally this function will not need to be called and the resou=
rce
> >>+ * management code will ensure that the resource is freed.
> >Then what is the purpose of providing it?  Do you have a user?
>=20
> To have pair of release. I have not seen the usage of most of
> devm_*_release() function other than devm_kfree().

Unless you have a need or a user, I would omit this for now.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
