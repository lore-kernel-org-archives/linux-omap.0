From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 01/25] ARM: mm: Add strongly ordered descriptor support.
Date: Wed, 14 Sep 2011 11:06:32 +0530
Message-ID: <CAMQu2gw6=RmmoWnRQ34RVjvSBbfvK2-3R9eFXqLZLjw_XR7Jyw@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-2-git-send-email-santosh.shilimkar@ti.com> <20110913202317.GE24252@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:36875 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171Ab1INFgx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 01:36:53 -0400
Received: by mail-gx0-f178.google.com with SMTP id 8so1382115gxk.37
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 22:36:52 -0700 (PDT)
In-Reply-To: <20110913202317.GE24252@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Woodruff Richard <r-woodruff2@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On Wed, Sep 14, 2011 at 1:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:22]:
>> On certain architectures, there might be a need to mark certain
>> addresses with strongly ordered memory attributes to avoid ordering
>> issues at the interconnect level.
>
> This is something Russell needs to look.
>
> You might want to also read the mailing list archives regarding the
> strongly ordered access.
>
> Basically it still won't guarantee that the write gets to the
> device, only a read back from the device in question guarantees
> that at the bus level.
>
Russell has already seen this. I have sent this patches to Russell
before adding them
in the queue.

This is different. There is a BUG in asynchronous bridges on OMAP44XX
devices and
that's the reason it' s needed.

Regards
Santosh
