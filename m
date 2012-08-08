From: Archit Taneja <a0393947@ti.com>
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel
 driver to interface
Date: Wed, 8 Aug 2012 12:17:48 +0530
Message-ID: <50220B94.5040303@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>  <1344349948.7216.82.camel@lappyti> <502201B7.9030205@ti.com> <1344407158.17575.21.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45831 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857Ab2HHGtP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 02:49:15 -0400
In-Reply-To: <1344407158.17575.21.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com

On Wednesday 08 August 2012 11:55 AM, Tomi Valkeinen wrote:
> On Wed, 2012-08-08 at 11:35 +0530, Archit Taneja wrote:
>> On Tuesday 07 August 2012 08:02 PM, Tomi Valkeinen wrote:
>>> On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
>>>> This series tries to make interface drivers less dependent on omap_dss_device
>>>> which represents a panel/device connected to that interface. The current way of
>>>> configuring an interface is to populate the panel's omap_dss_device instance
>>>> with parameters common to the panel and the interface, they are either populated
>>>> in the board file, or in the panel driver. Panel timings, number of lanes
>>>> connected to interface, and pixel format are examples of such parameters, these
>>>> are then extracted by the interface driver to configure itself.
>>>
>>> The series looks good. I had only a few comments to make, but obviously
>>> this needs quite a bit of testing. I'll try it out.
>>
>> One thing I'm not sure about is whether these new functions should be
>> aware of the state of the output. For example, if we call set_timings()
>> with DSI video mode which is already enabled, the timings won't really
>> take any impact.
>>
>> Similar issues would occur when we try to make other ops like
>> set_data_lines() or set_pixel_format(). These need to be called before
>> the output is enabled. I was wondering if we would need to add
>> intelligence here to make panel drivers less likely to make mistakes.
>
> Hmm, true. It'd be nice if the functions returned -EBUSY if the
> operation cannot be done while the output is enabled.
>
> We have the dssdev->state, but we should get rid of that (or leave it to
> panel drivers). It'd be good if the output drivers know whether the
> output is enabled or not. I think this data is already tracked by
> apply.c. It's about ovl managers, but I think that's practically the
> same as output.
>
> Calling dss_mgr_enable() will set mp->enabled = true, which could be
> returned via dss_mgr_is_enabled() or such.
>
> Then again, it wouldn't be many lines of codes to track the enable-state
> in each output driver. So if we have any suspicions that mp->enabled
> doesn't quite work for, say, dsi, we could just add a private "enabled"
> member to dsi. But I don't right away see why dss_mgr_is_enabled()
> wouldn't work.
>

I think we had discussed previously that it may not the best idea to see 
if a manager is enabled via mp->enabled as it's always possible that it 
changes afterwards. Same for any other parameter in APPLY's private 
data. This was the reason why we passed privtate data to DISPC functions 
rather than creating apply helper functions which return the value of a 
private data. For example, we pass manager timings to dispc_ovl_setup(), 
instead of DISPC using a function like dss_mgr_get_timings().

I also don't see why dss_mgr_is_enabled() wouldn't work. The only places 
where the manager's state will change are the output's enable and 
disable ops. The mutex maintained by the output would ensure 
sequential-ity between the output's enable() and set_timings() op, and 
hence ensure the manager's state we see is fine.

If we manage the 'enabled' state for each output interface, we would be 
a bit more consistent with respect to other parameters. For example, 
timings is maintained by both manager and the output. Also, if we need 
to separate out manager configurations from outputs in the future, it 
would probably be better for the output to query it's own state rather 
than depending on the manager, which could be configured either earlier 
or later.

Archit

