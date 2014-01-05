From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] ARM: OMAPFB: panel-sony-acx565akm: fix missing mutex
 unlocks
Date: Sun, 05 Jan 2014 14:58:17 +0200
Message-ID: <52C956E9.2030008@gmail.com>
References: <1388420272-5132-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <20140104125108.GA22339@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140104125108.GA22339@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

On 04.01.2014 14:51, Pavel Machek wrote:
> On Mon 2013-12-30 18:17:52, Ivaylo Dimitrov wrote:
>> From: Ivaylo Dimitrov <freemangordon@abv.bg>
>>
>> Commit c37dd677988ca50bc8bc60ab5ab053720583c168 fixes the unbalanced
>> unlock in acx565akm_enable but introduces another problem - if
>> acx565akm_panel_power_on exits early, the mutex is not unlocked. Fix
>> that by unlocking the mutex on early return. Also add mutex protection in
>> acx565akm_panel_power_off and remove an unused variable
>>
>> Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

Hmm, I introduced a bug with that patch (recursive lock), will send a 
new version that fixes it

Regards,
Ivo
