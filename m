From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: remove driver
Date: Wed, 16 Jul 2014 10:29:51 -0500
Message-ID: <53C69A6F.6030105@ti.com>
References: <1405467019-21185-1-git-send-email-kristina.martsenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34556 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965169AbaGPP34 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jul 2014 11:29:56 -0400
In-Reply-To: <1405467019-21185-1-git-send-email-kristina.martsenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?S3Jpc3RpbmEgTWFydMWhZW5rbw==?= <kristina.martsenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devel@driverdev.osuosl.org, Omar Ramirez Luna <omar.ramirez@copitl.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>

On 07/15/2014 06:30 PM, Kristina Mart=C5=A1enko wrote:
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

Acked-by: Suman Anna <s-anna@ti.com>

Thanks, I will refresh my OMAP mailbox framework adaptation series to
remove the adaptation changes done to the tidspbridge driver [1] to
avoid merge conflicts.

regards
Suman

[1] https://patchwork.kernel.org/patch/4538001/

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
