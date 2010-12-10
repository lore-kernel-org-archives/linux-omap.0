From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4] usb: musb: Adding names for IRQs in resource structure
Date: Fri, 10 Dec 2010 10:16:27 +0530
Message-ID: <AANLkTimF3Eotqa+jZvzCJStguGrDEeS9V-XUGOTa9qBt@mail.gmail.com>
References: <1285777599-24245-1-git-send-email-hemahk@ti.com>
	<8762xo62b5.fsf@deeprootsystems.com>
	<4D012F2C.9060303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D012F2C.9060303-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 1:04 AM, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>=
 wrote:
> Hello.
>
> Kevin Hilman wrote:
>
>>> The resource data is getting automatically populated from a set of =
data
>>> generated from TI's hardware database for the OMAP platform, While =
we
>>> could hack in some exceptions to that tool to generate resources
>>> in a specific order, it seems less fragile to use the resource name
>>> instead.That way, no matter what order the resources are generated,=
 the
>>> driver still work.
>
>>> Modified the OMAP,Blackfin and Davinci architecture files to add th=
e name
>>> of the IRQs
>>> in the resource structures and musb driver to use the get_irq_bynam=
e()
>>> api to
>>> get the device and dma irq numbers instead of using the index.
>
>>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>>> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>>> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>>> Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
>>> ---
>
>> For the davinci changes:
>
>> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>
>> Kevin
>
> [...]
>
>>> Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
>>> +++ linux-omap-pm/arch/arm/mach-davinci/usb.c
>>> @@ -64,10 +64,12 @@ static struct resource usb_resources[] =3D
>>> =A0 =A0 =A0 =A0{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0 =A0 =A0 =A0 =A0=3D IRQ_US=
BINT,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D IORESO=
URCE_IRQ,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mc"
>>> =A0 =A0 =A0 =A0},
>>> =A0 =A0 =A0 =A0{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* placeholder for the dedicated CPP=
I IRQ */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D IORESO=
URCE_IRQ,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dma"
>>> =A0 =A0 =A0 =A0},
>>> =A0};
>
> =A0 Argh! This failed to also modify da8xx_usb20_resources[]... :-(

I think when I posted these patch, da8xx support was not there in mainl=
ine.
I will send patch to add this.

Regards,
Hema
>
> WBR, Sergei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
