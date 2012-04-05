From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Thu, 5 Apr 2012 09:49:32 +0100
Message-ID: <20120405084932.GB25053@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205125626.GA11372@n2100.arm.linux.org.uk> <20120205143824.GA12577@n2100.arm.linux.org.uk> <4F336D3A.2060302@ti.com> <20120209223400.GE19159@n2100.arm.linux.org.uk> <4F34B89F.1050904@ti.com> <20120405082442.GA25053@n2100.arm.linux.org.uk> <4F7D5921.2050401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36053 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab2DEItn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 04:49:43 -0400
Content-Disposition: inline
In-Reply-To: <4F7D5921.2050401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Thu, Apr 05, 2012 at 02:04:41PM +0530, Archit Taneja wrote:
> We figured out the culprit patch, reverting this prevents the issue:
>
> commit 46f8c3c7e95c0d30d95911e7975ddc4f93b3e237
> Author: Archit Taneja <archit@ti.com>
> Date:   Fri Oct 7 03:08:44 2011 -0600
>
>     ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields
>
>     Fix the shift and mask macros for DSIx_PPID fields in  
> CONTROL_DSIPHY. The
>     OMAP4430 Public TRM vV has these fields mentioned correctly.
>
>     Signed-off-by: Archit Taneja <archit@ti.com>
>     Acked-by: Benoit Cousson <b-cousson@ti.com>
>     Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>     Signed-off-by: Paul Walmsley <paul@pwsan.com>
>
>
> This was added to be in sync with the register definitions in newer  
> OMAP4 TRMs. But it turns out that the newer TRMs might be actually  
> messing up the register fields in question.

Okay, I've just tried reverting this commit, and the errors have gone.
However, I still see nothing on either display at boot time - not even
the backlight seems to be on.  Should I see anything on the displays?
