From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 2/5] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Fri, 19 Mar 2010 10:34:53 -0700
Message-ID: <87ocikxlj6.fsf@deeprootsystems.com>
References: <1268407891-22559-1-git-send-email-leslyam@ti.com>
	<87eijhgqe4.fsf@deeprootsystems.com>
	<009c01cac732$5d237ee0$518918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33578 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0CSRe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 13:34:56 -0400
Received: by pwi5 with SMTP id 5so1383147pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 10:34:55 -0700 (PDT)
In-Reply-To: <009c01cac732$5d237ee0$518918ac@apr.dhcp.ti.com> (Lesly Arackal Manuel's message of "Fri\, 19 Mar 2010 12\:34\:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly Arackal Manuel <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

Please don't top post: http://www.elinux.org/Netiquette

"Lesly Arackal Manuel" <leslyam@ti.com> writes:

> Hi Kevin,
>
> If my understanding is correct.
>
> The clk_setuptime is board specific, depends on the osc/XTAL used on	the
> board. So the clk_setuptime has to come from the board file.
>
> Volt_setuptime & volt_offset is PM IC specific, depends on the PM IC's SMPS
> characteristics. So this can be updated from the script file.
>
> Finally the voltage cmd values (on, onlp, ret &off) is Si Specific, Varies
> with Si(OMAP3430, OMAP3630, ...). So can be updated in voltage file itself.

Then, all the defaults should be in SoC specific code with the ability
for board files to override clk_setuptime.

Kevin

>
> Just correct if I'm wrong.
>
> Thanks & Regards,
> Lesly A M
>
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, March 19, 2010 5:00 AM
> To: Lesly A M
> Cc: linux-omap@vger.kernel.org; Lesly A M; Nishanth Menon; David Derrick;
> Samuel Ortiz
> Subject: Re: [PATCH v3 2/5] omap3: pm: Using separate clk/volt setup_time
> for RET and OFF states
>
> Lesly A M <leslyam@ti.com> writes:
>
>> Copied the setuptime in each board file, since OMAP3430 & OMAP3630
>> has different voltage levels for the same states.
>
> So that suggests there should be 2 tables (one per SoC), rather than
> one for each board file.  IOW, the setup times are SoC specific, not
> board specific, so they don't belong in board files.
>
> Kevin
