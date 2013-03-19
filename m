From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2 3/4] drm/omap: Make fixed resolution panels work
Date: Tue, 19 Mar 2013 12:15:53 +0530
Message-ID: <514809A1.9050108@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1363093583-28285-1-git-send-email-archit@ti.com> <513F3658.3000300@ti.com> <513F3DE5.2090903@ti.com> <513F4154.5040904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60620 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933945Ab3CSGqm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 02:46:42 -0400
In-Reply-To: <513F4154.5040904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

On Tuesday 12 March 2013 08:23 PM, Tomi Valkeinen wrote:
> On 2013-03-12 16:38, Archit Taneja wrote:
>
>>> memcmp on two structs is often not a good idea. There could be padding
>>> bytes there, with uninitialized data. I'm not sure if that's the case
>>> here, though, but it could well change any time (perhaps even depending
>>> on compiler version).
>>
>> I saw usage of memcmp on structs in the kernel, but then most of them
>> were in drivers and not core, and could be mistakes :)
>>
>> adding '__attribute__((packed))' to omap_video_timings might be helpful
>> I suppose. But I don't know if it's safe to do a memcmp even with a
>> packed struct.
>
> I think it's safe to use memcmp if you know that both structs have been
> initialized to zero with memset.
>
>>> I'm still pondering whether it'd just be simpler to require all the
>>> dssdrv ops to be filled, probably using a helper macro in the panel
>>> drivers... Did you consider that approach? I'm not saying to go for it,
>>> I'm saying I can't make my mind which would be better =).
>>
>> I didn't consider it mainly because I thought we were going to get rid
>> of our private omapdss panel drivers with CDF panels, and efforts in
>> fixing it wouldn't be much useful. But if there isn't any other good
>> alternative, then I can try to see what macros look like.
>
> Well, even if I was slightly optimistic earlier, I now have a feeling
> CDF may take a while. I think we should just go for omapdss dev model
> change first.
>
> One thing to note about the ops is that NULL is currently used to convey
> information, something like "this ops is not possible or valid". So
> adding all the ops may not quite work. For example, adding update op for
> auto-update panels could tell that the panel supports manual update.
> (Well, for that particular case we have a flag, but you get the idea).
>
> But if we can add only some of the ops to the drivers, and there is no
> information lost when we won't have NULLs, I guess that could be the
> simplest option. Then we don't need to add extra code in each place we
> use the ops.
>
>> Of course, simpler options for this patch would be to do a manual
>> compare of the fields instead of a memcmp, or adding default ops in
>> omap_dss_register_driver.
>
> Adding default ops in omap_dss_register_driver() is not good. It
> prevents us from having the ops as const in the future, and is also not
> possible when we either move to CDF or change the omapdss dev model.
>
> So I think either we need to handle the NULLs as you do in this patch,
> or add the ops to the panels. But the ops could still be the default
> versions offered by the omapdss.

I was trying to come up with a macro which could add default ops to the 
omap_dss_driver. It isn't straight forward as I thought, because you 
need to choose either the default op, or the panel driver's op if it 
exists. For example, I can't create a macro which adds an op for 
get_timings() to all panel drivers, the panel drivers which already this 
op defined will have 2 instances of get_timings() in the omap_dss_driver 
struct.

I have been looking around in the kernel to see how undeclared ops in a 
struct are generally dealt with. Till now, I've noticed that the code 
which uses this ops takes the responsibility to check whether they are 
NULL or not.

The easiest way would be to have these default funcs inlined in a 
header, and every panel driver's omap_dss_driver struct fills in the 
default op. This way we can make the driver ops const. Do you have any 
idea of a macro which could do the same as above, and leads to less 
addition of code?

Archit

>
>> One thing about common panel driver functions in general is that they
>> won't use the panel driver's locking. So if a panel driver doesn't
>> create a get_timings() op assuming that omapdss will make a default func
>> for it, we would miss out on the panel lock. I don't know if that's
>> really bad, and doing a memcmp or anything else in omapdrm also doesn't
>> help with this case.
>
> That's true. The locking is a bit of a mess (read: broken =) anyway
> currently.
>
>   Tomi
>
>

