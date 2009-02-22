From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] dspbridge: wait less and check the mailbox more
Date: Sun, 22 Feb 2009 07:21:37 +0200 (EET)
Message-ID: <20090222.072137.189714248.Hiroshi.DOYU@nokia.com>
References: <1235171057-7859-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56162 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbZBVFVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 00:21:51 -0500
In-Reply-To: <1235171057-7859-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com, h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, felipe.contrers@nokia.com, ameya.palande@nokia.com

Hi Felipe,

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] dspbridge: wait less and check the mailbox more
Date: Sat, 21 Feb 2009 00:04:17 +0100

> From: Felipe Contreras <felipe.contrers@nokia.com>
> 
> Profiling showed the __delay function is called a lot; checking the mbox
> more often seems to decrease the usage by 2/3 according to OProfile.

Good finding.

> The changes are based on 'arch/arm/plat-omap/mailbox.c'. Tested on OMAP3430.
> 
> Also, remove HW_MBOX_IsFull since it's not used by anybody.

Woundn't it be better to split this one into some logical parts,
tunning up part(decreasing delay) and cleanup part(the others)?

Home brewed MACROs themselves like UTIL_Wait() are basically evil from
kernel source readibility perspective, but keeping consistency within
specific module may be more important and this kind of cleaning up
would be better to be done at onece over a module, in separate
patches.

Hari,
Any comment? if it's ok, please merge it or newer ones into o-z as
well.

      Hiroshi DOYU
