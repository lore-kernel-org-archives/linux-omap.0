From: Gregory CLEMENT <gclement00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/3] usb: ohci: introduce ohci-hcd driver for omap3
Date: Mon, 26 Apr 2010 08:17:23 +0200
Message-ID: <g2x305035a41004252317ufc49ae37td04ab73887535959@mail.gmail.com>
References: <1272256489-3389-1-git-send-email-gadiyar@ti.com>
	 <h2s305035a41004252254md6918bb6l74ebfe0153ef558b@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0322986B90@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322986B90-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Le 26 avril 2010 08:02:55 UTC+2, Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org> a =E9c=
rit :
> Gregory CLEMENT wrote:
>> =A0 =A0 =A0 This controller supports multiple interface modes. Only =
2 of them
>> =A0 =A0 =A0 (3-pin DAT/SE0 and 4-pin DP/DM PHY modes) have been test=
ed with this
>> =A0 =A0 =A0 driver. (However the only change for the other modes is =
one register
>> =A0 =A0 =A0 setting for selecting the mode, and the padconf setting =
for the omap
>> =A0 =A0 =A0 pads, so I expect it to work correctly).
>> =A0 =A0 =A0 (Someone did offer to test the 6-pin mode. Still awaitin=
g results...)
>>
>
>> I am the one who offer to test 6-pin mode. Unfortunally, I still hav=
e some problem.
>> The current version of our kernel is 2.6.33 so first I try to
>> back port your patch for our version, and so kernel crashes
>> during access to USB controller.
>> Then I try to port our kernel to the last version of Linux,
>> but now I can't see any traces on serial port after
>> "Uncompressing Linux... done, booting the kernel..".
>> I am still stuck to these problems which are not really
>> related to your patches.
>>
>
> Could you enable CONFIG_EARLY_PRINTK and add "earlyprintk" to your
> bootargs? This might throw up some messages on the console that
> can show where the problem is.

I already enable  CONFIG_EARLY_PRINTK but I didn't add "earlyprintk",I
though setting the config was enough, I will try this!

>
> Which debug console are you using? Is it an OMAP UART or something
> external like in some newer boards?

I use the same UART that beagle board: UART3


Thanks for your help

>
> - Anand
>



--=20
Gregory CLEMENT
Responsable Technique Linux embarqu=E9 - Europe
Embedded Linux Development Lead - EMEA

Adeneo Embedded - Adetel Group
2, chemin du Ruisseau
69134 ECULLY - FRANCE
T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
