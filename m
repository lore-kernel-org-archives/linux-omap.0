From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: defconfig for omap3-evm
Date: Fri, 21 Nov 2008 18:46:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E8E67E10@dbde02.ent.ti.com>
References: <52c7556c0811210431l430fb536ie79fc85f98960e44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45221 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbYKUNRH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 08:17:07 -0500
In-Reply-To: <52c7556c0811210431l430fb536ie79fc85f98960e44@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Pundir <pundiramit@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Amit Pundir [mailto:pundiramit@gmail.com]
> Sent: Friday, November 21, 2008 6:02 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: defconfig for omap3-evm
> 
> In that I was trying to enable OMAP2 also and it failed and ask me
> to
> choose only one. Otherwise I have used only OMAP3 option during
> which
> build fail.
> 
> The reason I enable OMAP2 in that config is that the variable
> (undefined reference to `omap2_int_ctrl') which the build is unable
> to
> reference will only be available if OMAP2 is enabled.
> 
[Hiremath, Vaibhav] I believe with TI kernel package (available with EVM) there is no legacy driver support for OMAP3EVM LCD panel (lcd_omap3evm.c), so you will not be able to make through. One way is to back-port current community driver to 2.6.22-omap1.

I am not sure about your use-case and requirement, but the better way could be to use either community driver or TI package.

Again Koen Kooi has already conformed that X is running for him on both the kernels, so if you could share some information about the issue you are facing with X then may be we could help you.


> Regards
> Amit Pundir
> 
> On Fri, Nov 21, 2008 at 5:55 PM, Hiremath, Vaibhav <hvaibhav@ti.com>
> wrote:
> >
> >
> > Thanks,
> > Vaibhav Hiremath
> >
> >> -----Original Message-----
> >> From: Amit Pundir [mailto:pundiramit@gmail.com]
> >> Sent: Friday, November 21, 2008 5:46 PM
> >> To: Hiremath, Vaibhav
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: defconfig for omap3-evm
> >>
> >> here it is.
> >>
> > [Hiremath, Vaibhav] Is this the valid config file? The reason I am
> asking is, I see both OMAP2 and OMAP3 architectures have been
> enabled.
> >
> >> Thanks
> >> Amit Pundir
> >>
> >> On Fri, Nov 21, 2008 at 5:39 PM, Hiremath, Vaibhav
> <hvaibhav@ti.com>
> >> wrote:
> >> > I think you missed to attach the .config file.
> >> >
> >> > Thanks,
> >> > Vaibhav Hiremath
> >

