From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] 34xx spurious interrupts unravelling
Date: Sat, 1 Nov 2008 23:14:35 +0200
Message-ID: <94a0d4530811011414w7c3318eap492253a8acf2e81c@mail.gmail.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:3390 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbYKAVOg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2008 17:14:36 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1884523rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 01 Nov 2008 14:14:35 -0700 (PDT)
In-Reply-To: <1225480873-30835-1-git-send-email-tony@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 31, 2008 at 9:21 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> So it's now starting to look like we need to ensure write posting in
> interrupt handlers for 34xx instead of marking the IO areas as strongly
> ordered.
>
> The first patch in the series reverts marking the IO areas as strongly
> ordered.
>
> The second debug patch also prints out the previous interrupt before
> the spurious interrupt, which should help identify the interrupt
> handler that needs a read back of some register.
>
> So if you see errors like this with dspbridge:
>
> FIXME: spurious irq 95: 0xffffffdf previous irq 26
> FIXME: spurious irq 95: 0xffffffdf previous irq 26
> FIXME: spurious irq 95: 0xffffffdf previous irq 26
> ...
>
> You'll know that the interrupt handler for irq 26 needs a read back
> of some register in the interrupt handler. Most likely you need to
> read back the interrupt ack register right after writing to it in
> the handler, see a later patch in this series for dspbridge.
>
> If you get errors like this during boot:
>
> FIXME: spurious irq 95: 0xffffffdf previous irq 25
> FIXME: spurious irq 95: 0xffffffdf previous irq 25
> FIXME: spurious irq 95: 0xffffffdf previous irq 37
> ...
>
> Most likely we need to do a read back when initializing some devices
> like dispc and gptimer. I don't have patches for these yet..
>
> The other patches fix few interrupt handlers that I'm aware of needing
> this, like i2c-omap and dspbridge. The dspbridge patch only applies
> if you have it installed.
>
> I'd appreciate if people who have been working on this issue would
> torture test this series and provide feedback!

I tried with various dsp tests, and as you mentioned, I was able to
see lots of spurious irq warnings, then I applied patch #4, and those
went away.

No issues.

-- 
Felipe Contreras
