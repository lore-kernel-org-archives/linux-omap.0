From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
	asm/spinlock.h
Date: Wed, 26 Jan 2011 12:44:52 +0000
Message-ID: <20110126124452.GB4232@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk> <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com> <20110125165919.GD17286@n2100.arm.linux.org.uk> <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com> <20110125174636.GE17286@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251618230.8580@xanadu.home> <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42753 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab1AZMpN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 07:45:13 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 26, 2011 at 11:11:31AM +0000, Dave Martin wrote:
> Do we need to consider any other discarded sections?  In vmlinux.lds, I have:
> 
>  /* Default discards */
>  /DISCARD/ : { *(.exit.text) *(.cpuexit.text) *(.memexit.text)
> *(.exit.data) *(.cpuexit.data) *(.cpuexit.rodata) *(.memexit.data)
> *(.memexit.rodata) *(.exitcall.exit) *(.discard) *(.discard.*) }

We need to keep all the text exit stuff, and that could well want
data exit stuff, so I think we need ot keep most of that.  Maybe not
the .discard* stuff though.

> If we put every fixup in its own _section_ we might be able to
> collapse those out of the list at link time too.  However, that seems
> hard to achieve, since in order to do the correct link-time filtering
> we would need the fixup's section name to be based on the referenced
> section's name ... due to preprocessor limitations I don't think we
> can do that automatically (and manual maintenance would be a bad
> plan).

I suspect if it was sanely possible to do, then x86 would already be
doing it as they've had this problem for a lot longer than we have.
It might be worth talking to toolchain people to see if it can be made
to work somehow - but we really don't want to get rid of all discarded
section warnings.

IOW, if we have a text segment which is included in the image and it
references discarded .exit text, we really do want it to fail at link
time.
