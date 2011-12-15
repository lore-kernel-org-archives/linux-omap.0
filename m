From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Issue with isp1704 loaded too soon
Date: Thu, 15 Dec 2011 19:51:47 +0200
Message-ID: <CAMP44s08uBK1Vm0Bx_0NouaaNHU0D2kp9AiL+1LPrT1BZURj0A@mail.gmail.com>
References: <CAMP44s2M8cFM5AhjMwbFJZpQtbYe13w9bswTRhap97nOCyZVfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMP44s2M8cFM5AhjMwbFJZpQtbYe13w9bswTRhap97nOCyZVfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 15, 2011 at 1:15 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Dec 13, 2011 at 11:19 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Dec 12, 2011 at 9:09 AM, Jarkko Nikula <jarkko.nikula@bitmer=
=2Ecom> wrote:
>>> Indeed yes. I checked that in 3.0 it still works but not in 3.1 so =
some
>>> non isp1704_charger change has broke it as there hasn't been change=
s on it.
>>
>> Actually it's broken in 3.0 as well, try this configuration:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0# CONFIG_USB_MUSB_HOST is not set
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0# CONFIG_USB_MUSB_PERIPHERAL is not set
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_USB_MUSB_OTG=3Dy
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_USB_GADGET_MUSB_HDRC=3Dy
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_USB_MUSB_HDRC_HCD=3Dy
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_USB_GADGET_SELECTED=3Dy
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0# CONFIG_USB_GADGET_FUSB300 is not set
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0# CONFIG_USB_GADGET_OMAP is not set
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0# CONFIG_USB_GADGET_R8A66597 is not set
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0# CONFIG_USB_GADGET_PXA_U2O is not set
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0# CONFIG_USB_GADGET_M66592 is not set
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0# CONFIG_USB_GADGET_DUMMY_HCD is not set
>>
>> I will try to find where the issues started to happen, but it's a bi=
t
>> difficult because all this USB Kconfig stuff is completely messed up=
=2E
>>
>> *Sigh*
>
> Ok, I made some progress.
>
> The issue appeared on 2.6.39, specifically, on commit 0df0914, which
> is a merge from Linus. The issue doesn't appear in any of the two
> parents of that merge.
>
> I manually merged various commits, and the first one that triggered
> the problem is 18a2689, but the commit itself is not the problem but
> something that was already merged to Linus' tree, specifically at
> point 6899608.
>
> IOW, it's a mixture of two changes that appear together at point,
> 0df0914, one of them is 18a2689, the other one I still don't know.
>
> Unless you can find what's wrong with this commit:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dbl=
obdiff;f=3Darch/arm/mach-omap2/usb-musb.c;h=3Da9d4d143086d73463b97c093c=
c9f022de8e1d679;hp=3D9788b4941857f40d50d48fa6470ee14e179bc373;hb=3D18a2=
689;hpb=3D273ff8c3bc04cf358c131f49ee7a11efa7ec73d7
>
> I guess the safest route is to continue with the manual merges to fin=
d
> the second relevant commit =3D/

=46ound it.

So, the first commit is this one:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
itdiff;h=3D18a2689

Which needs this one:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
itdiff;h=3D870ea2b

But it's only triggered with this other one:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
itdiff;h=3D7acc619

Seems to be some power management stuff, and it's only triggered with
certain configurations.

And this concludes the most tedious git bisect in history =3D/

Cheers.

--=20
=46elipe Contreras
