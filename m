From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAPFB: panel-sony-acx565akm: fix missing mutex
 unlocks
Date: Sat, 11 Jan 2014 11:39:08 +0200
Message-ID: <52D1113C.8020807@gmail.com>
References: <52C956E9.2030008@gmail.com> <1388927585-5640-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <52CFD1ED.7010302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:55646 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaAKJjX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Jan 2014 04:39:23 -0500
In-Reply-To: <52CFD1ED.7010302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: plagnioj@jcrosoft.com, pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>, Aaro Koskinen <aaro.koskinen@iki.fi>

On 10.01.2014 12:56, Tomi Valkeinen wrote:
> On 2014-01-05 15:13, Ivaylo Dimitrov wrote:
>> From: Ivaylo Dimitrov <freemangordon@abv.bg>
>>
>> Commit c37dd677988ca50bc8bc60ab5ab053720583c168 fixes the unbalanced
>> unlock in acx565akm_enable but introduces another problem - if
>> acx565akm_panel_power_on exits early, the mutex is not unlocked. Fix
>> that by unlocking the mutex on early return. Also add mutex protection in
>> acx565akm_panel_power_off and remove an unused variable
>>
>
> I think this is just getting more messy. How about we more or less revert the c37dd677988ca50bc8bc60ab5ab053720583c168 and fix it like this:
>

I am fine with whatever patch you may come with, as long as it fixes the 
issue.

>
> diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> index 714ee92dfb9f..8e97d06921ff 100644
> --- a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> +++ b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c

The patch does not apply cleanly on top of rc7, however I applied it by 
hand. So far it seems it fixes the issue brought by 
c37dd677988ca50bc8bc60ab5ab053720583c168, though I didn't test if 
mutex_lock/mutex_unlock are complementary in every code path (at least 
not explicitly, I guess maemo is doing it for us anyway :) ).

So, shall I send a patch incorporating your code changes, or you will do it?

Regards,
Ivo

