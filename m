From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 2/4] drm/i2c: nxp-tda998x (v3)
Date: Thu, 31 Jan 2013 08:23:53 -0600
Message-ID: <CAF6AEGsYzyefOpeHnsRh-YczVfaTh2d5AtoTFfT7AEWuukJZUA@mail.gmail.com>
References: <1359480184-9168-1-git-send-email-robdclark@gmail.com>
	<1359480184-9168-3-git-send-email-robdclark@gmail.com>
	<5109D5BA.2030801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:36191 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab3AaOXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 09:23:54 -0500
Received: by mail-ve0-f172.google.com with SMTP id cz11so505675veb.17
        for <linux-omap@vger.kernel.org>; Thu, 31 Jan 2013 06:23:53 -0800 (PST)
In-Reply-To: <5109D5BA.2030801@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wed, Jan 30, 2013 at 8:23 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 01/29/2013 06:23 PM, Rob Clark wrote:
>>
>> Driver for the NXP TDA998X i2c hdmi encoder slave.
>
>
> Rob,
>
> good to see a driver for TDA998x comming! I'd love to test
> it on CuBox (mach-dove) but there is no gpu driver I can hook up,
> yet. Anyway, I will make some comments how I think the driver
> should be improved.
>
>
>> diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
>> index 1611836..4d341db 100644
>> --- a/drivers/gpu/drm/i2c/Kconfig
>> +++ b/drivers/gpu/drm/i2c/Kconfig
>> @@ -19,4 +19,10 @@ config DRM_I2C_SIL164
>>           when used in pairs) TMDS transmitters, used in some nVidia
>>           video cards.
>>
>> +config DRM_I2C_NXP_TDA998X
>> +       tristate "NXP Semiconductors TDA998X HDMI encoder"
>> +       default m if DRM_TILCDC
>> +       help
>> +         Support for NXP Semiconductors TDA998X HDMI encoders.
>
>
> Maybe nit-picking but later down you actually support TDA9989,
> TDA19988, and TDA19989. The latter ones don't fit in TDA998x,
> so at least the Kconfig entry should reflect TDA9989/TDA1998x.

yeah, it is a bit weird naming scheme, but I'm just copying NXP in
referring to the whole family as TDA998x

>> [...]
>>
>> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c
>> b/drivers/gpu/drm/i2c/tda998x_drv.c
>> new file mode 100644
>> index 0000000..e68b58a
>> --- /dev/null
>> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
>> @@ -0,0 +1,906 @@
>> +/*
>> + * Copyright (C) 2012 Texas Instruments
>> + * Author: Rob Clark<robdclark@gmail.com>
>> + *
>> +
>> [...]
>>
>> +
>> +/* The TDA9988 series of devices use a paged register scheme.. to
>> simplify
>> + * things we encode the page # in upper bits of the register #.  To read/
>> + * write a given register, we need to make sure CURPAGE register is set
>> + * appropriately.  Which implies reads/writes are not atomic.  Fun!
>> + */
>
>
> Please have a look at regmap-i2c, it also supports paged i2c registers
> and will save you _a lot_ of the i2c handling.

Yeah, I have looked at it, and will eventually convert over to using
it.  The problems at the moment are that I don't really have enough
documentation about the chip at the register level to properly use the
caching modes, and from my digging through the regmap code it looked
like paged regmap + non-caching will result in writes to the page
register for every transaction.  That, and a bit of docs or few more
examples of using the paging support in regmap would be nice.  For
now, I am punting on regmap conversion.

>> [...]
>>
>> +
>> +/* Device versions: */
>> +#define TDA9989N2                 0x0101
>> +#define TDA19989                  0x0201
>> +#define TDA19989N2                0x0202
>> +#define TDA19988                  0x0301
>
>
> Maybe split this into device_version/revision? What does N2 stand for
> or is this the name NXP uses for that device?

