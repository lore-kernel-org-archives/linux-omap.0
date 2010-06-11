From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: Alternative for defconfig
Date: Fri, 11 Jun 2010 16:35:19 +0100
Message-ID: <4C1257B7.9050100@blueyonder.co.uk>
References: <201006091227.29175.laurent.pinchart@ideasonboard.com> <AANLkTilPWyHcoT6q1T-o-UMvcMSs2_If45f9UocVtrbl@mail.gmail.com> <A24693684029E5489D1D202277BE894455DDEC44@dlee02.ent.ti.com> <201006111707.34463.laurent.pinchart@ideasonboard.com> <5A47E75E594F054BAF48C5E4FC4B92AB03233C036E@dbde02.ent.ti.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:32923 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755981Ab0FKPfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jun 2010 11:35:21 -0400
Received: from [172.23.170.141] (helo=anti-virus02-08)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1ON6GN-0008EK-My
	for linux-omap@vger.kernel.org; Fri, 11 Jun 2010 16:35:19 +0100
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1ON6GN-00028N-9U
	for linux-omap@vger.kernel.org; Fri, 11 Jun 2010 16:35:19 +0100
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03233C036E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/06/10 16:14, Gadiyar, Anand wrote:
> Laurent Pinchart wrote:
>> On Friday 11 June 2010 16:55:07 Aguirre, Sergio wrote:
>>>> On Fri, Jun 11, 2010 at 3:19 PM, Nagarajan, Rajkumar wrote:
>>>>> 1. What is the alternative way of submitting defconfig changes/files to
>>>>
>>>> LO?
>>>
>>> I don't think defconfig changes are prohibited now. If I understand
>>> correctly, Linus just hates the fact that there is a big percentage of
>>> patches for defconfigs. Maybe he wants us to hold these, and better
>>> provide higher percentage of actual code changes.
>>>
>>> What about holding defconfig changes in a separate branch, and just send
>>> them for upstream once in a while, specially if there's a big quantity of
>>> them in the queue?
>>>
>>> IMHO, defconfigs are just meant to make us life easier, but changes to them
>>> should _never_ be a fix/solution to any problem, and therefore I understand
>>> that those aren't a priority over regressions.
>>
>> My understanding is that Linus will remove all ARM defconfigs in 2.6.36, 
>> unless someone can convince him not to. Board-specific defconfigs won't be 
>> allowed anymore, the number of defconfigs needs to be reduced drastically 
>> (ideally to one or two only).
>>
> 
> There is some good work going on on the linux-arm-kernel mailing list to
> cut down heavily the ARM defconfigs. Would be good to join that discussion.
> 
> For OMAP, I suppose maintaining omap1_defconfig and omap3_defconfig would
> suffice to cover all OMAPs?
> 
> - Anand

If I use omap3_beagle_defconfig instead of omap3_defconfig HID is
missing from the .config and doesn't show up for selection in "make
config".
Is this an oversight or is omap3_defconfig the proper one to use.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

