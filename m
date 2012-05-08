From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v3 4/5] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Tue, 8 May 2012 16:52:20 +0530
Message-ID: <4FA901EC.8020002@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>  <1336471096-21096-1-git-send-email-archit@ti.com>  <1336471096-21096-5-git-send-email-archit@ti.com> <1336474223.1821.6.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51996 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841Ab2EHLXD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 07:23:03 -0400
In-Reply-To: <1336474223.1821.6.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 08 May 2012 04:20 PM, Tomi Valkeinen wrote:
> On Tue, 2012-05-08 at 15:28 +0530, Archit Taneja wrote:
>> In order to check the validity of overlay and manager info, there was a need to
>> use the omap_dss_device struct to get the panel resolution. The manager's
>> private data in APPLY now contains the manager timings. Hence, we don't need to
>> rely on the display resolution any more.
>>
>> Pass the manager's timings(in private data) to dss_mgr_check(). Remove the need
>> of passing omap_dss_device structs in the functions which check for overlay and
>> managers.
>>
>> Have some initial values for manager timings in apply_init(), these would ensure
>> that manager checks don't fail if an interface driver or a panel driver hasn't
>> set the manager timings yet.
>
> In what code patch were the initial values needed?

I guess you meant code path. If a panel driver doesn't have set_timings 
op, then we get into trouble with omapfb. The following steps happen:

- try to set timings of display
- create buffers, configure overlays according to omap_dss_device
- call mgr->apply()
- enable the panel

For panels which don't have set_timings populated, if apply is called, 
the manager timings are still zero, and the mgr->apply fails when 
dss_mgr_check() is called.

When the panel driver's enable is called, the timings are configured in 
the interface drivers 'enable'. The enables(like 
dpi_display_enable,dsi_display_enable) of all interface driver's call 
dss_mgr_set_timings(), so we are sure that the timings are configured by 
then. But there is no such guarantee at set timings.

Things used to work previously because we used to simply get the 
connected panel and use its dimensions, if there was no panel connected, 
we used to skip the check.

>
> Checking the validity of all the settings is a bit tricky, but currently
> I think, as a rule of thumb, we should accept any settings when things
> are disabled. So, until the interface driver sets the timings before
> enabling the output, all ovl/mgr settings should be allowed. And we

We have 2 ways to go about this, one is to have an initial set of 
'always valid' values like I have done, the other option is to ignore 
manager timing related checks if the manager is disabled, i.e all 
configs are okay. To implement the second option, I think our function 
dss_check_settings_low() would get more complicated. We would now have 
to pass mp->enabled outside of apply, and pass it to dss_mgr_check() 
which would further need to pass this to dss_ovl_check(). Hence I used 
the first approach.

> shouldn't even write any shadow registers until the moment the output is
> enabled.

That's being done correctly even now I guess, with the checks for 
mp->enabled in wrtie_regs() and set_go_bits().

>
> Except settings that do not depend on anything, like, if max ovl width
> is 2048, it's fine to reject 2049+ width anytime.
>
>> -int dss_ovl_check(struct omap_overlay *ovl,
>> -		struct omap_overlay_info *info, struct omap_dss_device *dssdev)
>> +int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
>> +		const struct omap_video_timings *mgr_timings)
>>   {
>>   	u16 outw, outh;
>> -	u16 dw, dh;
>> +	u16 mgr_width, mgr_height;
>>
>> -	if (dssdev == NULL)
>> -		return 0;
>> -
>> -	dssdev->driver->get_resolution(dssdev,&dw,&dh);
>> +	mgr_width = mgr_timings->x_res;
>> +	mgr_height = mgr_timings->y_res;
>
> I think you could've just used the existing dw and dh variables, thus
> avoiding the need to change the rest of the function. The 'd' refers to
> display, which is more or less the same as mgr width.

I'll fix this.

Archit

>
>   Tomi
>

