From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: usb_nop_xceiv_register() missing when OTG built as modules
Date: Fri, 05 Mar 2010 09:59:52 -0800
Message-ID: <871vfy3azr.fsf@deeprootsystems.com>
References: <87635d54nn.fsf@deeprootsystems.com>
	<19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
	<87eik03scn.fsf@deeprootsystems.com>
	<20100305090426.GG12757@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:61462 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0CER74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 12:59:56 -0500
Received: by pzk32 with SMTP id 32so1510039pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 05 Mar 2010 09:59:56 -0800 (PST)
In-Reply-To: <20100305090426.GG12757@nokia.com> (Felipe Balbi's message of "Fri\, 5 Mar 2010 11\:04\:26 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi <felipe.balbi@nokia.com> writes:

> On Thu, Mar 04, 2010 at 06:32:40PM +0100, ext Kevin Hilman wrote:
>>Yes, I did that intentionally.  I *want* USB compiled as a module.  If
>>I do that, the build fails, and that's a bug that needs to be fixed.
>
> it depends on where you're calling usb_nop_xceiv_register(), 

It's called from various board files (board-omap3evm.c,
board-4430sdp.c.)

> if you're calling from a file that's built-into the kernel, then
> it's your fault.

It would be my fault if I wrote those board files.  ;)

> I suggest you keep usb as a module, but keep nop xceiv built-in.

Yes, that's the workaround I'm already using, but it is not a fix.

This dependency breaks the ability to build a minimal kernel with
everything as modules (allmodconfig)

The nop xceiv needs a way for built-in code to register itself for
the cases when no xceiv is built as a module.

Kevin


