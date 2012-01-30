From: Kevin Hilman <khilman@ti.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Mon, 30 Jan 2012 11:36:04 -0800
Message-ID: <87obtlrniz.fsf@ti.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:42894 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751721Ab2A3TgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 14:36:10 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so5878563wib.27
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 11:36:09 -0800 (PST)
In-Reply-To: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	(Grazvydas Ignotas's message of "Fri, 27 Jan 2012 00:57:48 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> Hi,
>
> On 3.2 (I think some earlier versions too), with CONFIG_CPU_IDLE
> enabled GPIO based buttons are not working properly on OMAP3 pandora,
> button presses are almost never registered. The buttons are connected
> GPIO bank4 and have hardware debounce feature enabled.
>
> Doing either of the following solves (or hides) the problem:
> - disabling CPU_IDLE in kernel config
> - disabling debounce for the buttons
> - running a program spinning a loop on the CPU
>
> From what I can see in the code debounce clock is disabled when
> entering idle, can those GPIOs work without debounce clock?

Yes, the clock is only for the debounce feature, but the GPIOs are
capable of wakeups and interrupts with the debounce clock disabled.

Kevin
