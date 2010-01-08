From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP
Date: Fri, 8 Jan 2010 09:02:55 -0600
Message-ID: <4B47491F.1000303@ti.com>
References: <1262867408-9895-1-git-send-email-srk@ti.com> <4B45FC4B.9080302@ti.com> <FCCFB4CDC6E5564B9182F639FC3560870300519AC7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42288 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab0AHPC4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 10:02:56 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o08F2uKM017980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 8 Jan 2010 09:02:56 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o08F2unX001639
	for <linux-omap@vger.kernel.org>; Fri, 8 Jan 2010 09:02:56 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o08F2uJv001013
	for <linux-omap@vger.kernel.org>; Fri, 8 Jan 2010 09:02:56 -0600 (CST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870300519AC7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Govindarajan, Sriramakrishnan had written, on 01/08/2010 02:15 AM, the 
following:
> 
>> From: Menon, Nishanth
>> Govindarajan, Sriramakrishnan had written, on 01/07/2010 06:30 AM, the
>> following:
>>> From: Sriram <srk@ti.com>
>>>
>>> OMAP platforms(like OMAP3530) include DSP or other co-processors
>>> for media acceleration. when carving out memory for the
>>> accelerators we can end up creating a hole in the memory map
>>> of sort:
>>> <kernel memory><hole(memory for accelerator)><kernel memory>
>>>
>>> To handle such a memory configuration ARCH_HAS_HOLES_MEMORYMODEL
>>> has to be enabled. For further information refer discussion at:
>>> http://www.mail-archive.com/linux-omap@vger.kernl.org/msg15262.html.
>> pls check the link: I see "The document you were looking for was not
>> found."
> 
> The URL is spelt incorrectly. Here is the correct URL:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15262.html
> 
>>>  	select GENERIC_TIME
>>>  	select GENERIC_CLOCKEVENTS
>>> +	select ARCH_HAS_HOLES_MEMORYMODEL
>> why enable this for all OMAPs?
> 
> I have tested this on several OMAP3 platforms and this feature is required
> Wherever some memory needs to be reserved for media accelerators - hence it
> Would be handy for earlier OMAP platforms as well
I understand that you have tested with OMAP3. my question is you have 
handled this as per the diff
@@ -699,6 +699,7 @@ config ARCH_OMAP
to ARCH_OMAP

is this good for OMAP1510, 1610, 1710, 2420,2430, 770 etc..?

if this is an OMAP3 requirement why not add it there?
-- 
Regards,
Nishanth Menon
