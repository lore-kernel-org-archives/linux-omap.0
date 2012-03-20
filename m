From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 12:55:24 +0530
Message-ID: <CAP05o4KQqQh02yif3A-3ZJp9KA218S-dxvm=7q4cKCmqZs+3Kg@mail.gmail.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
	<1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
	<20120319100603.GB20279@arwen.pp.htv.fi>
	<4F6713D8.3080206@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F6713D8.3080206-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 19, 2012 at 4:39 PM, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>=
 wrote:
> Hello.
>
>
> On 19-03-2012 14:06, Felipe Balbi wrote:
>
>>> + =A0 =A0 =A0 ver =3D =A0usbtll_read(base, OMAP_USBTLL_REVISION);
>>> + =A0 =A0 =A0 if (ver =3D=3D OMAP_USBTLL_REV1)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_TLL_CHANNEL_COUNT;
>>> + =A0 =A0 =A0 else if (ver =3D=3D OMAP_USBTLL_REV2)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_REV2_TLL_CHANNEL_COUNT=
;
>>> + =A0 =A0 =A0 else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL version failed\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_ioremap;
>>> + =A0 =A0 =A0 }
>
>
>> wrong coding style.
>
>
> =A0 And *switch* seems more fitting here.
>
> WBR, Sergei

Thanks , I will do this,
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
