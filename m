From: Archit Taneja <a0393947@ti.com>
Subject: Re: [RFC 08/17] OMAPDSS: DSI: Maintain own copy of timings in driver
 data
Date: Wed, 8 Aug 2012 13:24:56 +0530
Message-ID: <50221B50.2040105@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>    <1343817088-29645-9-git-send-email-archit@ti.com>   <1344348462.7216.77.camel@lappyti> <5021FFDC.6080006@ti.com>  <1344406508.17575.12.camel@lappyti> <5022073B.6070109@ti.com> <1344409847.17575.40.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50376 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab2HHH4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 03:56:23 -0400
In-Reply-To: <1344409847.17575.40.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com

On Wednesday 08 August 2012 12:40 PM, Tomi Valkeinen wrote:
> On Wed, 2012-08-08 at 11:59 +0530, Archit Taneja wrote:
>
>> I tried out rotation on Taal, and it only works for 180 degrees(and 0 of
>> course), 90 and 270 result in no output. I'll add a
>> dss_mgr_set_timings() in omap_dsi_update, that should sort of fix it,
>> but someone would need to reconfigure the connected overlays too before
>> trying out an update.
>
> Right, but that's something omapdss/panel cannot do, it must be done by
> the user. The same problem is there with changing, say, DPI mode also.
>
> Btw, can you separate smaller cleanups/fixes to another patch series, to
> make this series even slightly smaller? I think at least the first
> patches in this series are quite separate, and the rotation fix is also.

Right, I'll do that.

Archit

