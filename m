From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: wear-leveling necessary on N810 internal/removable cards?
Date: Fri, 16 May 2008 09:14:36 +0900
Message-ID: <9c9fda240805151714ydf70459gf3d8e073671cc5b@mail.gmail.com>
References: <20080515231104.GC11713@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:33063 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYEPAOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 20:14:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so607779wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 17:14:36 -0700 (PDT)
In-Reply-To: <20080515231104.GC11713@swansys>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>

Hi,

On Fri, May 16, 2008 at 8:11 AM, green <greenfreedom10@gmail.com> wrote:
> Okay, I guess this a somewhat off-topic question for this list, but I'm not
> sure where else to ask it, so please forgive me.
>
> Simply: do the controllers for the internal and removeable Flash cards of the
> Nokia N810 do wear-leveling automatically or should I use something like JFFS2
> to handle that?  I suppose that the location of the kernel, initfs, and rootfs
> does not do wear-leveling because the maemo OS does use JFFS2 for the rootfs,
> but I'm not sure about the two Flash cards.
>

It's MMC cards which means it does its own wear-leveling internally.
So you don't need to worry it.

Thank you,
Kyungmin Park
