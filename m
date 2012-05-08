From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 4/4] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Tue, 8 May 2012 13:08:21 +0530
Message-ID: <4FA8CD6D.3010503@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>   <1336028864-13895-1-git-send-email-archit@ti.com>   <1336028864-13895-5-git-send-email-archit@ti.com>  <1336403017.3522.2.camel@lappyti> <4FA8A927.9080705@ti.com> <1336461377.1896.23.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34215 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab2EHHjD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 03:39:03 -0400
In-Reply-To: <1336461377.1896.23.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 08 May 2012 12:46 PM, Tomi Valkeinen wrote:
> On Tue, 2012-05-08 at 10:33 +0530, Archit Taneja wrote:
>> On Monday 07 May 2012 08:33 PM, Tomi Valkeinen wrote:
>>> On Thu, 2012-05-03 at 12:37 +0530, Archit Taneja wrote:
>>>> In order to check the validity of overlay and manager info, there was a need to
>>>> use the omap_dss_device struct to get the panel resolution. The manager's
>>>> private data in APPLY now contains the manager timings. Hence, we don't need to
>>>> rely on the display resolution any more.
>>>>
>>>> Create a function dss_mgr_get_timings() which returns the timings in manager's
>>>> private data. Remove the need of passing omap_dss_device structs in the
>>>> functions which check for overlay and managers.
>>>>
>>>> Have some initial values for manager timings in apply_init(), these would ensure
>>>> that manager checks don't fail if an interface driver or a panel driver hasn't
>>>> set the manager timings yet.
>>>>
>>>> Signed-off-by: Archit Taneja<archit@ti.com>
>>>
>>>> +struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manager *mgr)
>>>> +{
>>>> +	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>>>> +
>>>> +	return&mp->timings;
>>>> +}
>>>
>>> This one returns a pointer into apply.c's internal data structures. The
>>> safest way would be to return a copy, but as it's an omapdss internal
>>> function, I think it's enough to return a pointer to a const struct.
>>
>> Okay I'll fix that, I was a bit concerned about the locking here, I use
>> this function in the later series to remove some dssdev references in
>> dispc.c. I traced the paths and saw that in all cases this function
>> would be protected by the data_lock spinlock, but not the apply_lock
>> mutex in all cases. Any thoughts on this?
>
> Hmm, you're right, locking here gets a bit confusing. set_timings has
> locks, so logically get_timings should also. But I guess all the uses of
> get_timings happens via apply.c, and apply.c already holds the
> data_lock, as you said?

Yes.

>
> Making the get_timings function public (inside omapdss) is a bit nasty,
> as it's quite easy to call it without having the appropriate locks. And
> actually there's no way to acquire the locks outside apply.c
>
> I'm not sure if it applies here, but as a general strategy, I suggest
> doing things in apply.c that require data from apply.c's internal data.
> When that's not possible, apply.c should call the functions outside
> apply.c, and pass the internal data as parameters (like calls to dispc).
>
> In your case, I for example see dss_mgr_check() calling
> dss_mgr_get_timings(). It would be quite easy to pass the timings to
> dss_mgr_check() from apply.c, thus removing the need to call the
> function. And, as you see, dss_mgr_check() already has a bunch of
> parameters, and the idea is the same with those: give the params, so
> that dss_mgr_check() doesn't need to ask for them.

Right, I can do this for dss_mgr_check() and dss_ovl_check(), but if I 
you see the misc cleanup patch series I posted, I use 
dss_mgr_get_timings()  in dispc.c functions to remove some 
omap_dss_device references. These DISPC functions are called in 
dispc_ovl_setup(), I could pass manager timings in dispc_ovl_setup() so 
that it comes directly from apply.c. What do you say?

I guess we can get away from exposing private data in apply to DSS, but 
it might get a bit harder when we try to remove other omap_dss_device 
references in the future. I'm just guessing though.

Archit

>
>   Tomi
>

