From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 15:24:41 +0300
Message-ID: <20101001122441.GS2925@legolas.emea.dhcp.ti.com>
References: <1285931095-21053-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285931095-21053-3-git-send-email-peter.ujfalusi@nokia.com>
 <20101001115037.GA12614@esdhcp036161.research.nokia.com>
 <201010011516.54190.peter.ujfalusi@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43401 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab0JAMYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 08:24:48 -0400
Content-Disposition: inline
In-Reply-To: <201010011516.54190.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: David Cohen <david.cohen@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, "Menon, Nishanth" <nm@ti.com>

On Fri, Oct 01, 2010 at 07:16:53AM -0500, Peter Ujfalusi wrote:
>On Friday 01 October 2010 14:50:37 David Cohen wrote:
>>
>> > +		l = sys_cf = dma_read(OCP_SYSCONFIG);
>>
>> Shouldn't it be avoided?
>
>I'm restoring the OCP_SYSCONFIG register later on, and reusing 'l' here to avoid
>confusing expression when moving the sDMA to NoStandby.
>I could as well introduce other variable for this...
>
>>
>> Regards,
>>
>> David
>>
>> > +		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
>> > +		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
>> > +		dma_write(l , OCP_SYSCONFIG);
>
>I could have:
>	dma_write((sys_fc & (~DMA_SYSCONFIG_MIDLEMODE_MASK)) |
>			 DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE), OCP_SYSCONFIG);
>
>Than I do not need the re-read the CCR, but it looks a bit messy.

I think David is concerned about multiple assigments in one line.
CodingStyle asks to avoid that. So probably:

sys_cf = dma_read(OCP_SYSCONFIG);
l = sys_cf;

would make chekcpatch.pl --strict happy ??

-- 
balbi
