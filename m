From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/5] omap: add ocp2scp as a misc driver
Date: Thu, 31 May 2012 20:46:14 +0000
Message-ID: <201205312046.14823.arnd@arndb.de>
References: <1338375394-16268-1-git-send-email-kishon@ti.com> <201205310922.18550.arnd@arndb.de> <CAAe_U6J3p9Lh9g82tSSLxOJ7nqrozdRe11zV_v2rqTuMYPjbyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50158 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab2EaUrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 16:47:21 -0400
In-Reply-To: <CAAe_U6J3p9Lh9g82tSSLxOJ7nqrozdRe11zV_v2rqTuMYPjbyA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com

On Thursday 31 May 2012, ABRAHAM, KISHON VIJAY wrote:
> > I would mark the multiplexed device compatible with "simple-bus", which
> > results in the child devices automatically getting added.
> 
> hmm.. ocp2scp has a sysconfig register and it also has a module mode
> by which it can be enabled/disabled. I was making use of pm_runtime
> API's to control these registers (Apart from creating child devices,
> the driver also has a call to pm_runtime_enable). 

I see. 

> I'm not sure if with
> "simple-bus" we'll be able to do those. I have to check on that.

How about making it compatible with both "simple-bus" and something
that handles the pm_runtime requirements?

I don't understand enough of what needs to be done for pm_runtime
across a lot of devices, but I'd hope that it should be possible
to do that in a generic way based on the device definition.

	Arnd
