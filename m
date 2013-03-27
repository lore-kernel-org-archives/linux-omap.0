From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2 0/8] omapdss/omapdrm: Misc fixes and improvements
Date: Wed, 27 Mar 2013 14:05:38 +0530
Message-ID: <5152AF5A.3000707@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1364305525-28496-1-git-send-email-archit@ti.com> <5152A5D1.3010209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54052 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3C0Ig2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 04:36:28 -0400
In-Reply-To: <5152A5D1.3010209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, andy.gross@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday 27 March 2013 01:24 PM, Tomi Valkeinen wrote:
> On 2013-03-26 15:45, Archit Taneja wrote:
>> These are misc fixes and improvements within omapdrm and omapdss. The fixes do the
>> following:
>>
>> - Make omapdrm smarter to choose the right overlay managers as it's crtcs. This
>>    makes sure that omapdrm is functional for OMAP platforms with different
>>    combinations of panels connected to it.
>>
>> - Fix certain areas in omapdrm which allow fixed resolution panels to work.
>>
>> - Fix functional and pixel clock limits for DISPC, this ensures we don't try
>>    to try a mode that the hardware can't support.
>>
>> - Some changes that came in OMAP5 ES2 silicon.
>>
>> Note: The branch is based on the DSS misc series and dsi video mode calc series
>> posted by Tomi. Reference branch:
>>
>> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git for-3.10/misc_drm_dss
>
> Which of the fixes should go for 3.9? We need those separately, based on
> the mainline.

The most important fix is omapdrm change which allocates crtcs in a 
better way, but it needs the 'dispc_channel' parameter in outputs, so 
that can't go.

We could queue patches 7 and 8 for 3.9, they are 2 things which we would 
want to have in 3.9 itself. These should apply on mainline directly.

Archit

