From: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH/RESEND 8/9] drm/tilcdc: remove submodule destroy calls
Date: Wed, 25 Jun 2014 11:53:37 -0300
Message-ID: <20140625145337.GB743@arch.cereza>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-9-git-send-email-guido@vanguardiasur.com.ar>
 <53A9F660.8060703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:45373 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbaFYOy0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 10:54:26 -0400
Received: by mail-yk0-f177.google.com with SMTP id 10so1151821ykt.36
        for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2014 07:54:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53A9F660.8060703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Darren Etheridge <detheridge@ti.com>
Cc: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <zonque@gmail.com>

On 24 Jun 05:06 PM, Darren Etheridge wrote:
>=20
> On 06/17/2014 09:17 AM, Guido Mart=EDnez wrote:
> >The TI tilcdc driver is designed with a notion of submodules. Curren=
tly,
> >at unload time, these submodules are iterated and destroyed.
> >
> >Now that the tilcdc remove order is fixed, this can be handled perfe=
ctly
>=20
> I am not sure I understand the first part of the above sentence - did
> something change with tilcdc ordering?

Yes, patch [PATCH/RESEND 6/9] drm/tilcdc: fix release order on exit cha=
nges
the tilcdc remove ordering.=20

Currently, the tilcdc DRM is removed with this:

        tilcdc_tfp410_fini();
        tilcdc_slave_fini();
        tilcdc_panel_fini();
        platform_driver_unregister(&tilcdc_platform_driver);

Which is wrong as you shouldn't remove the tilcdc "modules" (panel, sla=
ve,
tfp410) before the DRM driver itself. So the above patch fixed it to be=
:

        platform_driver_unregister(&tilcdc_platform_driver);
        tilcdc_panel_fini();
        tilcdc_slave_fini();
        tilcdc_tfp410_fini();

> I think you a referring to previous
> patches in your series which really mean tilcdc can actually unload n=
ow.  So
> really the method this patch uses could always have been used, it jus=
t
> wasn't for some reason?
>=20

No, I believe this patch which removes the tilcdc sub-module destroy
infrastructure can only be applied *after* the above remove order is fi=
xed
(iow, the 6/9 patch mentioned above).

In other words, only once you have a proper remove() that releases thin=
gs
in the right order you can rely in the kernel and avoid any custom
implementation.
--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
