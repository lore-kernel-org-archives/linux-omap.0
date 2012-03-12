From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
Date: Mon, 12 Mar 2012 11:25:23 +0530
Message-ID: <4F5D8FCB.5050501@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203101425230.27395@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49966 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab2CLFzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 01:55:31 -0400
Received: by ggcs5 with SMTP id s5so2510826ggc.2
        for <linux-omap@vger.kernel.org>; Sun, 11 Mar 2012 22:55:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203101425230.27395@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Sunday 11 March 2012 02:59 AM, Paul Walmsley wrote:
>
> Hi

Hi Paul,

>
> By the way, one other thing I forgot to mention.  It would be really great
> if kerneldoc comments can be created for any new functions added to hwmod,
> PRCM, clock, or omap_device code.  The intention is to help not only
> people unfamiliar with the code, but even ourselves in the future.  I've
> been adding these by hand on Tero's last few patch series, but at some
> point I'll probably stop accepting patches without kerneldoc.

Thanks for updating the kerneldoc comments this time around. Will make
sure patches hence forth come with adequate documentation added.

thanks,
Rajendra
>
>
> thanks,
>
> - Paul

