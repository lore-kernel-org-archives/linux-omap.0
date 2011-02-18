From: archit taneja <archit@ti.com>
Subject: Re: omapfb: no driver for display
Date: Fri, 18 Feb 2011 09:57:51 +0530
Message-ID: <4D5DF547.7010703@ti.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>	<AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com> <AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48268 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab1BRE0j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 23:26:39 -0500
In-Reply-To: <AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sung Hee Park <shpark7@stanford.edu>
Cc: Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>

Hi,

On Friday 18 February 2011 09:46 AM, Sung Hee Park wrote:
> Bryan,
>
> I've already tried that patch but didn't work. The omapdss is not
> showing any error message, but omapfb still does.
>
> Thanks,
> Sung Hee
>
> On Thu, Feb 17, 2011 at 7:46 PM, Bryan Wu<bryan.wu@canonical.com>  wrote:
>> Sung Hee,
>>
>> Could you please try the patch I forwarded to L-O yesterday?
>> https://patchwork.kernel.org/patch/569501/
>>
>> Thanks,
>> -Bryan
>>
>> On Fri, Feb 18, 2011 at 11:17 AM, Sung Hee Park<shpark7@stanford.edu>  wrote:
>>> Hi,
>>>
>>> I found my frame buffer is not working while I'm testing the linux
>>> kernel 2.6.38-rc5 on omap3evm, which used to work fine with 2.6.37.
>>>
>>> Kernel command line: mem=128M console=ttyO0,115200n8 noinitrd rw
>>> root=/dev/mmcblk0p2 rootfstype=ext3 rootwait omapfb.rot
>>> ate=3 omapfb.vrfb=y vram=8M earlyprintk=serial,uart0,115200n8
>>> omapdss.debug=1 omapfb.debug=1
>>> OMAPFB: omapfb_init
>>> OMAPFB: omapfb_probe
>>> omapfb omapfb: no driver for display
>>> omapfb omapfb: failed to setup omapfb

It looks like an issue with what you have selected in the menuconfig. 
Could you ensure you have DPI and VENC selected, and in displays Generic 
DPI panel and sharp-ls panel selected.

Regards,
Archit
