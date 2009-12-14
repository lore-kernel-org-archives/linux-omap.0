From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: smc91x problems on 2430SDP
Date: Mon, 14 Dec 2009 23:41:24 +0200
Message-ID: <f870da180912141341p14a90f21nc8651dee1988874a@mail.gmail.com>
References: <alpine.DEB.2.00.0912141353270.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:60143 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZLNVlZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 16:41:25 -0500
Received: by iwn1 with SMTP id 1so487646iwn.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 13:41:24 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912141353270.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Mon, Dec 14, 2009 at 10:55 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi,
>
> smc91x is preventing 2430SDP from booting. =A0Messages follow at the =
end of
> this message. =A0Any ideas?
>

AFAIK, smc91x probes interrupts during initialization. Maybe interrupt
flags got wrong somehow, of the interrupt pin mux is not properly  set
up.

> - Paul
>
>
> smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> eth%d: spurious interrupt (mask =3D 0x0b)
> ...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
