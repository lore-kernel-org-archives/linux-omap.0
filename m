From: Thomas Klute <thomas2.klute@uni-dortmund.de>
Subject: Re: Ftrace Timer on OMAP3
Date: Wed, 30 May 2012 12:35:52 +0200
Message-ID: <4FC5F808.40901@uni-dortmund.de>
References: <4FBFA2EB.708@uni-dortmund.de> <79CD15C6BA57404B839C016229A409A83EA38110@DBDE01.ent.ti.com> <CACVXFVMg140Tj0cAH8aWD7VROgody7E+mEe0pNyou7hpfJUr9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:63714 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab2E3Kf6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 06:35:58 -0400
In-Reply-To: <CACVXFVMg140Tj0cAH8aWD7VROgody7E+mEe0pNyou7hpfJUr9w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Carsten Vogel <carsten.vogel@rub.de>



Am 28.05.2012 10:24, schrieb Ming Lei:
> On Mon, May 28, 2012 at 2:56 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>> On Fri, May 25, 2012 at 20:49:07, Thomas Klute wrote:
>>> Hi everyone,
>>>
>>> we're having some trouble getting useful results from Ftrace on OMAP3
>>> (Gumstix Overo). As you can see in the example output below, function
>>> duration can't be displayed with a precision higher than about 30.5 us,
>>> which matches the frequency of the 32 kHz platform timer. For OMAP1,
>>> using OMAP_MPU_TIMER instead of CONFIG_OMAP_32K_TIMER should provide
>>> better results [1], but I couldn't find anything similar for OMAP3. Just
>>> setting CONFIG_OMAP_32K_TIMER=N didn't change the results. Did I miss
>>> anything, or isn't there any more precise timer?
>>>
>>
>> I believe you are using mainline kernel here, if yes, you should be enabling
>> the dmtimer using commandline argument, "clocksource="gp_timer".
> 
> Also you need to pass 'nohlt' to kernel since gp_timer can't be kept
> when cpu is idled in deep state.

I use the linux-omap tree, but adding "clocksource=gp_timer nohlt" to
the kernel command line did the trick anyways. :-)

Thanks to both of you!
Thomas
