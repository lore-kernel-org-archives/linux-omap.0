From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Fri, 6 Sep 2013 11:40:09 -0700
Message-ID: <CA+Bv8Xaw6KMu5MrjdjQfue7F1JtFfAMNyZhC1hyL-RpWz=wo+w@mail.gmail.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
	<52278F84.2080509@elopez.com.ar>
	<CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
	<20130906111408.GI25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:33315 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab3IFSkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Sep 2013 14:40:10 -0400
Received: by mail-qe0-f46.google.com with SMTP id x7so1929036qeu.33
        for <linux-omap@vger.kernel.org>; Fri, 06 Sep 2013 11:40:09 -0700 (PDT)
In-Reply-To: <20130906111408.GI25647@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: mans@mansr.com, =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 6, 2013 at 4:14 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Sep 04, 2013 at 02:47:51PM -0700, Russ Dill wrote:
>> I think this is already taken care of by the way sram.c is using
>> genalloc. The allocation returned should be aligned to 32 bytes. The
>> thumb bit shouldn't be an issue as code is copied based on the start
>> and end makers made by the linker. I may need to add .align statements
>> in the linker so that the start and end markers for the copied code
>> are aligned to at least 8 bytes.
>
> I think you need to read up on what fncpy does... there's more to it
> than just merely copying code at an appropriate alignment.

Yes, I need to add a pair of inlines that do the asm trickery to/from
function addresses. Thanks.
