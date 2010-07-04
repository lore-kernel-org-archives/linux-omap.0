From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 11/11] staging: ti dspbridge: enable driver building
Date: Sun, 4 Jul 2010 13:53:52 +0300
Message-ID: <AANLkTik0rm12w4jplD1vSTZnPbwguDU6xtOdAfs9C-3r@mail.gmail.com>
References: <1277298125-17991-1-git-send-email-ohad@wizery.com>
	<1277298840-18516-1-git-send-email-ohad@wizery.com>
	<20100623224150.GA6680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54543 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172Ab0GDKxy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 06:53:54 -0400
In-Reply-To: <20100623224150.GA6680@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Hebbar Shivananda <x0hebbar@ti.com>, Ramos Falcon Ernesto <ernesto@ti.com>, Anna Suman <s-anna@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Gupta Ramesh <grgupta@ti.com>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>, Ameya Palande <ameya.palande@nokia.com>, Gomez Castellanos Ivan <ivan.gomez@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Armando Uribe De Leon <x0095078@ti.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Menon Nishanth <nm@ti.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Pitney Gilbert <gpitney@ti.com>, Bhavin Shah <bshah@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

On Thu, Jun 24, 2010 at 1:41 AM, Greg KH <greg@kroah.com> wrote:
> The default is always 'n' so you don't need this.
>
> Also, this enables the driver to be built on x86, which fails horribl=
y,
> and I don't think is what you really want to have happen :)
>
> So I need some more Kconfig changes here, care to redo just this one
> patch? =C2=A0I've applied all the others and they will show up in lin=
ux-next
> tomorrow.

I fixed all that stuff some time ago:
http://article.gmane.org/gmane.linux.ports.arm.omap/36065

But the patches were ignored.

I might rebase them if nobody beats me to it.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
