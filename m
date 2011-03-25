From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: 2.6.38 not booting on sbc8100 (aka devkit8000)
Date: Fri, 25 Mar 2011 10:32:41 +0100
Message-ID: <AANLkTi=gcoX2RrqCpQMGkWb7+WswXB_dD2G+upFx7CXf@mail.gmail.com>
References: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>
	<20110324151844.GT2811@atomide.com>
	<AANLkTik8PW4ad2_4=UxzvL-V7HcpH0=dg-Un5NLkj6Yi@mail.gmail.com>
	<20110324190030.GW2811@atomide.com>
	<AANLkTimdQKo40r9FzhHe94uAF28qGLcf5_5ZzcOrJuTA@mail.gmail.com>
	<20110325102720.d2940de3.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46001 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062Ab1CYJcm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 05:32:42 -0400
Received: by iwn34 with SMTP id 34so856583iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 02:32:42 -0700 (PDT)
In-Reply-To: <20110325102720.d2940de3.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, Mar 25, 2011 at 9:27 AM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Fri, 25 Mar 2011 08:57:04 +0100
> Belisko Marek <marek.belisko@gmail.com> wrote:
>
>> >> > Can you enable DEBUG_LL and EARLY_PRINTK in your .config
>> >> > and add earlyprintk to your cmdline? Then you should see
>> >> > what goes wrong.
>> >> >
>> >> Forgot to mention. I already test this options but result is same like I
>> >> report in
>> >> first email.
>> >
>> > Maybe add some printk statements to start_kernel function in
>> > init/main.c and see if you get any output?
>> Add some printk to function you propose bu no output.
>
> Do you get any output if you don't compile support for your board but
> for something else like for Beagle only so that machine id from
> bootloader and machine(s) supported by the kernel doesn't match?
u-boot pass  mach-type 2002 (in 2.6.38 kernel is MACH_SPARK) so any of
omap2 machines should fit and I should get some warning from kernel
(not supported mach-type or something like that). But no still hang on
Starting kernel...
So this is obvious more problematic.
>
> --
> Jarkko
>

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
