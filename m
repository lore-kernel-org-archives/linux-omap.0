From: archit taneja <archit@ti.com>
Subject: Re: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to omap_display
Date: Mon, 28 Feb 2011 12:57:01 +0530
Message-ID: <4D6B4E45.7080108@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>	 <1295850125-21405-6-git-send-email-sumit.semwal@ti.com>	 <1298539643.16119.54.camel@deskari> <1298876015.2096.36.camel@deskari>	 <4D6B4A1A.9000304@ti.com> <1298877549.2096.47.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab1B1HYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 02:24:32 -0500
In-Reply-To: <1298877549.2096.47.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Monday 28 February 2011 12:49 PM, Valkeinen, Tomi wrote:
> On Mon, 2011-02-28 at 01:09 -0600, Taneja, Archit wrote:
>> Hi,
>>
>> On Monday 28 February 2011 12:23 PM, Valkeinen, Tomi wrote:
>>> On Thu, 2011-02-24 at 03:27 -0600, Tomi Valkeinen wrote:
>>>> Hi,
>>>>
>>>> On Mon, 2011-01-24 at 11:51 +0530, ext Sumit Semwal wrote:
>>>>> From: Senthilvadivu Guruswamy<svadivu@ti.com>
>>>>>
>>>>> Change the driver name from omapdss to omap_display as the driver takes care of
>>>>> the display devices ie number of panels, type of panels available in the
>>>>> platform.  Change the device name in the board files and 2420,2430,3xxx clock
>>>>> files from omapdss to omap_display to match the driver name.
>>>>
>>>> I just realized that changing the driver name will break all scripts and
>>>> applications using omapdss sysfs files.
>>>>
>>>> How does this sound:
>>>>
>>>> Let's leave the omapdss device name as it is. It represents a "super"
>>>> device, containing the dss sysfs files and upper level dss management.
>>>>
>>>> Name the HW module platform drivers as: omapdss_dss, omapdss_venc,
>>>> omapdss_dispc, etc. This would indicate them to be clearly parts of DSS,
>>>> and would also prevent any possible name conflict if there would happen
>>>> to be a, say, "dsi" block in some other HW component.
>>>
>>> Any comments on this?
>>
>> I also think we need to stick to the older name, "omapdss_dss" sounds a
>> bit confusing, and I think one of the previous versions had something
>> like "dss_dss" in it and it wasn't approved. Does something like
>> "omapdss_core" or "omapdss_dss_core" make sense, or is it more misleading?
>
> It is confusing, but so is the hardware naming =). There is a DSS module
> inside the omap display subsystem. That's why I would like to name it
> "dss", not "core", so it's clear it refers to this DSS module.
>
> "dss_dss" looks a bit silly, but I think "omapdss_dss" is slightly
> better in the sense that it doesn't repeat the same "dss", and there is
> an "omapdss" device, which acts like "manager" for these module devices.
> But yes, I wouldn't call it perfect either.
>
> "omapdss_dss_core" is one option. But then again, TRM doesn't speak of
> "core".

Yes, it might get misleading if someone looking at the code tries to 
find "core" in the TRM, I guess we should stick to "omapdss_dss", this 
also ensures a uniform matching of the platform driver names and the 
beginning of register names for each HW module.

Archit
