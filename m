From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 07/10] ARM: OMAP2+: gpmc: generic timing calculation
Date: Fri, 24 Aug 2012 12:54:47 -0700
Message-ID: <20120824195446.GV11011@atomide.com>
References: <cover.1345524670.git.afzal@ti.com>
 <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
 <50359C64.40603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24290 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760132Ab2HXTyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 15:54:52 -0400
Content-Disposition: inline
In-Reply-To: <50359C64.40603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@TI.COM>
Cc: Afzal Mohammed <afzal@TI.COM>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jon Hunter <jon-hunter@TI.COM> [120822 19:58]:
> 
> So although this may consolidate how the timings are calculated today, I
> am concerned it will be confusing to add timings for a new device. At
> least if I am calculating timings, I am taking the timing information
> for the device and translating that to the how I need to program the
> gpmc register fields.

Yes agreed. Also as some values make sense only in cycles, converting them
back and forth to time is wrong. So at least some values should have an
option to specify them in cycles directly, and then ignore any time based
values.

Regards,

Tony
