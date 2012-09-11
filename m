From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: mux: add support for PAD wakeup event handler
Date: Tue, 11 Sep 2012 13:12:57 +0530
Message-ID: <CAP05o4+sjt7JERPFN1i3kHswOwDL2rVvQcwTMQPBaJPMUXr86Q@mail.gmail.com>
References: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
	<20120910183943.GA1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:45059 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127Ab2IKHm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 03:42:59 -0400
Received: by ggnl1 with SMTP id l1so264777ggn.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 00:42:58 -0700 (PDT)
In-Reply-To: <20120910183943.GA1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 11, 2012 at 12:09 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Ruslan Bilovol <ruslan.bilovol@ti.com> [120910 03:39]:
>> OMAP mux now parses active wakeup events from pad registers and calls
>> corresponding handler, if handler is not registered - corresponding
>> hwmod ISRs once a wakeup is detected.
>> This is useful for cases when routing wakeups to corresponding hwmod
>> ISRs complicates those ISRs handlers (for example, ISR handler may
>> not know who the interrupt source is)
>
> The mux code in arch/arm/mach-omap2 will be going away and replaced
> by device tree based pinctrl-single.

Thanks tony
       when is this device tree based pinctrl-single will be available
in mainline?

regards
keshava
