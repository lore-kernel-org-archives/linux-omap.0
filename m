From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Tue, 15 Mar 2011 19:54:48 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com>
References: <20110314192538.GH7258@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:61537 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755985Ab1COR5C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 13:57:02 -0400
In-Reply-To: <20110314192538.GH7258@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, 14 Mar 2011, Tony Lindgren wrote:
> I've applied few random fix like patches today into omap-for-linus
> but that's it for this merge window.
>
> So let's do some testing with with Stephen's for-next and
> omap-for-linus and start queueing up fixes for the -rc cycle.

I did some quick testing:

linux-omap/master, omap2plus_defconfig:

 	- RM-680 hangs after uncompressing kernel. earlyprintk shows:

 	[    0.293395] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_core
 	[    0.300903] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_per
 	[    0.308288] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
 	[    0.316101] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.

 	(then some garbage)

 	- With RX-51 I get the same messages, but no hang.

omap-for-linux, omap2plus_defconfig:

 	- Pretty much the same. RM-680 hangs and the first bad commit is
 	ce722d269ff85ab11aa680784bcc6eff06e3e3ea and earlyprintk shows
 	"external abort on non-linefetch" in omap_hwmod_read() after
 	above messages.

Mainline kernel (v2.6.38) boots fine.

A.
