From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: N8x0 to mainline patches
Date: Thu, 6 Aug 2009 19:27:56 +0300
Message-ID: <da94abde0908060927s57a5bdcfxac4e46db16913820@mail.gmail.com>
References: <87zlb95dwx.fsf@litku.valot.fi> <20090713060354.GJ6589@nokia.com>
	 <87vdlx5b3y.fsf@litku.valot.fi> <20090713065341.GC16778@nokia.com>
	 <20090806071038.GE7374@atomide.com> <87y6pwnc9t.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:58068 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbZHFQ14 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 12:27:56 -0400
Received: by ewy10 with SMTP id 10so916759ewy.37
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2009 09:27:56 -0700 (PDT)
In-Reply-To: <87y6pwnc9t.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Max Filippov <jcmvbkbc@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Aug 6, 2009 at 7:21 PM, Kalle Valo<kalle.valo@iki.fi> wrote:
> My plan is this:
>
> 1. first finish OMAP_TAG_UART removal patch and send it for review
>
> 2. finins and send tusb6010 patch
>
> + omap2-add-usb-tusb6010-c
>
> 2. fold these n8x0 board file patches into one and send it for review:
>
> + n8x0-add-board-file
> + n8x0-onenand-support
> + n8x0-add-spi-support
> + n8x0-add-usb-support

This was item 3, of course. And I forget n8x0_defconfig, I'll send
that as a separate patch.

Tony, does this look ok to you?

Kalle
