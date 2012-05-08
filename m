From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v3 4/5] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Tue, 8 May 2012 18:05:01 +0530
Message-ID: <4FA912F5.9030604@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>   <1336471096-21096-1-git-send-email-archit@ti.com>   <1336471096-21096-5-git-send-email-archit@ti.com>  <1336474223.1821.6.camel@lappyti> <4FA901EC.8020002@ti.com> <1336478139.5761.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54849 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425Ab2EHMfn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 08:35:43 -0400
In-Reply-To: <1336478139.5761.27.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 08 May 2012 05:25 PM, Tomi Valkeinen wrote:
> On Tue, 2012-05-08 at 16:52 +0530, Archit Taneja wrote:
>> On Tuesday 08 May 2012 04:20 PM, Tomi Valkeinen wrote:
>
>>> Checking the validity of all the settings is a bit tricky, but currently
>>> I think, as a rule of thumb, we should accept any settings when things
>>> are disabled. So, until the interface driver sets the timings before
>>> enabling the output, all ovl/mgr settings should be allowed. And we
>>
>> We have 2 ways to go about this, one is to have an initial set of
>> 'always valid' values like I have done, the other option is to ignore
>> manager timing related checks if the manager is disabled, i.e all
>> configs are okay. To implement the second option, I think our function
>> dss_check_settings_low() would get more complicated. We would now have
>> to pass mp->enabled outside of apply, and pass it to dss_mgr_check()
>> which would further need to pass this to dss_ovl_check(). Hence I used
>> the first approach.
>
> I'm not sure about that. We already do it for overlay. In ovl.c we have
> dss_ovl_simple_check() and dss_ovl_check(). The simple check sees if the
> settings pass basic sanity check. The check sees if all the ovl&  mgr
> settings are compatible with each other.
>
> Simple check is done when setting the config, called from
> dss_ovl_set_info(). The proper check is done later when the actual
> config is about to be taken into use.
>
> If mp->enabled == false, can't we just skip dss_check_settings_low()
> totally for that manager? We skip the check for ovls the same way.

Okay, this would work better I guess. If someone tries to enable the 
manager without setting the timings, that check should fail, and in my 
approach, it would have passed, and would have led to bad stuff later.

>
>>> shouldn't even write any shadow registers until the moment the output is
>>> enabled.
>>
>> That's being done correctly even now I guess, with the checks for
>> mp->enabled in wrtie_regs() and set_go_bits().
>
> Yes, for timings. I was thinking more about the other settings done in
> dpi.c currently, like dispc_mgr_set_pol_freq(). That writes directly to
> registers, so we need runtime_get for that.

Ok.

Archit

>
>   Tomi
>

