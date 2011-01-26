From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP
 fixups
Date: Wed, 26 Jan 2011 16:31:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101261617190.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk> <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com> <20110125165919.GD17286@n2100.arm.linux.org.uk> <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
 <20110125174636.GE17286@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251618230.8580@xanadu.home> <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com> <20110126124452.GB4232@n2100.arm.linux.org.uk> <20110126172535.GA15983@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58297 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab1AZVbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 16:31:41 -0500
Received: by vws16 with SMTP id 16so580672vws.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 13:31:41 -0800 (PST)
In-Reply-To: <20110126172535.GA15983@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dave P. Martin" <dave.martin@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 26 Jan 2011, Dave P. Martin wrote:

> SMP_ON_UP fixups lead to vmlinux link errors if those sections are
> discarded at link-time.  In particular this may happen for built-in
> __exit stuff.
> 
> This patch modifies the vmlinux linker script to reduce the amount
> of discarded sections, and tries to make sure that __exit sections
> are kept in.
> 
> This is a hack and probably wrong!  Further discussion is needed.  
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Since discarded sections are by definition not used, we should at least 
put them into the .init section so to discard them at run time.  And 
only the EXIT_TEXT and EXIT_DATA would need to be kept (see x86 for 
example).


Nicolas
