From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 09:56:46 -0600
Message-ID: <4CE2A9BE.2010304@ti.com>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>	<1289849261-29767-2-git-send-email-nm@ti.com>	<20101116122128.5c6cc050@surf>	<4CE2710A.3010804@ti.com>	<20101116134220.1bb818c0@surf>	<4CE2A1DA.3020203@ti.com> <20101116165039.7e6b8e16@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49938 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754151Ab0KPP4v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 10:56:51 -0500
Received: by mail-yx0-f179.google.com with SMTP id 22so408468yxn.10
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 07:56:50 -0800 (PST)
In-Reply-To: <20101116165039.7e6b8e16@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Thomas Petazzoni had written, on 11/16/2010 09:50 AM, the following:
> On Tue, 16 Nov 2010 09:23:06 -0600
> Nishanth Menon <nm@ti.com> wrote:
> 
>> my initial implementation had forced board files to call the 
>> opp_init_table, then changed that here:
>> http://marc.info/?l=linux-omap&m=127431810922704&w=2
>> Kevin seemed happy with the change here:
>> http://marc.info/?l=linux-omap&m=127507237109393&w=2
> 
> Ok, if Kevin is happy with this solution, fair enough. Sorry for the
> noise, and thanks for your answers.
Thanks for taking the time to review and the comments. It is always a 
good idea to evolve to a better solution.

If there are no further comments, I will post a v4 later today 
incorporating comments:
a) return error instead of 0 if opp table is already initialized
b) change the .h to .c

-- 
Regards,
Nishanth Menon
