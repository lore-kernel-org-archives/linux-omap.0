From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFT 0/2] fixes for broken PM init with multi-OMAP
Date: Wed, 10 Mar 2010 08:22:32 -0800
Message-ID: <87d3zci1tj.fsf@deeprootsystems.com>
References: <1268154241-24788-1-git-send-email-khilman@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C46F0F96@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:46903 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0CJQWf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 11:22:35 -0500
Received: by pzk32 with SMTP id 32so201112pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 08:22:35 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C46F0F96@dbde02.ent.ti.com> (Santosh Shilimkar's message of "Wed\, 10 Mar 2010 12\:15\:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> Thanks Kevin,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>> Hilman
>> Sent: Tuesday, March 09, 2010 10:34 PM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH/RFT 0/2] fixes for broken PM init with multi-OMAP
>> 
>> multi-OMAP builds are broken in various ways due to conditional code.
>> Here is a small series of fixes.
>> 
>> Build tested: omap3_defconfig, omap_4430sdp_defconfig
>> Boot tested: omap3_defconfig on OMAP3EVM
>> 
> Applied this series on l-o master (dc73899a58be5e834b8df3a9049cdb1115acf175)
> OMAP3430 SDP boots normal.
>
>> Needs boot testing on OMAP4.
>>
> OMAP4 also boots with omap3_defconfig after unchecking the reset
> unused clock check. This is known and will be fixed soon. 
>  

Santosh,

Thanks for testing.

Will respin removing the second FIXME you mentioned in PATCH 2.

Kevin
