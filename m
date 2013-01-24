From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/4] drm/tilcdc: add encoder slave
Date: Thu, 24 Jan 2013 14:01:14 +0100
Message-ID: <20130124130114.GB31306@phenom.ffwll.local>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-4-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:42587 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab3AXM7J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 07:59:09 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so407381wib.10
        for <linux-omap@vger.kernel.org>; Thu, 24 Jan 2013 04:59:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358894185-21617-4-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, Jan 22, 2013 at 04:36:24PM -0600, Rob Clark wrote:
> Add output panel driver for i2c encoder slaves.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>

Found some more stuff ...

[cut]

> +static const struct drm_encoder_helper_funcs slave_encoder_helper_funcs = {
> +		.dpms           = drm_i2c_encoder_dpms,
> +		.mode_fixup     = drm_i2c_encoder_mode_fixup,
> +		.prepare        = slave_encoder_prepare,
> +		.commit         = drm_i2c_encoder_commit,
> +		.mode_set       = drm_i2c_encoder_mode_set,
> +		.save           = drm_i2c_encoder_save,
> +		.restore        = drm_i2c_encoder_restore,
> +};

I couldn't find these wrappers anywhere ...

> +
> +static const struct i2c_board_info info = {
> +		I2C_BOARD_INFO("tda998x", 0x70)
> +};

Shouldn't there be some of/devicetree thing to tell us which one to load?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
