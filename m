From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Tue, 29 Jul 2014 12:57:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com> <20140707080238.GF28884@atomide.com> <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com> <20140729064243.GF29045@atomide.com> <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
 <20140729084930.GH29045@atomide.com> <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39583 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaG2M5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 08:57:44 -0400
In-Reply-To: <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Tue, 29 Jul 2014, Paul Walmsley wrote:

> I will add code to read back the values from the sysfs files, just to make 
> sure they are being set.

Confirmed that they are.

Are you using NFS root on 37xxevm or MMC root?


- Paul
