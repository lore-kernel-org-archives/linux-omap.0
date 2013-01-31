From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/4] drm/i2c: nxp-tda998x (v3)
Date: Thu, 31 Jan 2013 21:14:48 +0100
Message-ID: <510AD0B8.8020401@gmail.com>
References: <1359480184-9168-1-git-send-email-robdclark@gmail.com> <1359480184-9168-3-git-send-email-robdclark@gmail.com> <5109D5BA.2030801@gmail.com> <CAF6AEGsYzyefOpeHnsRh-YczVfaTh2d5AtoTFfT7AEWuukJZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:41449 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab3AaUOy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 15:14:54 -0500
Received: by mail-ea0-f173.google.com with SMTP id i1so1406753eaa.18
        for <linux-omap@vger.kernel.org>; Thu, 31 Jan 2013 12:14:53 -0800 (PST)
In-Reply-To: <CAF6AEGsYzyefOpeHnsRh-YczVfaTh2d5AtoTFfT7AEWuukJZUA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 01/31/2013 03:23 PM, Rob Clark wrote:
> On Wed, Jan 30, 2013 at 8:23 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com>  wrote:
>> On 01/29/2013 06:23 PM, Rob Clark wrote:
[...]
>>> +
>>> +/* The TDA9988 series of devices use a paged register scheme.. to
>>> simplify
>>> + * things we encode the page # in upper bits of the register #.  To read/
>>> + * write a given register, we need to make sure CURPAGE register is set
>>> + * appropriately.  Which implies reads/writes are not atomic.  Fun!
>>> + */
>>
>> Please have a look at regmap-i2c, it also supports paged i2c registers
>> and will save you _a lot_ of the i2c handling.
>
> Yeah, I have looked at it, and will eventually convert over to using
> it.  The problems at the moment are that I don't really have enough
> documentation about the chip at the register level to properly use the
> caching modes, and from my digging through the regmap code it looked
> like paged regmap + non-caching will result in writes to the page
> register for every transaction.  That, and a bit of docs or few more
> examples of using the paging support in regmap would be nice.  For
> now, I am punting on regmap conversion.

Hmm, flipping through the public tda998x sources *sigh* I found a
quite complete register list that also states if registers are RO or RW.
Even if you are not using all registers you can still prevent regmap from
reading/writing to them. But yes, documentation lacks some examples ;)

