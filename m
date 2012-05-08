From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 1/4] OMAPDSS: APPLY: Add manager timings as extra_info
 in private data
Date: Tue, 8 May 2012 09:54:43 +0530
Message-ID: <4FA8A00B.4040600@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>  <1336028864-13895-1-git-send-email-archit@ti.com>  <1336028864-13895-2-git-send-email-archit@ti.com> <1336402071.2667.16.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44563 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab2EHEZ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 00:25:28 -0400
In-Reply-To: <1336402071.2667.16.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Monday 07 May 2012 08:17 PM, Tomi Valkeinen wrote:
> Hi,
>
> On Thu, 2012-05-03 at 12:37 +0530, Archit Taneja wrote:
>> DISPC manager size and DISPC manager blanking parameters(for LCD managers)
>> follow the shadow register programming model. Currently, they are programmed
>> directly by the interface drivers.
>>
>> To configure manager timings using APPLY, there is a need to introduce extra
>> info flags for managers, similar to what is done for overlays. This is needed
>> because timings aren't a part of overlay_manager_info struct configured by a
>> user of DSS, they are configured internally by the interface or panel drivers.
>>
>> Add dirty and shadow_dirty extra_info flags for managers, update these flags
>> at the appropriate places. Rewrite the function extra_info_update_ongoing()
>> slightly as checking for manager's extra_info flags can simplify the code a bit.
>>
>> Create function dss_mgr_set_timings() which applies the new manager timings to
>> extra_info.
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>
> <snip>
>
>> +static void dss_apply_mgr_timings(struct omap_overlay_manager *mgr,
>> +		struct omap_video_timings *timings)
>> +{
>> +	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>> +
>> +	mp->timings = *timings;
>> +	mp->extra_info_dirty = true;
>> +}
>> +
>> +void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
>> +		struct omap_video_timings *timings)
>> +{
>> +	unsigned long flags;
>> +
>> +	mutex_lock(&apply_lock);
>> +
>> +	spin_lock_irqsave(&data_lock, flags);
>> +
>> +	dss_apply_mgr_timings(mgr, timings);
>> +
>> +	spin_unlock_irqrestore(&data_lock, flags);
>> +
>> +	mutex_unlock(&apply_lock);
>> +}
>
> With this, dpi.c&  others still need to use dispc_mgr_go(), which is
> something that should be removed and done only from apply.c.

Ah ok, so with this set, dss_mgr_set_timings() doesn't ensure that the 
configuration is taken in, the configuration may go in the next 
overlay/manager enable or the next mgr_apply, but that may happen much 
later.

>
> dss_<ovl|mgr>_<enable|disable>  functions handle GO, so you could have a
> look at them. However, setting the timings is a bit different, so I'm
> not sure how it should be done.
>
> I think we have a few different options:
>
> - Separate omapdss internal function (in apply.c) that can be used to
> set GO after set_timings
>
> - set GO in dss_mgr_set_timings(), but don't block
>
> - set GO in dss_mgr_set_timings(), and block until the changes are in HW
> (this is more or less what the dss_<ovl|mgr>_<enable|disable>  functions
> do).
>
> The first one would be good if the interface drivers would need to set
> multiple configurations, and we don't want to block after each set call.
> But we don't have anything like that, at least currently.
>
> The second one avoids blocking, but could perhaps cause problems because
> the timings are not actually used yet when the function returns.
>
> I don't see any problem with the last option, so I'm slightly leaning
> towards it.

The 3rd option looks good to me too, but I'm wondering if we would need 
to do the same things with all manager parameters which are in shadow 
registers. Like in dpi.c, in dpi_set_mode() we set the DISPC_POL_FREQ 
and DISPC_DIVISORo registers, writing GO for each parameter would be in 
efficient, it's good that it doesn't happen much often. Maybe we could 
group the rest of these parameters.

Archit

>
>   Tomi
>

