From: Nishanth Menon <nm@ti.com>
Subject: Re: 4430SDP boot failure
Date: Thu, 06 Jan 2011 11:25:20 -0600
Message-ID: <4D25FB00.2070807@ti.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40175 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752915Ab1AFRZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 12:25:29 -0500
Received: by mail-gy0-f177.google.com with SMTP id 4so6249883gyg.8
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 09:25:22 -0800 (PST)
In-Reply-To: <20110106170805.GE1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

Russell King - ARM Linux had written, on 01/06/2011 11:08 AM, the following:
[..]
> For TI folk: it may be an idea to make X-loader say why it's hanging so
> that we know what is going on.
[..]
> 
> 1843088 bytes read
> OMAP44XX SDP # bootm 80300000
> ## Booting image at 80300000 ...
>    Image Name:   Linux-2.6.37+
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1843024 Bytes =  1.8 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> X-Loader hangs
http://gitorious.org/x-loader/x-loader/blobs/master/cpu/omap4/start.S#line40
I think we can improve this to provide rationale if data abort/ other 
causes for the hang. But in this case, I am not sure it might help - 
what we need to add is "boot reason" information probably. It does look 
to me that a reset took place (u-boot hooks up it's own handlers for 
irq,fiq,abort etc, but they were'nt triggered) - so either kernel abort 
took place and a wdt trigger caused x-loader to come up in some 
unexpected configuration that it could'nt handle OR a reset of somesort 
took place.

-- 
Regards,
Nishanth Menon
