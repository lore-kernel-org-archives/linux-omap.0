From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: DSS2 broken with 36-rc1
Date: Mon, 23 Aug 2010 10:19:49 +0300
Message-ID: <4C722115.50401@compulab.co.il>
References: <1281962906.1888.25.camel@chotu>	 <4C72192A.9050801@compulab.co.il> <1282547709.2202.1.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52836 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab0HWHUa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 03:20:30 -0400
In-Reply-To: <1282547709.2202.1.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

Tomi Valkeinen wrote:
> On Mon, 2010-08-23 at 08:46 +0200, ext Mike Rapoport wrote:
>> Hi Ameya,
>>
>> Ameya Palande wrote:
>>> Hi Tomi,
>>>
>>> When I tried to boot 2.6.36-rc1 kernel on Nokia N900, omapfb failed with
>>> following error messages:
>>>
>>> [    0.124145] OMAP DSS rev 2.0
>>> [    0.124237] OMAP DISPC rev 3.0
>>>
>>> [    0.303833] acx565akm spi1.2: omapfb: acx565akm rev 8b LCD detected
>>>
>>> [    0.805419] omapfb omapfb: failed to allocate framebuffer
>>> [    0.810882] omapfb omapfb: failed to allocate fbmem
>>> [    0.815856] omapfb omapfb: failed to setup omapfb
>>> [    0.820648] omapfb: probe of omapfb failed with error -12
> 
> I tested 36-rc1 briefly with OMAP 3430SDP board. I wonder why that
> works, but not N900...

May it be that 3430SDP uses SRAM for the framebuffer? Or reserves framebuffer 
memory from the RAM that is not managed by the kernel, e.g with something like
mem=<RAM size - fb size> vram=<fb size>,0x8...... ?

> Tomi
> 
> 


-- 
Sincerely yours,
Mike.

