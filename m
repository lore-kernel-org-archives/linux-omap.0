From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RFC] drm/lcdc: add TI LCD Controller DRM driver
Date: Mon, 17 Dec 2012 08:39:52 -0600
Message-ID: <CAF6AEGvm2TmFh7xiYzjt9yGT4kuBFA=_219NkwQAjbBVZ+Z6rg@mail.gmail.com>
References: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
	<50CF248B.4010401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41699 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab2LQOjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 09:39:52 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so7093985vby.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012 06:39:52 -0800 (PST)
In-Reply-To: <50CF248B.4010401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "patches@linaro.org" <patches@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Dec 17, 2012 at 7:56 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2012-12-14 02:04, Rob Clark wrote:
>> A simple DRM/KMS driver for the TI LCD Controller found in various
>> smaller TI parts (AM33xx, OMAPL138, etc).  This driver uses the
>> CMA helpers.  Currently only the TFP410 DVI encoder is supported
>> (tested with beaglebone + DVI cape).  There are also various LCD
>> displays, for which support can be added (as I get hw to test on),
>> and an external i2c HDMI encoder found on some boards.
>>
>> The display controller supports a single CRTC.  And the encoder+
>> connector are split out into sub-devices.  Depending on which LCD
>> or external encoder is actually present, the appropriate output
>> module(s) will be loaded.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>>  drivers/gpu/drm/Kconfig            |   2 +
>>  drivers/gpu/drm/Makefile           |   1 +
>>  drivers/gpu/drm/lcdc/Kconfig       |  11 +
>>  drivers/gpu/drm/lcdc/Makefile      |   8 +
>>  drivers/gpu/drm/lcdc/lcdc_crtc.c   | 544 +++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/lcdc/lcdc_drv.c    | 604 +++++++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/lcdc/lcdc_drv.h    | 162 ++++++++++
>>  drivers/gpu/drm/lcdc/lcdc_regs.h   | 154 ++++++++++
>>  drivers/gpu/drm/lcdc/lcdc_tfp410.c | 424 ++++++++++++++++++++++++++
>>  drivers/gpu/drm/lcdc/lcdc_tfp410.h |  26 ++
>>  10 files changed, 1936 insertions(+)
>>  create mode 100644 drivers/gpu/drm/lcdc/Kconfig
>>  create mode 100644 drivers/gpu/drm/lcdc/Makefile
>>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_crtc.c
>>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_drv.c
>>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_drv.h
>>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_regs.h
>>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_tfp410.c
>>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_tfp410.h
>
> "lcdc" is quite a common term. The directory should perhaps be something
> like ti-lcdc?

yeah.. but not one else was using it (other than internally to the
driver).. I guess we could call it tilcdc or ti-lcdc

> Probably not relevant, but I wonder if the same LCDC was used in
> omap1... It'd be nice to get rid of the omap1 fb driver.

would be interesting if you have any idea where to find hw to test
with (museum?)

> I'm not very enthusiastic about adding ti-lcdc specific panel/chip
> drivers. It's not really a big deal if it's only kernel code, but you
> add device-tree bindings also, which is an external API that you need to
> support after adding it.
>
> I'd rather see the energy put to common display framework, and get this
> whole panel/chip driver issue solved in a generic manner.

yeah, I was expecting to migrate to CDF once it exists, but needed
something for now.  I'm using the exercise to get my thoughts straight
on how CDF should fit into KMS.  (One thing I plan to add support for
is an i2c connected hdmi encoder.. which looks like it would fit well
in drivers/gpu/drm/i2c.. so the drm encoder-slave stuff might be the
way.)

If you have any suggestions on the DT bindings, I'd like to hear 'em.

BR,
-R

>  Tomi
>
>
