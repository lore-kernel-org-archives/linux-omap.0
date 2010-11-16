From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 08:02:53 -0600
Message-ID: <4CE28F0D.6030205@ti.com>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>	<1289849261-29767-2-git-send-email-nm@ti.com>	<20101116122128.5c6cc050@surf>	<4CE2710A.3010804@ti.com>	<20101116134220.1bb818c0@surf>	<4CE282CC.6070105@ti.com> <20101116142026.4f4740d2@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob110.obsmtp.com ([74.125.149.202]:58213 "EHLO
	na3sys009aob110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756474Ab0KPOC5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 09:02:57 -0500
Received: by gxk23 with SMTP id 23so329983gxk.33
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 06:02:56 -0800 (PST)
In-Reply-To: <20101116142026.4f4740d2@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Thomas Petazzoni had written, on 11/16/2010 07:20 AM, the following:
>>> would prevent you from having no OPP table (the case where a NULL OPP
>>> table is passed is tested *before* in omapX_init_opp()).
>> HUH?? NULL table to a static function - what code are you talking 
>> about?? why are you so behind BUG_ON, when there are valid reasons for 
>> reentry into code.
> 
> In the current design, yes, there are indeed valid reasons for reentry
> into the omapX_init_opp() function, and that's exactly the point I'm
> critizicing here.
how about:
	if (omap_table_init)
		return -EEXIST;
does that make it better? it still retains the ability to handle both 
kinds of platforms as well as not BUG out.

-- 
Regards,
Nishanth Menon
