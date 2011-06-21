From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Bug in _und_usr on dual-core ARM?
Date: Tue, 21 Jun 2011 10:58:18 +0100
Message-ID: <20110621095818.GA23802@n2100.arm.linux.org.uk>
References: <BANLkTinY+_+tHatRWuRFUJewUibpmvkUqA@mail.gmail.com> <20110621091529.GA22868@n2100.arm.linux.org.uk> <BANLkTinUYZm+Q3WBGLTQRXz1V2ca1AwE=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37189 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440Ab1FUJ6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 05:58:33 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinUYZm+Q3WBGLTQRXz1V2ca1AwE=g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, Zhou Ming-a17711 <a17711@motorola.com>

On Tue, Jun 21, 2011 at 05:37:31PM +0800, TAO HU wrote:
> Hi, Russell
> 
> Wouldn't it lead to oops with your patch?

The might_sleep() occurs because its trying to process the page fault.
We shouldn't be trying to do that with IRQs disabled - instead, we
should try to fix up the fault from kernel space by invoking the fixup
for the ldrt instructions in __und_usr.

This may throw the system into a loop against your process (which you
should still be able to kill) which will suggest that there's dirty
I-cache lines - we seem to be executing code in a non-present page
(at 0xafd0ce5c).
