From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: 2.6.38 not booting on sbc8100 (aka devkit8000)
Date: Fri, 25 Mar 2011 08:53:06 +0100
Message-ID: <AANLkTi=BwAOJkHRK=AxBdUHSf3vq8MM+i55TOGuuqeHs@mail.gmail.com>
References: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>
	<20110324151844.GT2811@atomide.com>
	<AANLkTik8PW4ad2_4=UxzvL-V7HcpH0=dg-Un5NLkj6Yi@mail.gmail.com>
	<20110324190030.GW2811@atomide.com>
	<20110325091316.8a39d71a.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38156 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1CYHxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 03:53:08 -0400
Received: by iwn34 with SMTP id 34so776328iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 00:53:07 -0700 (PDT)
In-Reply-To: <20110325091316.8a39d71a.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, Mar 25, 2011 at 8:13 AM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Thu, 24 Mar 2011 12:00:30 -0700
> Tony Lindgren <tony@atomide.com> wrote:
>
>> * Belisko Marek <marek.belisko@gmail.com> [110324 08:18]:
>> > On Thu, Mar 24, 2011 at 4:18 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > > * Belisko Marek <marek.belisko@gmail.com> [110324 02:50]:
>> > > > Hi,
>> > > >
>> > > > Try to run 2.6.38 on my sbc8100
>> > > > (use mach-type for devkit8000 because boards are similar) board but
>> > > > when u-boot load it to ram I see just:
> ...
>> > > Can you enable DEBUG_LL and EARLY_PRINTK in your .config
>> > > and add earlyprintk to your cmdline? Then you should see
>> > > what goes wrong.
>> > >
>> > Forgot to mention. I already test this options but result is same like I
>> > report in
>> > first email.
>>
>> Maybe add some printk statements to start_kernel function in
>> init/main.c and see if you get any output?
>>
> For earlyprintk worth to check also
> arch/arm/plat-omap/include/plat/uncompress.h that there is entry for
> sbc8100 (double check with devkit8000 as there is entry for it and if
> you are re-using the mach-type).
Thanks for hint. It was missing there so I add line:
DEBUG_LL_OMAP3(3, devkit8000); (I'm convince linux to use mach-type
for devkit8000)
But still same result.
Bytes transferred = 2898680 (2c3af8 hex)
## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   Linux-2.6.37-00001-g88870c9-dirt
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2898616 Bytes =  2.8 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Anybody with devkit8000 have success to run 2.6.37 kernel on board?
>
> --
> Jarkko
>

regards,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
