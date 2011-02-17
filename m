From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 21:08:09 +0200
Message-ID: <20110217190809.GM14574@legolas.emea.dhcp.ti.com>
References: <4D5D44AF.5050805@ti.com>
 <20110217162000.GP20795@atomide.com>
 <20110217162209.GA13425@legolas.emea.dhcp.ti.com>
 <20110217165953.GR20795@atomide.com>
 <4D5D5770.9020501@ti.com>
 <20110217171747.GC14574@legolas.emea.dhcp.ti.com>
 <4D5D59E5.6020307@ti.com>
 <20110217173711.GF14574@legolas.emea.dhcp.ti.com>
 <4D5D5F13.2010602@ti.com>
 <20110217181849.GV20795@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39632 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757789Ab1BQTIS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 14:08:18 -0500
Received: by mail-bw0-f47.google.com with SMTP id 10so2786035bwz.6
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 11:08:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110217181849.GV20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 10:18:49AM -0800, Tony Lindgren wrote:
> * Cousson, Benoit <b-cousson@ti.com> [110217 09:45]:
> > 
> > Done, boot tested, and that does remove the warning about the
> > missing opt clock you had with the previous data.
> > 
> > git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
> > 
> > Just let me know if it does break anything else.
> 
> Pulled into omap-for-linus. Also now merged are the devel-hwspinlock
> and devel-mcspi branches.

Ok good. Tomorrow I'll send you a proper pull request for my part, will
leave testusb running over night.

-- 
balbi
