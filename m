From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 20:01:32 +0200
Message-ID: <20110217180131.GJ14574@legolas.emea.dhcp.ti.com>
References: <4D5D44AF.5050805@ti.com>
 <20110217162000.GP20795@atomide.com>
 <20110217162209.GA13425@legolas.emea.dhcp.ti.com>
 <20110217165953.GR20795@atomide.com>
 <4D5D5770.9020501@ti.com>
 <20110217171747.GC14574@legolas.emea.dhcp.ti.com>
 <4D5D59E5.6020307@ti.com>
 <20110217173711.GF14574@legolas.emea.dhcp.ti.com>
 <4D5D5F13.2010602@ti.com>
 <20110217175217.GI14574@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42825 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753002Ab1BQSBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 13:01:36 -0500
Received: by mail-bw0-f49.google.com with SMTP id 5so3202473bwz.22
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 10:01:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110217175217.GI14574@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 07:52:17PM +0200, Felipe Balbi wrote:
> On Thu, Feb 17, 2011 at 06:46:59PM +0100, Cousson, Benoit wrote:
> > On 2/17/2011 6:37 PM, Balbi, Felipe wrote:
> > >On Thu, Feb 17, 2011 at 06:24:53PM +0100, Cousson, Benoit wrote:
> > >>On 2/17/2011 6:17 PM, Balbi, Felipe wrote:
> > >>>On Thu, Feb 17, 2011 at 06:14:24PM +0100, Cousson, Benoit wrote:
> > >>>>On 2/17/2011 5:59 PM, Tony Lindgren wrote:
> > >>>>>* Felipe Balbi<balbi@ti.com>    [110217 08:20]:
> > >>>>>>On Thu, Feb 17, 2011 at 08:20:01AM -0800, Tony Lindgren wrote:
> > >>>>>>>
> > >>>>>>>Maybe no need to rebase, I'll apply Benoit's series first into
> > >>>>>>>omap-for-linus, then let's applying the other hwmod related patches
> > >>>>>>>should be trivial.
> > >>>>>>
> > >>>>>>So I can drop the omap4 HWMOD part from my branch ?
> > >>>>>
> > >>>>>Yeh assuming Benoit's data is correct.
> > >>>>
> > >>>>Of course, it is :-)
> > >>>>
> > >>>>Then I will add USB in my series.
> > >>>
> > >>>BTW, which branch should I use from your tree to test ?
> > >>
> > >>I'll put that in the refresh version of the branch I have done for
> > >>Tony. I messed up the McSPI changelog... and Tony caught me :-)
> > >>
> > >>I'll push that in 5 minutes.
> > >
> > >cool, let me know
> > 
> > Done, boot tested, and that does remove the warning about the missing
> > opt clock you had with the previous data.
> > 
> > git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
> > 
> > Just let me know if it does break anything else.
> 
> Ok, pulling ;-)

Just tested, all good ;-) Tomorrow I'll test more and send my pull
request.

-- 
balbi
