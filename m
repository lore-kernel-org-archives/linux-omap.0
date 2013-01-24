From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 3/4] drm/tilcdc: add encoder slave
Date: Thu, 24 Jan 2013 08:26:16 -0600
Message-ID: <CAF6AEGv_phG61y_cGmP=JZ8ZxbcVpa772xJZCF1x-=cEpbpLag@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
	<1358894185-21617-4-git-send-email-robdclark@gmail.com>
	<20130124124323.GA31306@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:35451 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3AXO0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 09:26:17 -0500
Received: by mail-ve0-f182.google.com with SMTP id pb11so1505808veb.27
        for <linux-omap@vger.kernel.org>; Thu, 24 Jan 2013 06:26:16 -0800 (PST)
In-Reply-To: <20130124124323.GA31306@phenom.ffwll.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thu, Jan 24, 2013 at 6:43 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Jan 22, 2013 at 04:36:24PM -0600, Rob Clark wrote:
>> Add output panel driver for i2c encoder slaves.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>
> A few questions below, otherwise
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> ---

[snip]

>> diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc/Kconfig
>> index ee9b592..99beca2 100644
>> --- a/drivers/gpu/drm/tilcdc/Kconfig
>> +++ b/drivers/gpu/drm/tilcdc/Kconfig
>> @@ -8,3 +8,15 @@ config DRM_TILCDC
>>         Choose this option if you have an TI SoC with LCDC display
>>         controller, for example AM33xx in beagle-bone, DA8xx, or
>>         OMAP-L1xx.  This driver replaces the FB_DA8XX fbdev driver.
>> +
>> +menu "I2C encoder or helper chips"
>> +     depends on DRM && DRM_KMS_HELPER && I2C
>> +
>> +config DRM_I2C_NXP_TDA998X
>> +     tristate "NXP Semiconductors TDA998X HDMI encoder"
>> +     default m if DRM_TILCDC
>> +     help
>> +       Support for NXP Semiconductors TDA998X HDMI encoders.
>> +
>> +endmenu
>> +
>
> Shouldn't that hunk be in patch 2?

yeah, probably.. I just copied how it was done in nouveau, but I think
probably the Kconfig for the i2c encoder slaves should be moved into
drivers/gpu/drm/i2c

[snip]

>> +/*
>> + * Encoder:
>> + */
>> +
>> +struct slave_encoder {
>> +     struct drm_encoder_slave base;
>> +     struct slave_module *mod;
>> +};
>> +#define to_slave_encoder(x) container_of(to_encoder_slave(x), struct slave_encoder, base)
>
> Since you have a 1:1:1 relationship between module/drm_encoder, the
> drm_encoder_slave and the connector I'd just smash this all into one
> struct. Pure bikeshed though ;-)

yeah, but drm_encoder_slave is coming from drm core

[snip]

>> +static struct drm_encoder *slave_encoder_create(struct drm_device *dev,
>> +             struct slave_module *mod)
>> +{
>> +     struct slave_encoder *slave_encoder;
>> +     struct drm_encoder *encoder;
>> +     int ret;
>> +
>> +     slave_encoder = kzalloc(sizeof(*slave_encoder), GFP_KERNEL);
>> +     if (!slave_encoder) {
>> +             dev_err(dev->dev, "allocation failed\n");
>> +             return NULL;
>> +     }
>> +
>> +     slave_encoder->mod = mod;
>> +
>> +     encoder = &slave_encoder->base.base;
>> +     encoder->possible_crtcs = 1;
>> +
>> +     ret = drm_encoder_init(dev, encoder, &slave_encoder_funcs,
>> +                     DRM_MODE_ENCODER_LVDS);
>
> DRM_MODE_ENCODER_TMDS? Although I guess adding a new kind of
> multi-function encoder type would make more sense and also useful in other
> places. E.g. i915-sdvo/dvo just set meaningless types for multi-function
> encoders (i.e. more than one connector on the same output), namely the
> type which matches the connector last initalized.

I suppose TDMS makes more sense.. perhaps getting both this and
connector type from the encoder-slave would make the most sense, but I
can change it to TDMS for now

[snip]

>> +static struct drm_connector *slave_connector_create(struct drm_device *dev,
>> +             struct slave_module *mod, struct drm_encoder *encoder)
>> +{
>> +     struct slave_connector *slave_connector;
>> +     struct drm_connector *connector;
>> +     int ret;
>> +
>> +     slave_connector = kzalloc(sizeof(*slave_connector), GFP_KERNEL);
>> +     if (!slave_connector) {
>> +             dev_err(dev->dev, "allocation failed\n");
>> +             return NULL;
>> +     }
>> +
>> +     slave_connector->encoder = encoder;
>> +     slave_connector->mod = mod;
>> +
>> +     connector = &slave_connector->base;
>> +
>> +     drm_connector_init(dev, connector, &slave_connector_funcs,
>> +                     DRM_MODE_CONNECTOR_HDMIA);
>
> Shouldn't we get the connector type from the drm_encoder_slave somehow?
> Works here for now, so just food for thought for future encoder slave
> refactorings and infrastructure work.

yeah, getting it from the encoder slave makes the most sense

[snip]

>> +static struct of_device_id slave_of_match[] = {
>> +             { .compatible = "tilcdc,slave", },
>> +             { },
>> +};
>> +MODULE_DEVICE_TABLE(of, slave_of_match);
>> +
>> +struct platform_driver slave_driver = {
>> +     .probe = slave_probe,
>> +     .remove = slave_remove,
>> +     .driver = {
>> +             .owner = THIS_MODULE,
>> +             .name = "slave",
>> +             .of_match_table = slave_of_match,
>> +     },
>> +};
>
> No idea how this devicetree matching stuff is supposed to work, but I
> guess this needs to be updated in the devictree docs like the base match.

yeah, I didn't realize previously about the DT bindings docs, so I
need to look into that

BR,
-R
