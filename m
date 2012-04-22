From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: tidspbridge in drivers/staging
Date: Sun, 22 Apr 2012 09:16:19 -0700
Message-ID: <20120422161619.GA26175@kroah.com>
References: <20120422095717.GA25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:44872 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab2DVQQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Apr 2012 12:16:24 -0400
Received: by dadz8 with SMTP id z8so14526408dad.10
        for <linux-omap@vger.kernel.org>; Sun, 22 Apr 2012 09:16:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120422095717.GA25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, =?iso-8859-1?Q?V=EDctor_Manuel_J=E1quez?= Leal <vjaquez@igalia.com>

On Sun, Apr 22, 2012 at 10:57:17AM +0100, Russell King - ARM Linux wrot=
e:
> I've noticed these failure from time to time in my omap4 randconfig b=
uilds:
>=20
> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_br=
d_start':
> drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit de=
claration of function 'OMAP2_L4_IO_ADDRESS'
> drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
> drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declaratio=
n of function 'OMAP2_L4_IO_ADDRESS'
>=20
> Looking at git, it looks like there is some activity with tidspbridge
> (by V=EDctor).  Is there any interest in fixing these errors for v3.4
> (or even v3.4-rc5)?

Along those lines, what's the plans on getting this code _out_ of
staging?  I haven't seen anything going on here in a while...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
