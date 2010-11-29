From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51
Date: Mon, 29 Nov 2010 18:37:03 +0000
Message-ID: <20101129183703.GS30360@rakim.wolfsonmicro.main>
References: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <20101125161112.GB15099@sirena.org.uk>
 <4CEF8453.3070904@nokia.com>
 <20101126125949.GD30360@rakim.wolfsonmicro.main>
 <20101126174517.GE2990@atomide.com>
 <20101127101852.GA27579@opensource.wolfsonmicro.com>
 <20101129181830.GC17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59619 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752039Ab0K2ShH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 13:37:07 -0500
Content-Disposition: inline
In-Reply-To: <20101129181830.GC17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, Nov 29, 2010 at 10:18:31AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [101127 02:10]:

> > Yeah.  Some of it will need to be __devinitdata for hotpluggable things
> > but most of it should be __initdata.  I'll update the regulator API to
> > copy the constraints before the next merge window.

> OK sounds good to me.

FWIW the patch is "regulator: Copy constraints from regulators when
initialising them", posted for review today.
