From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 3/4] drm/tilcdc: add encoder slave
Date: Thu, 24 Jan 2013 08:31:44 -0600
Message-ID: <CAF6AEGvCf8CJ8StLk7XvNHctehQ+1BOVeFb9qV=ssBnprujidA@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
	<1358894185-21617-4-git-send-email-robdclark@gmail.com>
	<20130124130114.GB31306@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:38627 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3AXObp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 09:31:45 -0500
Received: by mail-vc0-f169.google.com with SMTP id n10so2208395vcn.28
        for <linux-omap@vger.kernel.org>; Thu, 24 Jan 2013 06:31:44 -0800 (PST)
In-Reply-To: <20130124130114.GB31306@phenom.ffwll.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thu, Jan 24, 2013 at 7:01 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Jan 22, 2013 at 04:36:24PM -0600, Rob Clark wrote:
>> Add output panel driver for i2c encoder slaves.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>
> Found some more stuff ...
>
> [cut]
>
>> +static const struct drm_encoder_helper_funcs slave_encoder_helper_funcs = {
>> +             .dpms           = drm_i2c_encoder_dpms,
>> +             .mode_fixup     = drm_i2c_encoder_mode_fixup,
>> +             .prepare        = slave_encoder_prepare,
>> +             .commit         = drm_i2c_encoder_commit,
>> +             .mode_set       = drm_i2c_encoder_mode_set,
>> +             .save           = drm_i2c_encoder_save,
>> +             .restore        = drm_i2c_encoder_restore,
>> +};
>
> I couldn't find these wrappers anywhere ...

this is in one of the dependent patches (also on my tilcdc-next branch):

https://patchwork.kernel.org/patch/1950971/

I also cleaned up nouveau to use 'em:

https://patchwork.kernel.org/patch/1951051/

>> +
>> +static const struct i2c_board_info info = {
>> +             I2C_BOARD_INFO("tda998x", 0x70)
>> +};
>
> Shouldn't there be some of/devicetree thing to tell us which one to load?

There are limited options for the i2c addresses, and all the boards
I've seen which have this part are at 0x70 and 0x34 for CEC.  Probably
the CEC address needs to come from a config struct or maybe the i2c
encoder just gets passed a 'struct device_node *'.  I'm not really
sure the best way to handle that to share the encoder between DT and
non-DT platforms, and since I didn't really need the configurability
yet, I just left that for now and decided we could figure out how to
handle that as the need arose.

BR,
-R

> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
