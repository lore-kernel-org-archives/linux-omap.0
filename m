From: Tony Lindgren <tony@atomide.com>
Subject: Re: Remove drivers/input/touchscreen/omap directory?
Date: Fri, 5 Dec 2008 10:06:39 -0800
Message-ID: <20081205180637.GC9714@atomide.com>
References: <5d5443650812050555j276aa797j3322254a5fa89e8d@mail.gmail.com> <20081205163420.c607293d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50028 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbYLESGo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 13:06:44 -0500
Content-Disposition: inline
In-Reply-To: <20081205163420.c607293d.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Trilok Soni <soni.trilok@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* Jarkko Nikula <jarkko.nikula@nokia.com> [081205 06:34]:
> On Fri, 5 Dec 2008 19:25:48 +0530
> "ext Trilok Soni" <soni.trilok@gmail.com> wrote:
> 
> > Hi Tony,
> > 
> > I think no one using touchscreen drivers under this directory, please remove.
> > 
> > I will start process of sending tscXXXX patches to upstream soon...
> > 
> That's great! Also drivers/spi/tsc2301-mixer.c can be removed in part
> of the process.

Ahh, I like removing legacy code! :) Both gone now.

Jarkko, there's still the n800_audio_init() stub, maybe check that
and send a patch?

Tony

