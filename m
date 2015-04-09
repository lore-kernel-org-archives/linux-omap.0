From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Fri, 10 Apr 2015 01:37:05 +0300
Message-ID: <CANOLnOMyNesvA2nGC2uMnmYGLBQkU1dnfG1rBg1UWeGMrpHFzQ@mail.gmail.com>
References: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
	<5520E2EE.4080302@gmail.com>
	<CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
	<5521A438.1070008@gmail.com>
	<CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
	<20150406151939.GG18048@atomide.com>
	<20150406154037.GI18048@atomide.com>
	<5522BEEF.2000405@gmail.com>
	<20150406174245.GJ18048@atomide.com>
	<CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
	<20150407022312.GK18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:33369 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbbDIWhH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2015 18:37:07 -0400
Received: by layy10 with SMTP id y10so1062320lay.0
        for <linux-omap@vger.kernel.org>; Thu, 09 Apr 2015 15:37:05 -0700 (PDT)
In-Reply-To: <20150407022312.GK18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 7, 2015 at 5:23 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [150406 11:15]:
>>
>> On 6 April 2015 at 19:42, Tony Lindgren <tony@atomide.com> wrote:
>> > Hmm but it still seems to do something also on cortex-a8 r3p2 that
>> > is supposedly not affected by 430973.. Based on my tests so far, a=
t least
>> > armhf running cpuburn-a8 in the background and doing apt-get updat=
e
>> > segfaults constantly without flush BTAC/BTB. This seems to be the =
case
>> > no matter how the aux ctrl reg bits are set..
>>
>> That sounds.... really odd.  The TRM is fairly explicit about BTB
>> flush executing as nop when IBE is not set. Of course the TRM is not
>> exactly flawless, but still...
>
> Oops, sorry user error.. I was trying to clear IBE as a banked regist=
er
> like L2 enable bit and of course it did not get cleared.. Clearing it
> with a smc call really clears it. And in that case my test case seems=
 to
> work reliably on r3p2 without erratum 430973 enabled.

May I ask how do you perform the smc call? I wanted to clear IBE too
to experiment, but it just hangs my board, even if I just write back
the same value. Here is what I do:

        asm ("mrc p15, 0, %0, c1, c0, 1" : "=3Dr"(val));

        asm (".arch_extension sec\n\t"
             "mov r0,  %0\n"
             "mov r12, #3\n"
             "smc #0\n"
             :: "r"(val) : "r0", "r12");

I just run this from a sysfs write handler, does it need to be run on
SRAM or something?

Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
