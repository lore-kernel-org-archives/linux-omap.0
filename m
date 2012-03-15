From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: AM3517evm
Date: Thu, 15 Mar 2012 08:43:35 -0700
Message-ID: <20120315154335.GA29645@animalcreek.com>
References: <CAFu+nvFt8BcO1pDD6CXXM056WYG9AQDTv-boc7xF0C2JuHAyYw@mail.gmail.com>
 <4F5E0036.105@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:39256 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030550Ab2COPuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 11:50:16 -0400
Content-Disposition: inline
In-Reply-To: <4F5E0036.105@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "George C. Huntington, III" <george.huntingtoniii@gmail.com>, linux-omap@vger.kernel.org, mporter@ti.com

On Mon, Mar 12, 2012 at 02:55:02PM +0100, Yegor Yefremov wrote:
> Am 09.03.2012 18:22, schrieb George C. Huntington, III:
> > I would like to make the newer kernel (3.x) work with the AM3517EVM.
> > I have a 2.6.32 and a 2.6.33 that run well on the board, but the
> > recent kernels have kernel panics before even running init.  where
> > should I start?  is there a better place to pursue this?
> 
> Have you tried this one? http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=summary
> 
> I have this one booting one month ago, but I checked out the kernel today and it hangs somewhere:
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.

This looks like you have your console device set to ttyS2 instead of ttyO2.

Which branch of that repository did you use?

Mark
--
