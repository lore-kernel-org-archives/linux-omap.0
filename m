From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v4 0/4] Introduce support for TI816X processor series
Date: Fri, 21 Jan 2011 21:59:34 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB426@dbde02.ent.ti.com>
References: <1294677460-18071-1-git-send-email-hemantp@ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A77D048@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40642 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab1AUQ3o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 11:29:44 -0500
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036A77D048@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>

linux-omap-owner@vger.kernel.org wrote on :

> Pedanekar, Hemant wrote on Monday, January 10, 2011 10:08 PM:
> 
>> This patch set adds support for TI816X processor series. This series
>> includes DM8168, C6A816x and AM389x devices.
>> 
>> The details can be found at following links:
>> 
>> http://focus.ti.com/general/docs/gencontent.tsp?contentId=77960
>> http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml
>> 
>> This series is architecturally closer to the OMAP devices.
>> Hence, these patches
>> are being submitted on linux-omap.
>> 
>> These patches are tested on OMAP3 EVM with multi-omap build.
>> 
>> Note that, additional patches consisting of TI816X specific hwmods, clock
>> data and DMTIMER changes, are required to enable successful
>> booting on TI816X EVM.
>> These patches will follow shortly.
>> 
>> The TI816X support is added as part of OMAP3 variant. The approach taken is
>> in accordance to the discussions in thread related to following post:
>> http://www.spinics.net/lists/linux-omap/msg41505.html
>> 
>> In addition, TI816X specific customizations/optimizations are handled as a
>> part of build configuration CONFIG_SOC_OMAPTI816X. Discussed here:
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41927.html
>> 
>> Hemant Pedanekar (4):
>>   TI816X: Update common omap platform files
>>   TI816X: Update common OMAP machine specific sources
>>   TI816X: Create board support and enable build for TI816X EVM
>>   TI816X: Add low level debug support
>> 
[...]
> 
> Tony,
> Can you please provide the comments on v4 patches? Thanks. -

Tony,
Do you find this series alright? Please let me know your comments.
Thanks.

   Hemant 