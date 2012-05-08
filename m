From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 4/4] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Tue, 8 May 2012 10:33:35 +0530
Message-ID: <4FA8A927.9080705@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>  <1336028864-13895-1-git-send-email-archit@ti.com>  <1336028864-13895-5-git-send-email-archit@ti.com> <1336403017.3522.2.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43181 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab2EHFER (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 01:04:17 -0400
In-Reply-To: <1336403017.3522.2.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 07 May 2012 08:33 PM, Tomi Valkeinen wrote:
> On Thu, 2012-05-03 at 12:37 +0530, Archit Taneja wrote:
>> In order to check the validity of overlay and manager info, there was a need to
>> use the omap_dss_device struct to get the panel resolution. The manager's
>> private data in APPLY now contains the manager timings. Hence, we don't need to
>> rely on the display resolution any more.
>>
>> Create a function dss_mgr_get_timings() which returns the timings in manager's
>> private data. Remove the need of passing omap_dss_device structs in the
>> functions which check for overlay and managers.
>>
>> Have some initial values for manager timings in apply_init(), these would ensure
>> that manager checks don't fail if an interface driver or a panel driver hasn't
>> set the manager timings yet.
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>
>> +struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manager *mgr)
>> +{
>> +	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>> +
>> +	return&mp->timings;
>> +}
>
> This one returns a pointer into apply.c's internal data structures. The
> safest way would be to return a copy, but as it's an omapdss internal
> function, I think it's enough to return a pointer to a const struct.

Okay I'll fix that, I was a bit concerned about the locking here, I use 
this function in the later series to remove some dssdev references in 
dispc.c. I traced the paths and saw that in all cases this function 
would be protected by the data_lock spinlock, but not the apply_lock 
mutex in all cases. Any thoughts on this?

Archit

>
>   Tomi
>

