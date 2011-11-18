From: Omar Ramirez Luna <or.rmz1@gmail.com>
Subject: Re: [PATCH v16 09/12] OMAP: dmtimer: low-power mode support
Date: Thu, 17 Nov 2011 20:19:50 -0600
Message-ID: <CAPTm=KEJsX0AszZW7wKYrY-M6QqZMctHRqW70DNQ6x6LdHXXkA@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
	<CAPTm=KGDEKGxLpJt0t6k_NL5Wz81NkMmRJ+OkmyvHedd6_exgQ@mail.gmail.com>
	<CAC83ZvJSev97waAOuzoJsFTX4vmeVFxkg6BzpjQm+Tjo3cbhpg@mail.gmail.com>
	<CAPTm=KHxSvyCb4i02vnuU9Wz-0j3h+h_UvDc0An5mwb2472dPg@mail.gmail.com>
	<CAC83Zv+8+gh_bvtp90s+jiQNuxLcA=R2503V9swupnA1S91L_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55434 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057Ab1KRCTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 21:19:51 -0500
Received: by mail-gx0-f174.google.com with SMTP id b2so1925987ggn.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 18:19:50 -0800 (PST)
In-Reply-To: <CAC83Zv+8+gh_bvtp90s+jiQNuxLcA=R2503V9swupnA1S91L_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu, Nov 17, 2011 at 3:42 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
...
>>>> Is the intention to restrict enabling the dmtimer clocks from hard|soft irqs?
>>> The aim is to prevent client drivers perform clock enable/disable independently.
>>> Instead just use the request/start/stop APIs. In that way we can make clock
>>> enable/disable functions static in the future.
>>
>> Those are the APIs I'm using, omap_dm_timer_request_specific from a
>> softirq triggers this warning, this was not hinted by the patch or
>> cover letter of the series, hence the question:
>>
>> Was this change intentional? Does omap_dm_timer_request_specific
>> should be allowed on other contexts (soft|hard irq)?
> omap_dm_timer_request_specific() uses spin_lock_irqsave and
> spin_unlock_irqrestore
> to protect the timer list. There is nothing specific to prevent this
> function from being
> called from interrupt context. But you probably have to be careful to
> avoid deadlock
> in the interrupt context by disabling interrupts appropriately so that
> we avoid trying
> to re-acquire the lock.

? ...interrupt context should have interrupts disabled.

>If you send me the code snippet I can have a look.

Here it is a module that triggers this:

http://pastebin.com/bfcWtmQp

Please apply this patch too, otherwise OOT modules disable lockdep:

http://comments.gmane.org/gmane.linux.kernel/1216036

Also enable Schedule-while-atomic checks as this triggers errors even
on process context, I have prepared a patch for those, will submit
soon.

And BTW, these errors are seen since patch "ARM: OMAP: dmtimer:
switch-over to platform device driver", where code to do clk_get was
placed under spin_lock_irqsave, clk_get is the one holding a
mutex_lock which can't be done under a spin_lock.

Regards,

Omar
