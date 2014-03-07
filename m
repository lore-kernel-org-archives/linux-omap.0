From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v6] phy: omap-usb2: move omap_usb.h from linux/usb/ to
 linux/phy/
Date: Fri, 7 Mar 2014 23:09:02 +0530
Message-ID: <531A0436.3080201@ti.com>
References: <1393846695-14644-1-git-send-email-kishon@ti.com> <1394210888-1587-1-git-send-email-kishon@ti.com> <20140307165043.GC23885@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140307165043.GC23885@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 07 March 2014 10:20 PM, Felipe Balbi wrote:
> On Fri, Mar 07, 2014 at 10:18:08PM +0530, Kishon Vijay Abraham I wrot=
e:
>> No functional change. Moved omap_usb.h from linux/usb/ to linux/phy/=
=2E
>> Also removed the unused members of struct omap_usb (after phy-omap-p=
ipe3
>> started using it's own header file)
>
> does this depend in any other patch ? I get the following when applyi=
ng
> *only* this patch on top of v3.14-rc5:

yeah.. this is for linux-phy tree. I'll take this patch.

Thanks
Kishon

>
> drivers/phy/phy-omap-usb2.c: In function =E2=80=98omap_usb2_suspend=E2=
=80=99:
> drivers/phy/phy-omap-usb2.c:106:21: error: =E2=80=98struct omap_usb=E2=
=80=99 has no member named =E2=80=98is_suspended=E2=80=99
>    if (suspend && !phy->is_suspended) {
>                       ^
> drivers/phy/phy-omap-usb2.c:109:6: error: =E2=80=98struct omap_usb=E2=
=80=99 has no member named =E2=80=98is_suspended=E2=80=99
>     phy->is_suspended =3D 1;
>        ^
> drivers/phy/phy-omap-usb2.c:110:28: error: =E2=80=98struct omap_usb=E2=
=80=99 has no member named =E2=80=98is_suspended=E2=80=99
>    } else if (!suspend && phy->is_suspended) {
>                              ^
> drivers/phy/phy-omap-usb2.c:117:6: error: =E2=80=98struct omap_usb=E2=
=80=99 has no member named =E2=80=98is_suspended=E2=80=99
>     phy->is_suspended =3D 0;
>        ^
> drivers/phy/phy-omap-usb2.c: In function =E2=80=98omap_usb2_probe=E2=80=
=99:
> drivers/phy/phy-omap-usb2.c:194:5: error: =E2=80=98struct omap_usb=E2=
=80=99 has no member named =E2=80=98is_suspended=E2=80=99
>    phy->is_suspended =3D 1;
>       ^
> make[1]: *** [drivers/phy/phy-omap-usb2.o] Error 1
> make: *** [drivers/phy/] Error 2
> make: *** Waiting for unfinished jobs....
>    CC [M]  drivers/usb/phy/phy-mxs-usb.o
> drivers/usb/phy/phy-omap-usb3.c:22:32: fatal error: linux/usb/omap_us=
b.h: No such file or directory
>   #include <linux/usb/omap_usb.h>
>                                  ^
> compilation terminated.
> make[1]: *** [drivers/usb/phy/phy-omap-usb3.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers/usb/phy/] Error 2
>
