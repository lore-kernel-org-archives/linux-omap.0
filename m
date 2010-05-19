From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Wed, 19 May 2010 11:13:49 -0700
Message-ID: <20100519181348.GE5818@atomide.com>
References: <AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
 <20100518.163145.232774311.Hiroshi.DOYU@nokia.com>
 <AANLkTik_FL2keLD9mdBcg8Rm9n8uYDElg1NdyeT2yy6B@mail.gmail.com>
 <20100518.225835.116348725.Hiroshi.DOYU@nokia.com>
 <AANLkTinpqitfuw3vuDhqXaQH6uHal1nbonVaUg1a2ewt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64259 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab0ESSOA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 14:14:00 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinpqitfuw3vuDhqXaQH6uHal1nbonVaUg1a2ewt@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [100519 02:58]:
> On Tue, May 18, 2010 at 10:58 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
> > Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
> > Date: Tue, 18 May 2010 18:57:55 +0200
> >
> >> On Tue, May 18, 2010 at 4:31 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> >>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> >>>> I'm not familiar with this kind of module loading, but certainly not
> >>>> all systems have udev.
> >>>>
> >>>> I realized the problem because I have a bare-bones system in my
> >>>> beagleboard where I had to manually load mailbox_mach.
> >>>
> >>> With udev or something equivalent, it should work fine.
> >>
> >> But still, you are relying on udev. I don't think we should, and I
> >> don't think there's any need.
> >
> > Some expert may give some comment here.....
> 
> Russell, Tony: should mailbox_mach, a module that checks for logical
> devices be always built-in?
> 
> I think that's the easiest... in my patches I moved the
> architecture-specific code from mach-omapX/devices.c to
> mach-omapX/mailbox.c, so both the logical devices and real platform
> devices are in the same code, and can be built-in.
> 
> This way, there's no need to rely on services like udev to load
> mailbox, then mailbox_mach, then bridgedriver. After all, all
> mailbox_mach is doing is calling functions in mailbox to register the
> logical devices.
> 
> Judging from:
> http://article.gmane.org/gmane.linux.ports.arm.kernel/58555
> 
> The answer is yes.

Maybe try using the tested good old criteria: What works the best
for "standard Linux behaviour" out of the box? :)

Anything that registers platform devices should be built in.
Also anything that's needed to boot the device into a sane operating
mode should be built in. For example, the DSP should be powered
down (or idled on some earlier omaps) even if no bridge is being used.

Cheers,

Tony
