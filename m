From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
Date: Tue, 31 Jan 2012 13:27:01 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201311315420.2759@xanadu.home>
References: <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com>
 <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
 <20120131095606.GA889@n2100.arm.linux.org.uk>
 <CAMQu2gwG_JwPMzV0v2hedvDz=HHq0SNbbH+Zapyd8fJt47kjGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Jht2XsrMB1aFD+uPHfjCfA)"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:20182 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab2AaS1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 13:27:07 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LYO0052TDUY5V60@VL-VM-MR003.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 31 Jan 2012 13:25:46 -0500 (EST)
In-reply-to: <CAMQu2gwG_JwPMzV0v2hedvDz=HHq0SNbbH+Zapyd8fJt47kjGQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Jht2XsrMB1aFD+uPHfjCfA)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:

> On Tue, Jan 31, 2012 at 3:26 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > So, as many people have said, we're not going to go down the route of
> > allowing platforms to hook into this code.  There's plenty of other
> > solutions to this problem in different parts of the system that would
> > be more than adequate, and would benefit everyone not just the kernel.
> >
> Sure. The marco has missed those details. Thanks for the
> useful information. At least I can fix the stack size for internal
> use.

If you intend to ignore our advises and continue with the quick and 
dirty solution for your internal tree, then at least don't brag on a 
public list about it.

> > Your continued resistance to every alternative suggestion but your
> > (broken) hook is getting extremely frustrating.  Please try some of
> > these other approaches which are being proposed.  Thanks.
> 
> I was just trying to get more information about the alternatives and
> trying to bring out possible issues. I know for sure that boot-loader is
> not an option since we have had many instances where it has not worked.
> 
> I also understand that patching early common code is going to be tricky
> and of-course against the single zImage.
> 
> So the option mentioned by Nicolas and Catalin about 1:1 mapping
> and configuring the registers in platform specific code was looking
> a way forward. So was asking more questions about whether this can
> work in all cases. Specifically for A15.

So far this is apparently your best option.  And luckily the code to 
create a 1:1 mapping, turn off MMU, then turn MMU back on and tear down 
the 1:1 mapping already exists.  All you need to do is to insert the 
cache workaround activation in the middle of that instead of shutting 
the CPU down.

> As per Catalin's email, it is best to handle those cases before MMU is 
> enabled with boot-monitor or pre-load code.

These days bootloaders are turning the MMU on for themselves, so you'll 
need pre-load code for the bootloader already.  Either that, or the 
issue is not necessarily _that_ critical in which case you can afford to 
enable your workaround a bit later during the kernel boot.


Nicolas

--Boundary_(ID_Jht2XsrMB1aFD+uPHfjCfA)--
