From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Sun, 16 Aug 2009 10:14:03 +0200
Message-ID: <D1AF0CA1-B658-4BA3-8D68-F2DD5B1D91B8@student.utwente.nl>
References: <20090815174352.c2883585.jhnikula@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com> <20090815180701.7710de51.jhnikula@gmail.com> <20090815174000.GA13164@nokia.com> <20090816104415.e12a5e46.jhnikula@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-19--627179958"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:54343 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbZHPIOR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Aug 2009 04:14:17 -0400
In-Reply-To: <20090816104415.e12a5e46.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: felipe.balbi@nokia.com, "Gadiyar, Anand" <gadiyar@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-19--627179958
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 16 aug 2009, om 09:44 heeft Jarkko Nikula het volgende geschreven:

>
> By some reason CONFIG_OMAP_LL_DEBUG_UART3=y and CONFIG_DEBUG_LL=y
> don't work in mainline so hard to trace what is make an oops.

Try updating this patch to current mainline:

--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -16,6 +16,8 @@
   *     01Mar01 Andrew Morton <andrewm@uow.edu.au>
   */

+extern void printascii(const char *);
+
  #include <linux/kernel.h>
  #include <linux/mm.h>
  #include <linux/tty.h>
@@ -653,6 +655,8 @@ asmlinkage int vprintk(const char *fmt, va_list  
args)
         /* Emit the output into the temporary buffer */
         printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt,  
args);

+       printascii(printk_buf);
+
         /*
          * Copy the output into log_buf.  If the caller didn't provide
          * appropriate log level tags, we insert them here


regards,

Koen

--Apple-Mail-19--627179958
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFKh7/NMkyGM64RGpERAsqSAJ0fqSTi1cuyp0EOsPVKdWDBipBueQCeMdle
e+VgSlqNvBxm94228FlVHos=
=BeQ+
-----END PGP SIGNATURE-----

--Apple-Mail-19--627179958--