The register names are based on the names used in the NXP out-of-tree
driver (the 50kloc monstrosity, if you've seen it).. that was pretty
much all the register level documentation I had.

>> [...]
>
>> +static void
>> +cec_write(struct drm_encoder *encoder, uint16_t addr, uint8_t val)
>> +{
>> +       struct i2c_client *client = to_tda998x_priv(encoder)->cec;
>> +       uint8_t buf[] = {addr, val};
>> +       int ret;
>> +
>> +       ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
>> +       if (ret<  0)
>> +               dev_err(&client->dev, "Error %d writing to cec:0x%x\n",
>> ret, addr);
>> +}
>
>
> Has there been any decision on how to split/integrate cec from drm?
> Or is there display stuff located in cec i2c slave (I see HPD in
> ..._detect below)?

not sure, but at least in this case it can't really be decoupled.  I
need to use the CEC interface for HPD (as you noticed) and also to
power up the HDMI bits..

>> [...]
>>
>> +static void
>> +tda998x_encoder_save(struct drm_encoder *encoder)
>> +{
>> +       DBG("");
>> +}
>> +
>> +static void
>> +tda998x_encoder_restore(struct drm_encoder *encoder)
>> +{
>> +       DBG("");
>> +}
>
>
> Hmmm, these DBG("") shouldn't be in upstream kernel code?
>

yeah, I suppose these traces don't add too much value, I can remove them

>> +static bool
>> +tda998x_encoder_mode_fixup(struct drm_encoder *encoder,
>> +                         const struct drm_display_mode *mode,
>> +                         struct drm_display_mode *adjusted_mode)
>> +{
>> +       return true;
>> +}
>> +
>> +static int
>> +tda998x_encoder_mode_valid(struct drm_encoder *encoder,
>> +                         struct drm_display_mode *mode)
>> +{
>> +       return MODE_OK;
>> +}
>
>
> At least a note would be helpful to see what callbacks are
> not yet done. I guess there will be some kind of mode check
> someday?

Well, some of these drm will assume the fxn ptrs are not null, so we
need something even if it is empty.

I suppose there are must be some upper bounds on pixel clock
supported, which could perhaps be added some day in _mode_valid().  On
the device I am working on, the limiting factor is the crtc (upstream
of the encoder), so I haven't really needed this yet.  I expect that
as people start using this on some other devices, we'll come across
some enhancements needed, some places where we need to add some
configuration, etc.  I cannot really predict exactly what is needed,
so I prefer just to put the driver out there in some form, and then
add it it as needed.  So, I wouldn't really say that these functions
are "TODO", but I also wouldn't say that we won't find some reason to
add some code there at some point.

>> [...]
>>
>> +static enum drm_connector_status
>> +tda998x_encoder_detect(struct drm_encoder *encoder,
>> +                     struct drm_connector *connector)
>> +{
>> +       uint8_t val = cec_read(encoder, REG_CEC_RXSHPDLEV);
>> +       return (val&  CEC_RXSHPDLEV_HPD) ? connector_status_connected :
>> +                       connector_status_disconnected;
>> +}
>
>
> This is where cec slave gets called from hdmi i2c driver. Any chance
> there is HPD status in hdmi registers, too?

Not that I know of.  But like I mentioned, we also need to use the CEC
interface just to talk to the HDMI interface.  Before setting ENAMODS
reg via cec address, the hdmi address won't even show up (for ex, on
i2cdetect).

Maybe there is some way that this code should register some interface
with CEC driver/subsystem?  (Is there such a thing?  I am not really
CEC expert.)  But I don't think there is any way to completely split
it out.

>
>> +/* I2C driver functions */
>> +
>> +static int
>> +tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
>> +{
>> +       return 0;
>> +}
>> +
>> +static int
>> +tda998x_remove(struct i2c_client *client)
>> +{
>> +       return 0;
>> +}
>
>
> Hmm, empty _probe and _remove? Maybe these should get some code
> from _init below?

naw, they aren't really used for drm i2c encoder slaves.

