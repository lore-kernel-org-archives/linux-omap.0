From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] OMAP PM EMU fix for v3.3
Date: Mon, 20 Feb 2012 07:29:31 -0800
Message-ID: <87linxa5gk.fsf@ti.com>
References: <87liw8agk4.fsf@ti.com>
	<AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com>
	<20120127190239.GC9339@atomide.com>
	<AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com>
	<AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37565 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753445Ab2BTP3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Feb 2012 10:29:25 -0500
Received: by mail-pw0-f51.google.com with SMTP id rp2so5608552pbb.10
        for <linux-omap@vger.kernel.org>; Mon, 20 Feb 2012 07:29:24 -0800 (PST)
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com>
	(Madhusudhan Gowda's message of "Mon, 20 Feb 2012 11:52:51 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan.Gowda@elektrobit.com, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

+Paul

Paul maintains the CM core code and should take this patch if he's OK
with it.

Also, it is most helpful if you describe what platforms it was tested on
and exactly how you tested it.

Thanks,

Kevin

<Madhusudhan.Gowda@elektrobit.com> writes:

> Hi Kevin,
>
> I think you have missed my last mail. Could you please ACK the pull
> request and pull the same.
>
> Best Regards
> Gowda
>
>
> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> linux-arm-kernel-bounces+madhusudhan.gowda=elektrobit.com@lists.infradea
> d.org
> Sent: 28 January 2012 09:58
> To: tony@atomide.com; khilman@ti.com
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
>
> Thanks Tony
>
> Hi Kevin
> Please do the needful and pull the same.
>
> Best Regards
> Gowda
>
>
> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Tony
> Lindgren
> Sent: 27 January 2012 21:03
> To: Gowda Madhusudhan
> Cc: Kevin Hilman; linux-omap@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [GIT PULL] OMAP PM EMU fix for v3.3
>
> Hi,
>
> * Madhusudhan.Gowda@elektrobit.com <Madhusudhan.Gowda@elektrobit.com>
> [120127 10:25]:
>> Hi Tony,
>> 
>> Please pull the PM EMU off mode fix for v3.3
>
> It's best that Kevin queues this as it affects PM. Or it at least needs
> an ack from Kevin.
>
> Regards,
>
> Tony
>  
>> Thanks
>> Gowda
>> 
>> The following changes since commit
>> 1c6ece3c23e58d0dbc687407d606f3560ded582a:
>> 
>>   Merge branch 'omap_fixes_a_3.3rc' of git://git.pwsan.com/linux-2.6
>> (2012-01-26 16:48:37 -0800)
>> 
>> are available in the git repository at:
>> 
>>   git://github.com/elektrobit/linux.git linux-omap-emu-fix
>> 
>> Madhusudhan Gowda (1):
>>       ARM: OMAP3 PM:Save and restore EMU context across MPU OFF
>> 
>>  arch/arm/mach-omap2/cm2xxx_3xxx.c |   16 ++++++++++++----
>>  arch/arm/mach-omap2/cm2xxx_3xxx.h |    2 ++
>>  arch/arm/mach-omap2/pm34xx.c      |    8 ++++++++
>>  3 files changed, 22 insertions(+), 4 deletions(-)
>> 
>> 
>> ----------------------------------------------------------------
>> Please note: This e-mail may contain confidential information intended
>
>> solely for the addressee. If you have received this e-mail in error, 
>> please do not disclose it to anyone, notify the sender promptly, and 
>> delete the message from your system.
>> Thank you.
>> 
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
> ----------------------------------------------------------------
> Please note: This e-mail may contain confidential information intended
> solely for the addressee. If you have received this e-mail in error,
> please do not disclose it to anyone, notify the sender promptly, and
> delete the message from your system.
> Thank you.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
