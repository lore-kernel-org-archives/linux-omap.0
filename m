From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Previewer and resizer demo
Date: Wed, 22 Apr 2009 11:06:27 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940432094FD4@dbde02.ent.ti.com>
References: <49EDDDD9.8080207@embedded-sol.com>
 <19F8576C6E063C45BE387C64729E739404280C6022@dbde02.ent.ti.com>
 <49EEA97D.9040409@embedded-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48426 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbZDVFgp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 01:36:45 -0400
In-Reply-To: <49EEA97D.9040409@embedded-sol.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felix Radensky <felix@embedded-sol.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Felix Radensky [mailto:felix@embedded-sol.com]
> Sent: Wednesday, April 22, 2009 10:52 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org Mailing List
> Subject: Re: Previewer and resizer demo
> 
> Hiremath, Vaibhav wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Felix Radensky
> >> Sent: Tuesday, April 21, 2009 8:23 PM
> >> To: linux-omap@vger.kernel.org Mailing List
> >> Subject: Previewer and resizer demo
> >>
> >> Hi,
> >>
> >> Are there any userspace applications that demonstrate
> >> the use of previewer and resizer found in OPMA3 ISP.
> >>
> >>
> > [Hiremath, Vaibhav] Which release or patches you are using?
> >
> > Thanks,
> > Vaibhav Hiremath
> >
> >
> 
> I've got the omap kernel with patches already integrated, so I don't
> know how to determine the patch release. 
[Hiremath, Vaibhav] From where you got these patches? Kernel version should be enough for me to understand the release package.

> What I know is that
> previewer
> is accessible via separate character device.
> 
[Hiremath, Vaibhav] Yes, very true. Irrespective of release package you are using Resizer and Previewer modules are exported to the user space as a stand-alone character driver.

There are some changes in the IOCTL's (New Ioctl added), so I just wanted to make sure that I share buildable version of application.
 
Thanks,
Vaibhav Hiremath

> Thanks.
> 
> Felix.

