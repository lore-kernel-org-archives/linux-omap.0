From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Thu, 5 Apr 2012 03:33:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52691 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab2DEJdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 05:33:37 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

On Wed, 4 Apr 2012, Mohammed, Afzal wrote:

> Reverting merge commit
> 
> 58adb29 Merge branch 'io_chain_devel_3.4' of git://git.pwsan.com/linux-2.6 into prm
> 
> makes OMAP3EVM boot.
> 
> Bisecting into this merge could not be done as build was breaking
> for most of the individual commits in the merge (except when
> HEAD is the last commit of the merge, as below).

I just rebased this series on top of v3.4-rc1 and built each patch in it 
successfully, so it sounds like there's some bisection-specific build 
problem?

As far as the crashes go, I don't think I have an OMAP3EVM, but I'll take 
a look here on the OMAP35xx boards that I do have.

Could you try booting with initcall_debug and posting the boot log?


- Paul