>> +static int
>> +tda998x_encoder_init(struct i2c_client *client,
>> +                   struct drm_device *dev,
>> +                   struct drm_encoder_slave *encoder_slave)
>> +{
>> +       struct drm_encoder *encoder =&encoder_slave->base;
>>
>> +       struct tda998x_priv *priv;
>> +
>> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       priv->current_page = 0;
>> +       priv->cec = i2c_new_dummy(client->adapter, 0x34);
>> +       priv->dpms = DRM_MODE_DPMS_OFF;
>> +
>> +       encoder_slave->slave_priv = priv;
>> +       encoder_slave->slave_funcs =&tda998x_encoder_funcs;
>> +
>> +       /* wake up the device: */
>> +       cec_write(encoder, REG_CEC_ENAMODS,
>> +                       CEC_ENAMODS_EN_RXSENS | CEC_ENAMODS_EN_HDMI);
>> +
>> +       tda998x_reset(encoder);
>> +
>> +       /* read version: */
>> +       priv->rev = reg_read(encoder, REG_VERSION_LSB) |
>> +                       reg_read(encoder, REG_VERSION_MSB)<<  8;
>> +
>> +       /* mask off feature bits: */
>> +       priv->rev &= ~0x30; /* not-hdcp and not-scalar bit */
>
>
> If revision register contains features, why not save them for later
> driver improvements?
>

can be added later if the need arises.  I prefer to leave out code
that only might be used later.. otherwise it is a good way to
accumulate cruft.

>
>> +       switch (priv->rev) {
>> +       case TDA9989N2:  dev_info(dev->dev, "found TDA9989 n2");  break;
>> +       case TDA19989:   dev_info(dev->dev, "found TDA19989");    break;
>> +       case TDA19989N2: dev_info(dev->dev, "found TDA19989 n2"); break;
>> +       case TDA19988:   dev_info(dev->dev, "found TDA19988");    break;
>> +       default:
>> +               DBG("found unsupported device: %04x", priv->rev);
>> +               goto fail;
>> +       }
>
>
> I think printing revision is sufficient, no user will care about the
> actual device or revision.
>
>
>> +       /* after reset, enable DDC: */
>> +       reg_write(encoder, REG_DDC_DISABLE, 0x00);
>> +
>> +       /* set clock on DDC channel: */
>> +       reg_write(encoder, REG_TX3, 39);
>
>
> This should be kept disabled as long as there is no monitor attached
> (HPD!)
>

The sequence is based on NXP's driver.. I'll have to go back and
check, but IIRC there were a few things I had to turn on just to make
HPD work in the first place.

Ofc, if there were actually some decent docs about the part, it would
be a bit easier to know what is actually required and what is not.  So
I don't claim everything in it's current form is optimal.


>
>> +       /* if necessary, disable multi-master: */
>> +       if (priv->rev == TDA19989)
>> +               reg_set(encoder, REG_I2C_MASTER, I2C_MASTER_DIS_MM);
>> +
>> +       cec_write(encoder, REG_CEC_FRO_IM_CLK_CTRL,
>> +                       CEC_FRO_IM_CLK_CTRL_GHOST_DIS |
>> CEC_FRO_IM_CLK_CTRL_IMCLK_SEL);
>> +
>> +       return 0;
>> +
>> +fail:
>> +       /* if encoder_init fails, the encoder slave is never registered,
>> +        * so cleanup here:
>> +        */
>> +       if (priv->cec)
>> +               i2c_unregister_device(priv->cec);
>> +       kfree(priv);
>> +       encoder_slave->slave_priv = NULL;
>> +       encoder_slave->slave_funcs = NULL;
>> +       return -ENXIO;
>> +}
>> +
>> +static struct i2c_device_id tda998x_ids[] = {
>> +       { "tda998x", 0 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, tda998x_ids);
>
>
> Shouldn't the above carry the hdmi core i2c address at least?
>

no, it should come from the user of the encoder slave.  Actually the
CEC address should too, but current drm i2c encoder slave code sort of
assumes the device just has a single address

BR,
-R

>
>> +static struct drm_i2c_encoder_driver tda998x_driver = {
>> +       .i2c_driver = {
>> +               .probe = tda998x_probe,
>> +               .remove = tda998x_remove,
>> +               .driver = {
>> +                       .name = "tda998x",
>> +               },
>> +               .id_table = tda998x_ids,
>> +       },
>> +       .encoder_init = tda998x_encoder_init,
>> +};
>> +
>> +/* Module initialization */
>> +
>> +static int __init
>> +tda998x_init(void)
>> +{
>> +       DBG("");
>> +       return drm_i2c_encoder_register(THIS_MODULE,&tda998x_driver);
>> +}
>> +
>> +static void __exit
>> +tda998x_exit(void)
>> +{
>> +       DBG("");
>> +       drm_i2c_encoder_unregister(&tda998x_driver);
>> +}
>> +
>> +MODULE_AUTHOR("Rob Clark<robdclark@gmail.com");
>> +MODULE_DESCRIPTION("NXP Semiconductors TDA998X HDMI Encoder");
>> +MODULE_LICENSE("GPL");
>
>
> Maybe stick to one version of "TDA998X" or "TDA998x" ?
>
> Regards,
>   Sebastian