>>> [...]
>>> +
>>> +/* Device versions: */
>>> +#define TDA9989N2                 0x0101
>>> +#define TDA19989                  0x0201
>>> +#define TDA19989N2                0x0202
>>> +#define TDA19988                  0x0301
>>
>>
>> Maybe split this into device_version/revision? What does N2 stand for
>> or is this the name NXP uses for that device?
>
> The register names are based on the names used in the NXP out-of-tree
> driver (the 50kloc monstrosity, if you've seen it).. that was pretty
> much all the register level documentation I had.

Yeah, but there is a comment about N2, that says the last bit is "not a
register bit, but is derived by the driver from the new N5 registers..".
I guess you will not see that many i2c devices returning you "N2" version
registers..

>>> [...]
>>
>>> +static void
>>> +cec_write(struct drm_encoder *encoder, uint16_t addr, uint8_t val)
>>> +{
>>> +       struct i2c_client *client = to_tda998x_priv(encoder)->cec;
>>> +       uint8_t buf[] = {addr, val};
>>> +       int ret;
>>> +
>>> +       ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
>>> +       if (ret<   0)
>>> +               dev_err(&client->dev, "Error %d writing to cec:0x%x\n",
>>> ret, addr);
>>> +}
>>
>>
>> Has there been any decision on how to split/integrate cec from drm?
>> Or is there display stuff located in cec i2c slave (I see HPD in
>> ..._detect below)?
>
> not sure, but at least in this case it can't really be decoupled.  I
> need to use the CEC interface for HPD (as you noticed) and also to
> power up the HDMI bits..

Just to make things clearer here, TDA998x ususally has two i2c slaves
at power-up, 0x70 (hdmi slave) and 0x34 (cec slave). Are you actually
accessing the cec slave?

[...]
>>> +static bool
>>> +tda998x_encoder_mode_fixup(struct drm_encoder *encoder,
>>> +                         const struct drm_display_mode *mode,
>>> +                         struct drm_display_mode *adjusted_mode)
>>> +{
>>> +       return true;
>>> +}
>>> +
>>> +static int
>>> +tda998x_encoder_mode_valid(struct drm_encoder *encoder,
>>> +                         struct drm_display_mode *mode)
>>> +{
>>> +       return MODE_OK;
>>> +}
>>
>>
>> At least a note would be helpful to see what callbacks are
>> not yet done. I guess there will be some kind of mode check
>> someday?
>
> Well, some of these drm will assume the fxn ptrs are not null, so we
> need something even if it is empty.
>
> I suppose there are must be some upper bounds on pixel clock
> supported, which could perhaps be added some day in _mode_valid().  On

Depends what drm expects on mode_valid or mode_fixup, I haven't dug into
drm encoders, yet. But usually for HDMI/DVI you will only choose between
modes supplied by monitor EDID and not choose something "close". Anyway,
I just think a note about stuff that is not yet working is helpful.

> the device I am working on, the limiting factor is the crtc (upstream
> of the encoder), so I haven't really needed this yet.  I expect that
> as people start using this on some other devices, we'll come across
> some enhancements needed, some places where we need to add some
> configuration, etc.  I cannot really predict exactly what is needed,
> so I prefer just to put the driver out there in some form, and then
> add it it as needed.  So, I wouldn't really say that these functions
> are "TODO", but I also wouldn't say that we won't find some reason to
> add some code there at some point.

Or put it in staging?

>>> [...]
>>>
>>> +static enum drm_connector_status
>>> +tda998x_encoder_detect(struct drm_encoder *encoder,
>>> +                     struct drm_connector *connector)
>>> +{
>>> +       uint8_t val = cec_read(encoder, REG_CEC_RXSHPDLEV);
>>> +       return (val&   CEC_RXSHPDLEV_HPD) ? connector_status_connected :
>>> +                       connector_status_disconnected;
>>> +}
>>
>>
>> This is where cec slave gets called from hdmi i2c driver. Any chance
>> there is HPD status in hdmi registers, too?
>
> Not that I know of.  But like I mentioned, we also need to use the CEC
> interface just to talk to the HDMI interface.  Before setting ENAMODS
> reg via cec address, the hdmi address won't even show up (for ex, on
> i2cdetect).

Again, I quickly checked the public sources. The cec slave looks like is
only for cec communication, i.e. actually sending/receiving messages.
But from your patch it isn't even clear to me, when you access hdmi or
cec slave as you are bypassing i2c client subsystem somehow.

> Maybe there is some way that this code should register some interface
> with CEC driver/subsystem?  (Is there such a thing?  I am not really
> CEC expert.)  But I don't think there is any way to completely split
> it out.

When speaking about CEC subsystem you mean sending/receiving cec messages
and the corresponding kernel API? That can come later, for now everything
this driver needs can IMHO depend on EDID, i.e. DVI-style, only.
CEC communication can come later.

>>> +/* I2C driver functions */
>>> +
>>> +static int
>>> +tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>> +{
>>> +       return 0;
>>> +}
>>> +
>>> +static int
>>> +tda998x_remove(struct i2c_client *client)
>>> +{
>>> +       return 0;
>>> +}
>>
>>
>> Hmm, empty _probe and _remove? Maybe these should get some code
>> from _init below?
>
> naw, they aren't really used for drm i2c encoder slaves.

Well, if you use a i2c_client_addr != 0 below, the i2c subsystem will only
bother you if it finds e.g. device 0x70 on an i2c bus. So they should be
used. The drm API must be clear about what should happen in encoder_init
and encoder_probe.

