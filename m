From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51
Date: Fri, 26 Nov 2010 09:45:17 -0800
Message-ID: <20101126174517.GE2990@atomide.com>
References: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <20101125161112.GB15099@sirena.org.uk>
 <4CEF8453.3070904@nokia.com>
 <20101126125949.GD30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58114 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab0KZRpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 12:45:30 -0500
Content-Disposition: inline
In-Reply-To: <20101126125949.GD30360@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [101126 04:50]:
> On Fri, Nov 26, 2010 at 11:56:35AM +0200, Srikar wrote:
> > On 11/25/2010 06:11 PM, ext Mark Brown wrote:
> > > On Thu, Nov 25, 2010 at 05:52:23PM +0200, Srikar wrote:
> > >
> > >> +static struct regulator_consumer_supply rx51_vdac_supply[] = {
> > >> +	{
> > >> +#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
> > > The ifdefs here aren't really saving much...

By the way, all the board specific data should be __initdata eventually.
Now we're hogging memory for the regulators for all the boards compiled in..

Regards,

Tony

