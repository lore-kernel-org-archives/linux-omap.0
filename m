From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Disable USB interrupt in the musb_resume()
	function
Date: Wed, 4 Feb 2009 08:33:11 +0900
Message-ID: <4d34a0a70902031533h56028baalffc9813a7aaa864a@mail.gmail.com>
References: <4d34a0a70901310021l6f42b34es24ca320e44c51ae6@mail.gmail.com>
	 <20090203204235.GH7215@atomide.com> <20090203222842.GB6214@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:22811 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbZBCXdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 18:33:11 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1099339wah.21
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 15:33:11 -0800 (PST)
In-Reply-To: <20090203222842.GB6214@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, =?EUC-KR?B?seix1L/4?= <q1.kim@samsung.com>

On Wed, Feb 4, 2009 at 7:28 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Tue, Feb 03, 2009 at 12:42:36PM -0800, Tony Lindgren wrote:
>> * Kim Kyuwon <chammoru@gmail.com> [090131 00:22]:
>> > USB should be suspended with interrupt disabled[1]. If USB is suspended with
>> > interrupt enabled and connected to host PC, a kernel panic would occur When
>> > it wakes up. Because, after the arch_suspend_enable_irqs() function is called
>> > in the suspend_enter() function, USB Interrupt handler is called, even though
>> > USB controller is still not resumed! All devices are resumed after the
>> > device_resume() is called.
>>
>> Please send the usb patches to the linux-usb@vger.kernel.org list
>> with linux-omap list Cc'd.
>
> and Cc me as well and David Brownell
>

OK.
I will resend this patch to the linux-usb@vger.kernel.org list with CCing
linux-omap list, Felipe Balbi and David Brownell

> --
> balbi
>


-- 
Kim Kyuwon
