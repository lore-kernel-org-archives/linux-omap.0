From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Thu, 8 Jul 2010 09:27:23 -0500
Message-ID: <4C35E04B.1090102@ti.com>
References: <1278590256.3787.14.camel@Nokia-N900> <20100708122157.GI1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58315 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab0GHO1c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 10:27:32 -0400
In-Reply-To: <20100708122157.GI1920@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "ValkeinenTomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, "Koskinen Aaro (Nokia-MS/Helsinki)" <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

Tony Lindgren had written, on 07/08/2010 07:21 AM, the following:
> * Menon, Nishanth <nm@ti.com> [100708 14:49]:
>> ----- Original message -----
>>> Hi,
>>>
>>> On Wed, Jul 07, 2010 at 07:24:16PM +0200, ext Nishanth Menon wrote:
>>>> I am not sure.. if you would like drivers to be modprobabe, there may
>>> be
>>>> quirks that you'd want to enable based on cpu_is_omapxxx checks. so it
>>>> probably does not make sense to __initdata the revision/feature
>>> variables.
>>>
>>> can't you pass the quirks via pdata, then ?
>> If pdata is passed based on board: Imagine 3630 and uart quirk. Why share errata xyz over pdata for every board using 3630? Quirks are cpu specific and not really domain of board..  
> 
> We should be able to handle the quirks by passing some
> flag or function pointer from platform data.
> 
> The drivers should be arch independent, using cpu_is_omapxxxx
> tests anywhere under drivers/* is wrong and should be
> fixed.

there are two forms of quirks:
a) quirks which can be detected based on IP rev
b) quirks which are silicon integration related - only cpu_is_xxxx can 
be used to detect them.
for a) - I disagree that pdata should be used (this was my original 
contention)
for b) the question IMHO is: How is pdata provided to the driver - that 
is important. IMHO, pdata taken into drivers could have quirks, but if 
the quirk addition is done from board files, I disagree, then should be 
done in arch/arm/mach-omap[12]/somefile.c where somefile.c is common for 
all boards (e.g. device.c) and that allows the driver to be cpu 
independent and allows board files not to have redundant information.

BUT, features *should* be kept distinct from quirks for readability 
purposes.

-- 
Regards,
Nishanth Menon