>>> +static int
>>> +tda998x_encoder_init(struct i2c_client *client,
>>> +                   struct drm_device *dev,
>>> +                   struct drm_encoder_slave *encoder_slave)
>>> +{
>>> +       struct drm_encoder *encoder =&encoder_slave->base;
>>>
>>> +       struct tda998x_priv *priv;
>>> +
>>> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>> +       if (!priv)
>>> +               return -ENOMEM;
>>> +
>>> +       priv->current_page = 0;
>>> +       priv->cec = i2c_new_dummy(client->adapter, 0x34);
>>> +       priv->dpms = DRM_MODE_DPMS_OFF;
>>> +
>>> +       encoder_slave->slave_priv = priv;
>>> +       encoder_slave->slave_funcs =&tda998x_encoder_funcs;
>>> +
>>> +       /* wake up the device: */
>>> +       cec_write(encoder, REG_CEC_ENAMODS,
>>> +                       CEC_ENAMODS_EN_RXSENS | CEC_ENAMODS_EN_HDMI);
>>> +
>>> +       tda998x_reset(encoder);
>>> +
>>> +       /* read version: */
>>> +       priv->rev = reg_read(encoder, REG_VERSION_LSB) |
>>> +                       reg_read(encoder, REG_VERSION_MSB)<<   8;
>>> +
>>> +       /* mask off feature bits: */
>>> +       priv->rev&= ~0x30; /* not-hdcp and not-scalar bit */
>>
>>
>> If revision register contains features, why not save them for later
>> driver improvements?
>>
>
> can be added later if the need arises.  I prefer to leave out code
> that only might be used later.. otherwise it is a good way to
> accumulate cruft.

True, but magic masking (~0x30) and some comments don't help either.

>>
>>> +       switch (priv->rev) {
>>> +       case TDA9989N2:  dev_info(dev->dev, "found TDA9989 n2");  break;
>>> +       case TDA19989:   dev_info(dev->dev, "found TDA19989");    break;
>>> +       case TDA19989N2: dev_info(dev->dev, "found TDA19989 n2"); break;
>>> +       case TDA19988:   dev_info(dev->dev, "found TDA19988");    break;
>>> +       default:
>>> +               DBG("found unsupported device: %04x", priv->rev);
>>> +               goto fail;
>>> +       }
>>
>>
>> I think printing revision is sufficient, no user will care about the
>> actual device or revision.
>>
>>
>>> +       /* after reset, enable DDC: */
>>> +       reg_write(encoder, REG_DDC_DISABLE, 0x00);
>>> +
>>> +       /* set clock on DDC channel: */
>>> +       reg_write(encoder, REG_TX3, 39);
>>
>>
>> This should be kept disabled as long as there is no monitor attached
>> (HPD!)
>>
>
> The sequence is based on NXP's driver.. I'll have to go back and
> check, but IIRC there were a few things I had to turn on just to make
> HPD work in the first place.

Hmm, I have seen a note about issues with some monitors that expect
ddc clock to be stable very early. And this looks like the NXP proposed
workaround to always clock ddc - but it tells nothing about the reason
and more important the note from NXP clearly puts some restrictions on
how hdmi tx needs to be clocked by pixclk. Can you ensure a stable pixclk
at this point at all?

> Ofc, if there were actually some decent docs about the part, it would
> be a bit easier to know what is actually required and what is not.  So
> I don't claim everything in it's current form is optimal.

I know, everybody knows I guess. But that is what this list is for,
discussing when a driver is ready to be mainlined. And without regmap
and proper i2c client handling, I have a feeling that it is not close.

>>> +       /* if necessary, disable multi-master: */
>>> +       if (priv->rev == TDA19989)
>>> +               reg_set(encoder, REG_I2C_MASTER, I2C_MASTER_DIS_MM);
>>> +
>>> +       cec_write(encoder, REG_CEC_FRO_IM_CLK_CTRL,
>>> +                       CEC_FRO_IM_CLK_CTRL_GHOST_DIS |
>>> CEC_FRO_IM_CLK_CTRL_IMCLK_SEL);
>>> +
>>> +       return 0;
>>> +
>>> +fail:
>>> +       /* if encoder_init fails, the encoder slave is never registered,
>>> +        * so cleanup here:
>>> +        */
>>> +       if (priv->cec)
>>> +               i2c_unregister_device(priv->cec);
>>> +       kfree(priv);
>>> +       encoder_slave->slave_priv = NULL;
>>> +       encoder_slave->slave_funcs = NULL;
>>> +       return -ENXIO;
>>> +}
>>> +
>>> +static struct i2c_device_id tda998x_ids[] = {
>>> +       { "tda998x", 0 },
>>> +       { }
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, tda998x_ids);
>>
>>
>> Shouldn't the above carry the hdmi core i2c address at least?
>>
>
> no, it should come from the user of the encoder slave.  Actually the
> CEC address should too, but current drm i2c encoder slave code sort of
> assumes the device just has a single address

Hmm, that is a limitation for sure. Well I checked drm_encoder_slave and
it is calling i2c_register_driver directly. Passing a valid i2c slave address
will work here.

For the cec i2c slave, we at least know that it is on the same i2c bus
and can probe it during _init or _probe ourselves.

Sebastian
