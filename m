From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP v3.10-rc regressions that no one's fixed
Date: Mon, 17 Jun 2013 04:38:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306170437380.4477@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com> <51B5D105.4080208@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48330 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab3FQEiz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 00:38:55 -0400
In-Reply-To: <51B5D105.4080208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 10 Jun 2013, Lokesh Vutla wrote:

> On Monday 10 June 2013 12:52 PM, Paul Walmsley wrote:
>
> > * 3730 Beagle XM, am335xbone, CM-T3517: uart4_rx.uart4_rx mux failure
> Just booted up my BeagleBone. I didn't see any error for uart4_rx in my boot
> log.
> Since I don't have other boards, I wanted to reproduce this on my BeagelBone.
> Please let me know if I am missing something.

It must be a typo, since am335xbone hasn't booted here since v3.7.  Thanks 
for pointing it out.


- Paul
