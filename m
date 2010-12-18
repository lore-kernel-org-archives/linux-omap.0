From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/7 v6] OMAP3: clean up ASM sleep code
Date: Sat, 18 Dec 2010 16:56:36 -0600
Message-ID: <4D0D3C24.4020503@ti.com>
References: <1292687087-22983-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54319 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757185Ab0LRW4l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Dec 2010 17:56:41 -0500
Received: by gwaa18 with SMTP id a18so1014869gwa.23
        for <linux-omap@vger.kernel.org>; Sat, 18 Dec 2010 14:56:40 -0800 (PST)
In-Reply-To: <1292687087-22983-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com had written, on 12/18/2010 09:44 AM, the 
following:
> 
> Applies on top of Nishant's latest idle path errata fixes step 2,
> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
> 
> Jean Pihet (7):
>   OMAP3: remove unused code from the ASM sleep code
>   OMAP2+: use global values for the SRAM PA addresses
>   OMAP3: remove hardcoded values from the ASM sleep code
>   OMAP3: re-organize the ASM sleep code
>   OMAP3: rework of the ASM sleep code execution paths
>   OMAP3: add comments for low power code errata
>   OMAP3: ASM sleep code format rework
> 

just FYI - tested the series v6 as well with:
SDP3430 and SDP3630 with script:
http://elinux.org/OMAP_Power_Management#Quick_verification_of_suspend-idle_functionality

Tested against v4 of my series. I have ensured that your series still 
applies cleanly on top of my new series.

-- 
Regards,
Nishanth Menon

