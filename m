From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: [patch 2.6.27-rc7-omap1-git 1/2] twl4030-core: move to drivers/mfd
Date: Fri, 3 Oct 2008 16:31:16 -0700
Message-ID: <e5e6ade50810031631q59e527b7ke0e8787a857165f2@mail.gmail.com>
References: <200810011947.55057.david-b@pacbell.net>
	 <20081003133704.GB6251@atomide.com>
	 <e5e6ade50810031312o4cd37f4fhc5f2204f31af8dbb@mail.gmail.com>
	 <200810031516.32367.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:45270 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYJCXbS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 19:31:18 -0400
Received: by gxk9 with SMTP id 9so3305361gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 16:31:17 -0700 (PDT)
In-Reply-To: <200810031516.32367.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 3, 2008 at 3:16 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 03 October 2008, Nathan Monson wrote:
>>   can't get IRQ 378, err -22
>>   twl4030_usb: probe of twl4030_usb failed with error -22
>>   Unable to allocate IRQ for power button
>
> Did you see "i2c_omap i2c_omap.1: controller timed out"
> earlier in the boot sequence?  It would have this symptom,
> among others... Earlier in this thread you'll find:
>
>  http://marc.info/?l=linux-omap&m=122297833314280&w=2
>
> commenting on the issue I noted when I posted this patch;
> showing how I work around that specific I2C error.  It'd
> likely work for you too.

Thanks for pointing this out.  The retry patch earlier in the thread
fixes the problem.

On 5 test boots I received the "i2c_omap i2c_omap.1: controller timed
out" message all 5 times, but it recovers and seems to work fine.

- Nathan
