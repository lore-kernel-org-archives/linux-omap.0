From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/10] omap non-critical fixes for v3.5 merge window
Date: Fri, 11 May 2012 01:37:48 -0700
Message-ID: <CAOesGMg-_KOTrrho1LeLhd0sevUG8hTTacgtwuzCP=BUZJ9VmA@mail.gmail.com>
References: <4fac0be2.e9a0320a.1f37.7e70SMTPIN_ADDED@mx.google.com>
	<CAOesGMi0+fty-x1kq0qo+msya=p5xyQDsB9iFrtht38Rn5V=Eg@mail.gmail.com>
	<alpine.DEB.2.00.1205110231120.3201@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63021 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276Ab2EKIht (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 04:37:49 -0400
Received: by yhmm54 with SMTP id m54so2334633yhm.19
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 01:37:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205110231120.3201@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, May 11, 2012 at 1:33 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Olof,
>
> On Fri, 11 May 2012, Olof Johansson wrote:
>
>> I did notice that omap2plus_defconfig has grown a new warning caused
>> by "ARM: OMAP2+: clean up some cppcheck warnings" (oh, the irony!):
>>
>> arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
>> arch/arm/plat-omap/usb.c:40:6: warning: unused variable 'status'
>> [-Wunused-variable]
>
> Thanks, this has been fixed by:
>
> http://marc.info/?l=linux-omap&m=133660322929805&w=2

Sounds good, I'll wait for it to trickle in on a future pull request.


-Olof
