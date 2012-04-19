From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 4/6] OMAPDSS: MANAGER: Make DISPC timings a manager_info
 parameter
Date: Thu, 19 Apr 2012 11:43:21 +0530
Message-ID: <4F8FAD01.3090406@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>  <1334561027-28569-5-git-send-email-archit@ti.com> <1334761105.2027.67.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36204 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab2DSGNy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 02:13:54 -0400
In-Reply-To: <1334761105.2027.67.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 18 April 2012 08:28 PM, Tomi Valkeinen wrote:
> On Mon, 2012-04-16 at 12:53 +0530, Archit Taneja wrote:
>> DISPC manager size and DISPC manager blanking parameters(for LCD managers)
>> follow the shadow register programming model. Currently, they are programmed
>> directly by the interface drivers.
>>
>> Make timings(omap_video_timing struct) an overlay_manager_info member, they are
>> now programmed via the apply mechanism used for programming shadow registers.
>>
>> The interface driver now call the function dss_mgr_set_timings() which applies
>> the new timing parameters, rather than directly writing to DISPC registers.
>
> I don't think that works correctly. The omap_overlay_manager_info is
> supposed to be set with set_manager_info() by the user of omapdss, to
> configure the manager's features. The timings are not supposed to be set
> via that mechanism, but with dssdev->set_timings().
>
> This is similar to the info and extra_info for overlay. info has stuff
> that omapdss doesn't change, it just uses what the user gives.
> extra_info, on the other hand, has omapdss private stuff that the user
> does not see. Timings are clearly private stuff in this sense, because
> they are set via dssdev->set_timings().
>
> One reason for this is the programming model we use. If the user of
> omapdss does get_info() for two overlays, changes the infos, and then
> calls set_info() for both overlays and finally apply() for the manager,
> we don't do any locking there because omapdss presumes the info is
> handled by one user. If, say, the dpi.c would change the info and call
> apply at the same time, the configuration could go badly wrong.

I think I get your point. So even though get_info() and set_info() fn's 
are spinlock protected, if there are 2 users setting the info, it 
doesn't mean that the info they finally written is correct. Is this 
example the same thing as what you mean ? :

In order of time:

-user 1 gets an overlay's info

-user 2 gets an overlay's info

-user 1 modifies and sets overlay info

-user 2 sets overlay info without the knowledge of what user 1 did.

So even though we ensure these events happen sequentially, we don't 
protect the info across multiple users.

>
> So I think what should be done is to add similar "extra" flags and code
> to mgr_priv_data that we have for ovl_priv_data, and add
> omap_video_timings to mgr_priv_data (the same way as we have, say,
> fifo_low for ovl_priv_data).
>
> And then add similar function to dss_ovl_write_regs_extra() for manager,
> and a function like dss_apply_ovl_fifo_thresholds() for timings. And
> finally a non-static function to set the timings (used by dpi.c etc),
> which calls the similar function to dss_apply_ovl_fifo_thresholds(), and
> dss_write_regs() and dss_set_go_bits().

Okay, I'll work on it along these lines.

>
>   Tomi
>

