From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 0/7] Use DRM component API in tilcdc to connect to
 tda998x
Date: Tue, 24 Mar 2015 17:45:10 +0200
Message-ID: <55118686.6060803@ti.com>
References: <cover.1426668480.git.jsarha@ti.com> <55115DA8.1000704@ti.com> <55117479.5090701@ti.com> <55117FD0.4000901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45034 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbbCXPp1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 11:45:27 -0400
In-Reply-To: <55117FD0.4000901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr

On 03/24/15 17:16, Tomi Valkeinen wrote:
> On 24/03/15 16:28, Jyri Sarha wrote:
>
>> I tried first with 3.19 and then with 4.0-rc5, checked the boot and then
>> the modetest, but I could not reproduce the trace above.
>>
>> In my config I just have CONFIG_DRM=m and CONFIG_DRM_I2C_NXP_TDA998X=m
>> on top of plain omap2plus_defconfig. Should I take something else?
>>
>> Anyway, I doubt this has anything to do with my patches. Could you give
>> it one more try without my patches?
>
> 4.0-rc3 works ok for me without your patches. I can run modetest and I
> get a picture on the monitor.
>
> Well, not 100% ok. If I run my test app, I get "BUG: sleeping function
> called from invalid context at drivers/base/power/runtime.c:949".
>
> With your patches I get the warnings  and I don't get anything on the
> screen.
>
> I've attached my kernel config.
>
> Hmm. The warning comes if tilcdc_crtc_mode_valid() fails (I think). My
> monitor is not a HDMI monitor. It has native mode 1920x1200@60, which
> cannot be produced by tilcdc, and on -rc3 the mode picked is 1280x960@60.
>

Oh-o. That is the reason then. My HDMI TV also - wrongly - advertises 
having 1920x1200@60 mode. When that mode produced the error I did not 
think much of it and tested with other modes.

> Maybe this is somehow related? You're using a HDMI TV? What mode does it
> pick? Is it the native mode?
>
> Hmm, yes, I think it's related. Enabling debug prints shows:
>
> [   32.361924] [drm:tilcdc_crtc_mode_valid] Processing mode 1920x1080@60
> with pixel clock 148500
> [   32.370850] [drm:tilcdc_crtc_mode_valid] Pruning mode: pixel clock
> too high
> [   32.378143] ------------[ cut here ]------------
> [   32.382993] WARNING: CPU: 0 PID: 50 at
> drivers/gpu/drm/tilcdc/tilcdc_crtc.c:269
> tilcdc_crtc_mode_set+0x5ec/0x648 [tilcdc]()
> [   32.394641] Modules linked in: tilcdc tda998x drm_kms_helper drm
> [   32.400964] CPU: 0 PID: 50 Comm: kworker/0:2 Not tainted
> 4.0.0-rc3-00007-g944a1f8a79f1 #16
> [   32.409617] Hardware name: Generic AM33XX (Flattened Device Tree)
>
> So maybe your series removes some filtering somewhere, and illegal modes
> get passed forward?
>

It indeed looks like that. The actual tilcdc_slave code does not have 
much much logic in it, but is sounds like the DRM slave encoder API and 
the DRM external encoder API are not entirely entirely "compatible".

I'll try to track this further.

Thanks,
Jyri

