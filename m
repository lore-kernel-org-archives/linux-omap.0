From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 42/65] OMAPDSS: DSI: call mgr_enable/disable for cmd mode
 displays
Date: Wed, 23 Nov 2011 17:43:45 +0530
Message-ID: <4ECCE379.9000506@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>	 <1321953724-6350-43-git-send-email-tomi.valkeinen@ti.com>	 <4ECCC68C.7070106@ti.com> <1322044977.28917.57.camel@deskari>	 <4ECCD44A.2070008@ti.com> <1322047652.28917.64.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60123 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab1KWMOO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 07:14:14 -0500
In-Reply-To: <1322047652.28917.64.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Wednesday 23 November 2011 04:57 PM, Tomi Valkeinen wrote:
> On Wed, 2011-11-23 at 16:38 +0530, Archit Taneja wrote:
>>
>> I think it would be best to stuff the 'video mode enabling and
>> manager
>> enabling' functionality in omapdss_dsi_display_enable() itself, the
>> panel driver shouldn't need to call a function separately to enable
>> video mode for the panel. This way we would be more along the lines
>> of
>> the dpi driver, where dpi_display_enable() enables the manager in the
>> end.
>
> But we need to configure the panel between enabling the DSI interface
> and enabling the video output, so we can't combine those two functions.

Oh okay, that's right, we can't start video mode before preparing the panel.

Archit

>
> For DPI things are simpler, as enabling the interface and the video
> output are more or less the same thing.
>
>   Tomi
>

