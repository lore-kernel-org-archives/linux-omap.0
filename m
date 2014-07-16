From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: remove driver
Date: Wed, 16 Jul 2014 11:45:31 +0300
Message-ID: <20140716084529.GA22654@atomide.com>
References: <1405467019-21185-1-git-send-email-kristina.martsenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14250 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757207AbaGPIpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2014 04:45:38 -0400
Content-Disposition: inline
In-Reply-To: <1405467019-21185-1-git-send-email-kristina.martsenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, devel@driverdev.osuosl.org, Omar Ramirez Luna <omar.ramirez@copitl.com>, Suman Anna <s-anna@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>

* Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com> [140716 02:33]=
:
> The driver has been broken and disabled for several kernel versions n=
ow.
> It doesn't have a maintainer anymore, and most of the people who've
> worked on it have moved on. There's also still a long list of issues =
in
> the TODO file before it can be moved out of staging. Until someone ca=
n
> put in the work to make the driver work again and move it out of
> staging, remove it from the kernel.
>=20
> Signed-off-by: Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com>
> Cc: Omar Ramirez Luna <omar.ramirez@copitl.com>
> Cc: Suman Anna <s-anna@ti.com>
> Cc: Felipe Contreras <felipe.contreras@gmail.com>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>

Acked-by: Tony Lindgren <tony@atomide.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
