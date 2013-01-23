From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 2/4] drm/i2c: nxp-tda998x (v2)
Date: Wed, 23 Jan 2013 07:25:45 -0600
Message-ID: <CAF6AEGveA9eE6+3W_fRpZC-cs3O80vWWeQNN5CwRj2+TciSAVw@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
	<1358894185-21617-3-git-send-email-robdclark@gmail.com>
	<20130123104230.38cfc515@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:62779 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab3AWNZq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 08:25:46 -0500
Received: by mail-vb0-f41.google.com with SMTP id l22so3633137vbn.14
        for <linux-omap@vger.kernel.org>; Wed, 23 Jan 2013 05:25:45 -0800 (PST)
In-Reply-To: <20130123104230.38cfc515@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wed, Jan 23, 2013 at 3:42 AM, Jean-Francois Moine <moinejf@free.fr> =
wrote:
> On Tue, 22 Jan 2013 16:36:23 -0600
> Rob Clark <robdclark@gmail.com> wrote:
>
>> Driver for the NXP TDA998X i2c hdmi encoder slave.
>>
>> v1: original
>> v2: fix npix/nline programming
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>>  drivers/gpu/drm/i2c/Makefile      |   3 +
>>  drivers/gpu/drm/i2c/tda998x_drv.c | 908 +++++++++++++++++++++++++++=
+++++++++++
>>  2 files changed, 911 insertions(+)
>>  create mode 100644 drivers/gpu/drm/i2c/tda998x_drv.c
>         [snip]
>> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c=
/tda998x_drv.c
>> new file mode 100644
>> index 0000000..02054e8
>> --- /dev/null
>> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
>> @@ -0,0 +1,908 @@
>         [snip]
>> +static void __exit
>> +tda998x_exit(void)
>> +{
>> +     DBG("");
>> +     drm_i2c_encoder_unregister(&tda998x_driver);
>> +}
>> +
>> +MODULE_DESCRIPTION("NXP Semiconductors TDA998X TMDS transmitter dri=
ver");
>> +
>> +MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
>> +MODULE_DESCRIPTION("NXP Semiconductors TDA998X HDMI Encoder");
>> +MODULE_LICENSE("GPL");
>> +
>> +module_init(tda998x_init);
>> +module_exit(tda998x_exit);
>
> There are 2 MODULE_DESCRIPTION().

oh, whoops.. I'll fix that

BR,
-R

> --
> Ken ar c'henta=F1 |             ** Breizh ha Linux atav! **
> Jef             |               http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
