From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 15:11:14 -0600
Message-ID: <4CE2F372.1010009@ti.com>
References: <1289849261-29767-2-git-send-email-nm@ti.com> <20101115235153.25f7021e@surf> <4CE1D5FD.2010109@ti.com> <20101116203510.GF9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36570 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758916Ab0KPVLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 16:11:17 -0500
Received: by mail-gy0-f180.google.com with SMTP id 8so767199gyg.11
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 13:11:16 -0800 (PST)
In-Reply-To: <20101116203510.GF9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>

Tony Lindgren had written, on 11/16/2010 02:35 PM, the following:
> * Nishanth Menon <nm@ti.com> [101115 16:43]:
>> Thomas Petazzoni had written, on 11/15/2010 04:51 PM, the following:
>>> Hello,
>>>
>>> On Mon, 15 Nov 2010 13:27:39 -0600
>>> Nishanth Menon <nm@ti.com> wrote:
>>>
>>>> +++ b/arch/arm/mach-omap2/opp3xxx_data.h
>>>> +
>>>> +static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>>>> +
>>>> +static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
>>> Do we really want to have structure definitions in an header file ?
>>> Unless I'm wrong, this means that if the opp3xxx_data.h file is
>>> included in two different C files, the structures will be present twice.
>> The intent here - DONT DO precisely THAT!
>>> As far as I could see, most of the kernel instantiate structure in C
>>> files instead.
>> The intent here though was that opp3xx.h and opp4xx.h are private to
>> just opp.c to prevent misuse elsewhere. hmm.. thinking a bit,
>> find drivers/ -iname "*.c"|xargs grep "#include"| grep -v "\.h"
>> shows numerous examples of .c files being included in c files. I
>> dont have an issue of renaming these headers as .c file instead (I
>> had carried them over as .h from old implementation, but we can
>> change it), main point being, I just dont want folks mucking around
>> and hacking stuff with the defines.
> 
> What usually works best is to have common opp.c, then have opp34xx.c
> that has initcall that registers the data in opp.c.
> 
> That leaves out if cpu_is_omapxxx else if stuff in opp.c and then
> adding support for new omaps is just a matter of doing oppxxxx.c.

Series rev4 already posted here:
http://marc.info/?l=linux-omap&m=128993367212640&w=2
I believe I have taken care of the comments there - do let me know if I 
screwed anything up here..
-- 
Regards,
Nishanth Menon
