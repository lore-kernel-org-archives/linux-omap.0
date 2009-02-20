From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: McSPI3 on the BeagleBoard
Date: Fri, 20 Feb 2009 00:33:20 -0800
Message-ID: <1235118800.6894.18.camel@localhost>
References: <499B4B64.30109@balister.org>
	 <200902171918.45146.david-b@pacbell.net>  <499CAA27.5020500@balister.org>
	 <1235031747.13828.1.camel@localhost>  <499D694A.8000404@balister.org>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:14735 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZBTIdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 03:33:36 -0500
Received: by rv-out-0506.google.com with SMTP id g37so840541rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 00:33:34 -0800 (PST)
In-Reply-To: <499D694A.8000404@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Philip,

I found the patch. Thanks. SPI3 is working for me too but I think that
there are a couple of errors:

- first, in the patch you posted on the beagleboard mailing list, you
don't setup CS0 and CS1 pins in u-boot. I think that you should do it.

- secondly, you have added more mux configuration in the kernel for SPI=
3
that should not be SPI3 but those new ones are wrong as they are
competing with some USB pins. It's the same error as David pointed you
for MMC2. Nevertheless, it's still working. Why? Because I have now a
strong feeling that mux configuration is not working in the kernel (at
least for the beagleboard). Here are a few facts that would confirm thi=
s
statement:

- MUX setup for USB ehci has never worked in the kernel. It's why the
beagleaboard rev-C ehci patch has been transfered to u-boot.

- the difference between your patch before and after it was working, is
really the u-boot configuration. You haven't really changed anything in
the kernel (especially in the spi driver) and as mentioned above, you
have even introduced some competing muxes that should have created more
trouble if the kernel mux config were working correctly.

- I had two other areas where I configured the pins in kernel and it wa=
s
not working. Only when I eventually did it in u-boot, it started to
work.

I don't know what's wrong with the pin configuration in the kernel,

Gr=C3=A9goire
=20

On Thu, 2009-02-19 at 09:14 -0500, Philip Balister wrote:
> Gregoire Gentil wrote:
> > Philip,
> >=20
> > Can you please post here or on the Beagleboard mailing list the u-b=
oot
> > patch? This muxpin is very tricky and I have experienced many probl=
ems
> > when set up in the kernel while it seems to work better from u-boot=
 -
> > don't know why,
>=20
> I posted it to the Beagle group. Let me know if you are having troubl=
e=20
> finding it.
>=20
> If we come up with a better config for the expansion port, we'll clea=
n=20
> it up and submit here. My gut feeling is having SPI interfaces on the=
=20
> expansion connector will be more useful then the MMC interface.
>=20
> Philip
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
