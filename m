From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: Fix build issues with missing include
 of linux/bug.h
Date: Wed, 7 Mar 2012 17:32:16 -0800
Message-ID: <20120308013216.GP12083@atomide.com>
References: <20120308012801.GO12083@atomide.com>
 <CAOesGMi3tf7_q1hwOXMGQBLW2EugDcUfH0yL=sgOtwBpYM7xjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30384 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab2CHBcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 20:32:17 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMi3tf7_q1hwOXMGQBLW2EugDcUfH0yL=sgOtwBpYM7xjQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Olof Johansson <olof@lixom.net> [120307 16:59]:
> On Wed, Mar 7, 2012 at 5:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Otherwise we can get the following if bug.h is not included from kernel.h:
> >
> > arch/arm/mach-omap2/powerdomain-common.c:
> > In function 'omap2_pwrdm_get_mem_bank_onstate_mask':
> > arch/arm/mach-omap2/powerdomain-common.c:64:3: error:
> > implicit declaration of function 'WARN_ON' [-Werror=implicit-function-declaration]
> > cc1: some warnings being treated as errors
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Applied to next/fixes-non-critical. Thanks!

Thanks a lot!

Tony
