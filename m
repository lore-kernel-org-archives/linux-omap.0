From: Archit Taneja <archit@ti.com>
Subject: Re: [RFC 2/6] omapdss: add init port functions for different omap
 revs
Date: Tue, 20 May 2014 15:01:24 +0530
Message-ID: <537B20EC.6020303@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1399540517-17883-2-git-send-email-archit@ti.com> <537B0CA1.5060100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60838 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbaETJcf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 05:32:35 -0400
In-Reply-To: <537B0CA1.5060100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Tuesday 20 May 2014 01:34 PM, Tomi Valkeinen wrote:
> On 08/05/14 12:15, Archit Taneja wrote:
>> The init/uninit port functions are used to set up the DPI and SDI outputs under
>> the dss platform device. A 'reg' property is used to determine whether the node
>> is DPI or SDI for OMAP34xx DSS revision. For other DSS revisions, only DPI
>> output exists.
>>
>> For multiple DPI output instances(introduced in DRA7xx DSS), we would use the
>> 'reg' property to specify the DPI output number.
>>
>> The current functions work fine if there is only one DPI output instance in
>> DSS. For multiple DPI instances, it would get complicated to figure out whether
>> 'reg' is used to specify whether the output is SDI, or a later DPI instance.
>>
>> Create DSS revision specific init/uninit_port functions such that we have a
>> separate functions for OMAP34xx, this helps us deal with the SDI case
>> separately.
>
> Could we instead have an array of the ports for the said DSS version,
> assigned to dss_features? Maybe just something like:
>
> static enum omap_display_type omap34xx_ports[] = {
> 	OMAP_DISPLAY_TYPE_DPI,
> 	OMAP_DISPLAY_TYPE_SDI,
> };
>
> The index on the array tells the matching 'reg' value.

Oh yeah! That should prevent us creating ops. It would require us to 
create a ports pointer in dss_features, but it's certainly much better 
than having 2 very similar functions.

Archit
