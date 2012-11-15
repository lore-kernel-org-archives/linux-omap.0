From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: add get_user() support for 8 byte types
Date: Thu, 15 Nov 2012 09:19:37 +0000
Message-ID: <201211150919.37343.arnd@arndb.de>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org> <201211130911.09613.arnd@arndb.de> <20121113112430.GF28341@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121113112430.GF28341@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rob Clark <rob.clark@linaro.org>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 November 2012, Russell King - ARM Linux wrote:
> You're missing something; that is one of the greatest powers of open
> source.  The many eyes (and minds) effect.  Someone out there probably
> has a solution to whatever problem, the trick is to find that person. :)
> 
> I think we have a working solution for this for ARM.  It won't be suitable
> for every arch, where they have 8-bit and 16-bit registers able to be
> allocated by the compiler, but for architectures where the minimum register
> size is 32-bit, what we have below should work.

I don't mind at all adding the extension to ARM, and I think it's pretty
cool that you guys actually found a working solution.

The part that worries me is that we are making architecture independent
code depend on a clever hack that may or may not be possible to implement
on a given architecture, and that most architecture maintainers wouldn't
know how to implement correctly even if it's possible.

	Arnd
