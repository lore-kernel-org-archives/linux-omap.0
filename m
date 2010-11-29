From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51
Date: Mon, 29 Nov 2010 10:18:31 -0800
Message-ID: <20101129181830.GC17222@atomide.com>
References: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <20101125161112.GB15099@sirena.org.uk>
 <4CEF8453.3070904@nokia.com>
 <20101126125949.GD30360@rakim.wolfsonmicro.main>
 <20101126174517.GE2990@atomide.com>
 <20101127101852.GA27579@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16023 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab0K2SSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 13:18:46 -0500
Content-Disposition: inline
In-Reply-To: <20101127101852.GA27579@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [101127 02:10]:
> On Fri, Nov 26, 2010 at 09:45:17AM -0800, Tony Lindgren wrote:
> 
> > By the way, all the board specific data should be __initdata eventually.
> > Now we're hogging memory for the regulators for all the boards compiled in..
> 
> Yeah.  Some of it will need to be __devinitdata for hotpluggable things
> but most of it should be __initdata.  I'll update the regulator API to
> copy the constraints before the next merge window.

OK sounds good to me.

Tony
