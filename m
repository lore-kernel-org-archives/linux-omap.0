From: Kevin Hilman <khilman@ti.com>
Subject: Re: arm: omap3: pm34xx.c: Some minor fixups
Date: Thu, 15 Mar 2012 10:27:57 -0700
Message-ID: <87pqcdbwpu.fsf@ti.com>
References: <1331828441-1406-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:55197 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932396Ab2COR1p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 13:27:45 -0400
Received: by dakl33 with SMTP id l33so5135208dak.17
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 10:27:44 -0700 (PDT)
In-Reply-To: <1331828441-1406-1-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Thu, 15 Mar 2012 09:20:39 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreeraz@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Mark,

"Mark A. Greer" <mgreeraz@gmail.com> writes:

> found a some minor issues when looking through pm34xx.c recently
> so these patches try to address them.  My apologies if they are already
> fixed in another branch somewhere.  Based on latest k.o. master branch.

Thanks for the fixes, they look right.

Minor nit: can you resend with linux-arm-kernel in Cc?  Any
upstream-bound patches need to be Cc'd there so the maintainers don't
have to resend them there before submitting a pull request.

Thanks,

Kevin

