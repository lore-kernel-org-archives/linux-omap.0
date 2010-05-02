From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: mailbox_mach dependency problem
Date: Sun, 2 May 2010 15:57:42 +0300
Message-ID: <v2k94a0d4531005020557w60b0ca34q3703ddf39d0d82aa@mail.gmail.com>
References: <h2g94a0d4531005010747n6ef7b7d0r9b4714d289d61032@mail.gmail.com>
	 <20100501173328.GA4706@gandalf>
	 <w2y94a0d4531005011608kda24768ep87897ec46b39641e@mail.gmail.com>
	 <20100502071354.GA2360@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34514 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab0EBM5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 08:57:44 -0400
Received: by bwz19 with SMTP id 19so856532bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 05:57:42 -0700 (PDT)
In-Reply-To: <20100502071354.GA2360@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <hiroshi.doyu@gmail.com>

On Sun, May 2, 2010 at 10:13 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sun, May 02, 2010 at 02:08:58AM +0300, Felipe Contreras wrote:
>> On Sat, May 1, 2010 at 8:33 PM, Felipe Balbi <me@felipebalbi.com> wrote:
>> > On Sat, May 01, 2010 at 05:47:57PM +0300, Felipe Contreras wrote:
>> >> The easiest solution would be to make mailbox_mach built-in when
>> >> mailbox is configured, however, mailbox_mach needs mailbox to be
>> >> loaded.
>> >
>> > generally platform_device instantiation isn't compiled as a module. The
>> > patch below should probably help but I didn't test it.
>>
>> Yeah, but as I said above... that doesn't work:
>>
>> arch/arm/mach-omap2/built-in.o: In function `omap2_mbox_probe':
>> /data/public/dev/omap/linux-omap/arch/arm/mach-omap2/mailbox.c:389:
>> undefined reference to `omap_mbox_register'
>> arch/arm/mach-omap2/built-in.o: In function `omap2_mbox_remove':
>> /data/public/dev/omap/linux-omap/arch/arm/mach-omap2/mailbox.c:439:
>> undefined reference to `omap_mbox_unregister'
>
> now I see the problem. You shouldn't put that kind of stuff on the
> driver. The driver can be built as a module but the device will probably
> be built-in. You'll need a more intrusive change to fix that, I guess.

Indeed, that was my understanding, but the mailbox doesn't seem to be
designed that way. Apparently the driver has an internal linked list
of mailboxes, and the platform device registers a bunch of them.
Effectively they need each other.

-- 
Felipe Contreras
