From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 09:23:06 -0600
Message-ID: <4CE2A1DA.3020203@ti.com>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>	<1289849261-29767-2-git-send-email-nm@ti.com>	<20101116122128.5c6cc050@surf>	<4CE2710A.3010804@ti.com> <20101116134220.1bb818c0@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58510 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751011Ab0KPPXO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 10:23:14 -0500
Received: by mail-yw0-f49.google.com with SMTP id 7so365538ywf.8
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 07:23:12 -0800 (PST)
In-Reply-To: <20101116134220.1bb818c0@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Thomas Petazzoni had written, on 11/16/2010 06:42 AM, the following:

> But, sorry, I find this even uglier than I thought it was :) What about
> adding the obligation to boards file to call the omapX_init_opp()
> function and then do their customization (if needed), then no call to
I knew I had discussed this before! Apologies, I should have dug this 
thread up earlier in the discussion.

my initial implementation had forced board files to call the 
opp_init_table, then changed that here:
http://marc.info/?l=linux-omap&m=127431810922704&w=2
Kevin seemed happy with the change here:
http://marc.info/?l=linux-omap&m=127507237109393&w=2

-- 
Regards,
Nishanth Menon
