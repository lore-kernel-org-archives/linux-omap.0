From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 63/65] OMAPDSS: APPLY: add checking of ovls/mgrs settings
Date: Tue, 13 Dec 2011 15:32:29 +0530
Message-ID: <4EE722B5.3070606@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>	 <1321953724-6350-64-git-send-email-tomi.valkeinen@ti.com>	 <4EDF64AF.6040008@ti.com> <1323332965.1867.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36885 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab1LMKDH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 05:03:07 -0500
In-Reply-To: <1323332965.1867.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

Hi,

On Thursday 08 December 2011 01:59 PM, Tomi Valkeinen wrote:
> On Wed, 2011-12-07 at 18:35 +0530, Archit Taneja wrote:
>> Hi,
>>
>> On Tuesday 22 November 2011 02:52 PM, Tomi Valkeinen wrote:
>>> Add checks for overlay and manager settings. The checks are a bit
>>> complex, as we need to observe the bigger picture instead of overlays
>>> and managers independently. Things like the used display and the zorder
>>> of other overlays affect the validity of the settings.
>>
>> Minor comment:
>>
>> dss_ovl_check, dss_mgr_check and dss_mgr_check_zorder don't really
>> qualify as functions which do actual applying of configurations, they
>> could be moved from apply.c to manager.c and overlay.c.
>
> I had the check functions in apply.c because they used apply.c's
> internal datastructures.
>
> However, looking the functions now, only dss_mgr_check_zorder() used the
> internal datas, and the function doesn't even use those variables for
> anything =).

Also, the function dss_mgr_check() takes 'struct 
omap_overlay_manager_info *info' as a parameter but doesn't use it. We 
might want to remove that too.

Archit

>
> So you're right, they can be moved to manager.c and overlay.c, thanks.
>
>   Tomi
>

