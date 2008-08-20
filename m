From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Wed, 20 Aug 2008 19:08:15 +0300
Message-ID: <48AC416F.2050808@nokia.com>
References: <20080818.180829.145776296.Hiroshi.DOYU@nokia.com> <EBA93F3E4CB46947A4C5275F6308CF3E03435165@dlee15.ent.ti.com> <5d5443650808181020l19e9bce2g9ccb59979f626a93@mail.gmail.com> <20080819062020.GC17276@atomide.com> <13B9B4C6EF24D648824FF11BE8967162036217F694@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18220 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbYHTQHg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 12:07:36 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036217F694@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Jalori, Mohit" <mjalori@ti.com>

Hi,

ext Woodruff, Richard wrote:
>>> I think recently some one from TI posted OMAP3 camera driver at 
>>> linux-v4l2 mailing list and which I think was using camera MMU,
>>> but not the common MMU framework it seems from the description.
>>> They should first start converting to the common MMU
>>> infrastructure then.
>>> 
>>> http://lists-archives.org/video4linux/23215-omap3-camera-driver.html
>>> 
>> We must make the MMU framework generic for the coprocessors,
>> otherwise maintenance will be a nightmare and the code will never
>> get merged upstream.

I agree with Tony.

Many implementations are more likely have more bugs than one, too.

> Main issues are at outer interfaces which deal with OS memory system
> interaction.  The other aspects of the code have been self contained.
> 
> 
> The local MMU usages are not maintenance intensive like linux PTE
> structures as Linux more strongly couples with the hardware table
> representations.
> 
> Seems some of the subsystems like v4l2 do provide local abstractions
> but there isn't always global ones (vmalloc to sg list for example).

The V4L2 provides functions for mapping the video buffers to kernel 
memory, but that's not the point. The OMAP 3 ISP driver for example 
would benefit from common MMU framework directly as it just wants to map 
the video buffers continuously to some address and sometimes flush them.

Creating page tables for the mappings is necessary in practice.

This sounds very much like something that would be useful for a number 
of drivers for OMAP 3 in addition to the ISP driver.

If there was a generic way for asking the MMU to map the buffer it
would be simple for the ISP driver to use that.

(Besides, it'd be easy to add MMU support for the OMAP 2 camera driver 
as well if there was a generic framework. Aren't the MMUs similar or 
even the same?? :))

(I'm adding Mohit Jalori to Cc:.)

Regards,

-- 
Sakari Ailus
sakari.ailus@nokia.com

