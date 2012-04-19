From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 0/6] OMAPDSS: APPLY: Treat overlay manager timings as
 shadow registers
Date: Thu, 19 Apr 2012 17:28:13 +0530
Message-ID: <4F8FFDD5.5030302@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com> <1334836135.1911.40.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38691 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab2DSL6q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 07:58:46 -0400
In-Reply-To: <1334836135.1911.40.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 19 April 2012 05:18 PM, Tomi Valkeinen wrote:
> On Mon, 2012-04-16 at 12:53 +0530, Archit Taneja wrote:
>> An overlay manager's timings (the manager size, and blanking parameters if an
>> LCD manager) are DISPC shadow registers, and they should hence follow the
>> correct programming model.
>>
>> This set makes the timings a manager_info parameter. The interface drivers now
>> set the timings in manager_info instead of directly writing to registers.
>>
>> This change also prevents the need to use display resolution for overlay
>> checks, hence making some of the APPLY functions less dependent on the display.
>>
>> These patches apply over:
>>
>> git://gitorious.org/linux-omap-dss2/linux.git dev
>>
>> Archit Taneja (6):
>>    OMAPDSS: DISPC/RFBI: Use dispc_mgr_set_lcd_timings() for setting lcd
>>      size
>>    OMAPDSS: DISPC: Use a common function to set manager timings
>>    OMAPDSS: DISPC: Clean up manager timing/size functions
>>    OMAPDSS: MANAGER: Make DISPC timings a manager_info parameter
>>    OMAPDSS: MANAGER: Check validity of manager timings
>>    OMAPDSS: APPLY: Remove display dependency from overlay and manager
>>      checks
>
> The patches 1, 2 and 3 in this series look like independent cleanups.
> Should I apply those, or do you think there may be changes required?

I think you can pull these 3, they were sort of a prerequisite for the 
apply-manager-timings stuff. I don't think they need to change.

I'll post another series for applying the manager timings correctly(i.e, 
the fixed version of the last 3 patches).

Archit

>
>   Tomi
>

