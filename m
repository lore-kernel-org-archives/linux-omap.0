From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 00/24] Move OMAP2+ over to use COMMON clock
Date: Mon, 04 Jun 2012 19:34:14 +0530
Message-ID: <4FCCC05E.4090904@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com> <4FC94FC9.9070903@ti.com> <4FCC7737.8070201@ti.com> <4FCCBD66.2080504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:60229 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752716Ab2FDOE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 10:04:26 -0400
Received: by obbuo19 with SMTP id uo19so8226004obb.40
        for <linux-omap@vger.kernel.org>; Mon, 04 Jun 2012 07:04:20 -0700 (PDT)
In-Reply-To: <4FCCBD66.2080504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: mturquette@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 04 June 2012 07:21 PM, Jon Hunter wrote:
>> I was infact thinking of moving these files into mach-omap1/ since they
>> >  are now OMAP1 specific. Is your concern coming mainly from the clksel
>> >  structs that you will need to be shared across OMAP1 and OMAP2+?
> Yes, especially if we plan to move omap1 to the common clock framework.
>
>> >  The right thing to do seems like is to move OMAP1 across to COMMON clk
>> >  also and keep the plat clock.h and get rid of plat clock.c completely.
>> >  But for now, I really haven;t looked at OMAP1 migration as all.
> Yes that would make sense. Do you have plans to do this or not yet?

At-least my plan for this series was to address only OMAP2+.
