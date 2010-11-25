From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation problem
Date: Thu, 25 Nov 2010 09:02:01 +0200
Message-ID: <20101125090201.256972a4.jhnikula@gmail.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.2.00.1011221745490.20215@utopia.booyaka.com>
	<20101123092630.7267a7ab.jhnikula@gmail.com>
	<20101124233511.GZ31536@atomide.com>
	<20101124235342.GC31536@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49914 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab0KYHBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 02:01:46 -0500
Received: by eye27 with SMTP id 27so271230eye.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 23:01:44 -0800 (PST)
In-Reply-To: <20101124235342.GC31536@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

On Wed, 24 Nov 2010 15:53:42 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Tony Lindgren <tony@atomide.com> [101124 15:25]:
> > 
> > Anyways, Paul's patch should be merged during the -rc cycle
> > because it is currently blocking Amstrad delta being built:
> > 
> > http://armlinux.simtec.co.uk/kautobuild/
> 
> Turns out I'm several hours behind.. The build is
> working with Janusz commit 233538501f707b0176f09af7039fec1e3fcac6e7
> now in mainline.
> 
> I guess no need to merge Paul's fix then?
> 
Not necessary I think if compilers are happy with Janusz's fix. If not,
then very strong reasong to start looking for platform data solution
as soon as possible :-)


-- 
Jarkko
