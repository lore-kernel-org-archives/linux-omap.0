From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Thu, 13 Jan 2011 22:41:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101132240220.28621@utopia.booyaka.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com> <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com> <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32896 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab1ANFle (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 00:41:34 -0500
In-Reply-To: <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: "Jan, Sebastien" <s-jan@ti.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Thu, 13 Jan 2011, Bryan Wu wrote:

> On Thu, Jan 13, 2011 at 7:50 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Wed, 12 Jan 2011, Bryan Wu wrote:
> >
> > Does the problem also happen if you boot with 'nosmp' on the kernel
> > command line?
> 
> Yeah, I think so, since Sebastien reported that 'nosmp' doesn't work either.

Will try to find time to give this a shot.  You might want to try a build 
without CONFIG_SMP set to see if it helps.

Is the rootfs that you used downloadable from anywhere?


- Paul
