From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v8 3/7] omap3: pm: TWL4030 power scripts for OMAP3 boards
Date: Tue, 08 Mar 2011 21:59:49 +0530
Message-ID: <4D76597D.5060102@ti.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>	<1299072653-13414-4-git-send-email-leslyam@ti.com> <87y64q4pak.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55712 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755520Ab1CHQaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 11:30:00 -0500
Received: by mail-vx0-f169.google.com with SMTP id 38so6113961vxc.0
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 08:29:59 -0800 (PST)
In-Reply-To: <87y64q4pak.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Lesly A M <leslyam@ti.com>, linux-omap@vger.kernel.org, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Kevin Hilman wrote, on 03/08/2011 02:32 AM:
> Lesly A M<leslyam@ti.com>  writes:
>
>> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_reset.
>>
>> TWL4030 power scripts which can be used by different OMAP3 boards
>> with the power companion chip (TWL4030 series).
>>
>> The twl4030 generic script is exported and can be used by any other
>> boardfile to update the power data in twl4030_platform_data.
>>
>> http://omapedia.org/wiki/TWL4030_power_scripts
>
> This is a very helpful wiki page, thanks for writing that up.
>
> I'd recommend putting a link into the C file as well, saying this code
> implements the recommended sequence as detailed at<wiki page>.
yes it definitely will help - esp duplicating essential parts from the 
wiki in C code. one issue I have with wiki based off line documentation 
is the following: we do have a Documentation/ folder which probably 
should contain the documentation necessary for this.

Ideally there are three main events that occur:
a) OFF mode transition
b) RET transition
c) warm reset

in addition assumptions that NSLEEP2 is not plugged to anything else may 
not be true always - for e.g. for handheld devices it is possible that 
NSLEEP2 is controlled by Modem because one of the rails is supplied from 
TWL. These assumptions should be clearly stated in comments as it is 
possible to fall into the trap of using the default scripts without 
understanding the basic assumptions involved.
IMHO, assumption section for the default script should at the very least 
state:
a) what are the rails that will be controlled by the script and what 
rails are expected to be controlled by drivers (e.g. vmmc) - has impact 
on power consumption
b) what signalling is expected in OFF, RET and warm reset - a basic 
assumption is useful here.
c) what rails go to what level on each of the transitions of OFF/RET/reset

Just my 2 cents having forced myself to read code without looking at the 
wiki.

[...]

-- 
Regards,
Nishanth Menon
