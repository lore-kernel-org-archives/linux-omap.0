From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Subject: Re: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
Date: Tue, 1 Jul 2014 20:52:00 -0300
Message-ID: <20140701235200.GB31549@fox>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:55099 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaGAXtd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 19:49:33 -0400
Received: by mail-yk0-f179.google.com with SMTP id 20so6073517yks.10
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2014 16:49:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: airlied@linux.ie
Cc: robdclark@gmail.com, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, Daniel Mack <zonque@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Dave,

did you take a look at this patchset? I foolishly missed adding you on
the To: header, so apologies for that in advance.

Thanks,

On Tue, Jun 17, 2014 at 11:17:02AM -0300, Guido Mart=EDnez wrote:
> The tilcdc driver could be compiled as a module, but was severely bro=
ken
> and could not be used as such. This patchset attempts to fix the issu=
es
> preventing a proper load/unload of the module.
>=20
> Issues included dangling sysfs nodes, dangling devices, memory leaks =
and
> a double kfree.
>=20
> It now seems to be working ok. We have tested this by loading and
> unloading the driver repeteadly, with both panel and slave connectors
> and found no flaws.
>=20
> There is still one warning left on tilcdc_crtc_destroy, caused by
> destroying the connector while still in an ON status. We don't know w=
hy
> this happens or why it's an issue, so we did not fix it.
>=20
> The first 7 patches are bug fixes which and should probably be applie=
d
> in the stable trees. The last two are clean-ups.
>=20
>=20
> Resending this since I got no replies.
>=20
>=20
> Guido Mart=EDnez (9):
>   drm/i2c: tda998x: move drm_i2c_encoder_destroy call
>   drm/tilcdc: panel: fix dangling sysfs connector node
>   drm/tilcdc: slave: fix dangling sysfs connector node
>   drm/tilcdc: tfp410: fix dangling sysfs connector node
>   drm/tilcdc: panel: fix leak when unloading the module
>   drm/tilcdc: fix release order on exit
>   drm/tilcdc: fix double kfree
>   drm/tilcdc: remove submodule destroy calls
>   drm/tilcdc: replace late_initcall with module_init
>=20
>  drivers/gpu/drm/i2c/tda998x_drv.c      |  2 +-
>  drivers/gpu/drm/tilcdc/Module.symvers  |  0
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 15 +++++--------
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h    |  1 -
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 39 +++++++++++++++++-------=
----------
>  drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 27 +++++++++++++----------
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 35 +++++++++++++++---------=
------
>  7 files changed, 59 insertions(+), 60 deletions(-)
>  create mode 100644 drivers/gpu/drm/tilcdc/Module.symvers
>=20
> --=20
> 2.0.0
>=20

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
