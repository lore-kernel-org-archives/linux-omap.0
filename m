From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 00/13] OMAP: McBSP: hwmod adaptation and runtime
 conversion
Date: Wed, 23 Feb 2011 13:34:30 -0800
Message-ID: <20110223213429.GA30316@atomide.com>
References: <1298038948-19871-1-git-send-email-kishon@ti.com>
 <4D636651.30904@nokia.com>
 <AANLkTinfymZZRDwXHsvOhBU7KTVBRakdZAp46M3JfGD6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63292 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab1BWVel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 16:34:41 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinfymZZRDwXHsvOhBU7KTVBRakdZAp46M3JfGD6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, p-basak2@ti.com, charu@ti.com, shubhrajyoti@ti.com

* ABRAHAM, KISHON VIJAY <kishon@ti.com> [110223 02:11]:
> >>
> >> Created on top of linux OMAP master (linux-omap-2.6 :master)

Does not look like that's the case. This does not seem to compile
because of .name usage in omap_hwmod_addr_space. Also contains
omap_device idle calls that we don't have merged either.
> 
>   Will you be merging this patch series?

No yet. Please rebase on omap-for-linus at commit
7cab8713b1ed0dab08ad6458f92a40b7ff4be619 and make sure each
patch compiles.

Regards,

Tony
