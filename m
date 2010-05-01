From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: mailbox_mach dependency problem
Date: Sun, 2 May 2010 02:08:58 +0300
Message-ID: <w2y94a0d4531005011608kda24768ep87897ec46b39641e@mail.gmail.com>
References: <h2g94a0d4531005010747n6ef7b7d0r9b4714d289d61032@mail.gmail.com>
	 <20100501173328.GA4706@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50916 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab0EAXJA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 19:09:00 -0400
Received: by bwz19 with SMTP id 19so717672bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 16:08:58 -0700 (PDT)
In-Reply-To: <20100501173328.GA4706@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <hiroshi.doyu@gmail.com>

On Sat, May 1, 2010 at 8:33 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sat, May 01, 2010 at 05:47:57PM +0300, Felipe Contreras wrote:
>> The easiest solution would be to make mailbox_mach built-in when
>> mailbox is configured, however, mailbox_mach needs mailbox to be
>> loaded.
>
> generally platform_device instantiation isn't compiled as a module. The
> patch below should probably help but I didn't test it.

Yeah, but as I said above... that doesn't work:

arch/arm/mach-omap2/built-in.o: In function `omap2_mbox_probe':
/data/public/dev/omap/linux-omap/arch/arm/mach-omap2/mailbox.c:389:
undefined reference to `omap_mbox_register'
arch/arm/mach-omap2/built-in.o: In function `omap2_mbox_remove':
/data/public/dev/omap/linux-omap/arch/arm/mach-omap2/mailbox.c:439:
undefined reference to `omap_mbox_unregister'

-- 
Felipe Contreras
