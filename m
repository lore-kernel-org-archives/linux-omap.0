From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH RESEND] omap3: Fix EHCI port for IGEP v2 board.
Date: Mon, 15 Mar 2010 18:07:48 +0100
Message-ID: <70c9a9111003151007v30403921j83003f9e1706a859@mail.gmail.com>
References: <1267455756-5081-1-git-send-email-eballetbo@gmail.com>
	 <20100315160322.GB3879@gandalf>
	 <70c9a9111003151005j1233d8ffhe6c8f3440c1a4864@mail.gmail.com>
	 <70c9a9111003151006x41a1a965j4efa2edcaf5eeb90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f198.google.com ([209.85.216.198]:41695 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965439Ab0CORHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 13:07:49 -0400
Received: by pxi36 with SMTP id 36so2080235pxi.21
        for <linux-omap@vger.kernel.org>; Mon, 15 Mar 2010 10:07:49 -0700 (PDT)
In-Reply-To: <70c9a9111003151006x41a1a965j4efa2edcaf5eeb90@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

=46elipe, sorry but I don't understand your questions,m maybe I'm
missing something.

All IGEP v2 boards uses USB1HS EHCI port. My mistake was suppose that
port_mode[1] --> EHCI USB1HS but this is not correct, the EHCI USB1HS
is port_mode[0]. This patch only fixes this.

Best regards,

Enric

>> 2010/3/15 Felipe Balbi <me@felipebalbi.com>
>>>
>>> Hi,
>>>
>>> On Mon, Mar 01, 2010 at 04:02:36PM +0100, Enric Balletbo i Serra wr=
ote:
>>> > @@ -458,13 +458,13 @@ static struct omap_musb_board_data musb_boa=
rd_data =3D {
>>> > =C2=A0};
>>> >
>>> > =C2=A0static const struct ehci_hcd_omap_platform_data ehci_pdata =
__initconst =3D {
>>> > - =C2=A0 =C2=A0 .port_mode[0] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
>>> > - =C2=A0 =C2=A0 .port_mode[1] =3D EHCI_HCD_OMAP_MODE_PHY,
>>> > + =C2=A0 =C2=A0 .port_mode[0] =3D EHCI_HCD_OMAP_MODE_PHY,
>>> > + =C2=A0 =C2=A0 .port_mode[1] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
>>> > =C2=A0 =C2=A0 =C2=A0 .port_mode[2] =3D EHCI_HCD_OMAP_MODE_UNKNOWN=
,
>>> >
>>> > =C2=A0 =C2=A0 =C2=A0 .phy_reset =3D true,
>>> > - =C2=A0 =C2=A0 .reset_gpio_port[0] =3D -EINVAL,
>>> > - =C2=A0 =C2=A0 .reset_gpio_port[1] =3D IGEP2_GPIO_USBH_NRESET,
>>> > + =C2=A0 =C2=A0 .reset_gpio_port[0] =3D IGEP2_GPIO_USBH_NRESET,
>>> > + =C2=A0 =C2=A0 .reset_gpio_port[1] =3D -EINVAL,
>>>
>>> no way to be backwards compatible ? Is it worth to be backwards
>>> compatible ?
>>>
>>> --
>>> balbi
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
