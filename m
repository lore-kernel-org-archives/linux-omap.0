From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Mon, 1 Jun 2015 11:06:58 -0700
Message-ID: <20150601180658.GB30984@atomide.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
 <556C8ED5.5050000@myspectrum.nl>
 <20150601173126.GY30984@atomide.com>
 <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
 <20150601180429.GA30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55166 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbbFASHB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 14:07:01 -0400
Content-Disposition: inline
In-Reply-To: <20150601180429.GA30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jeroen Hofstee <linux-arm@myspectrum.nl>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150601 11:06]:
> * Paul Walmsley <paul@pwsan.com> [150601 10:45]:
> > 
> > See for example the "Build warnings from toolchain", "Kernel warnings 
> > during boot to userspace", "Kernel warnings during PM test", and "Obsolete 
> > Kconfig symbols" sections here:
> > 
> > http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/README.txt
> 
> OK somehow 3517evm is listed under "skip" there? 

Oh I see you have two 3517 devices there, never mind.

Hmm now I'm wondering what the panda es warnings listed there are..

Tony
