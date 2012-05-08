From: Tony Lindgren <tony@atomide.com>
Subject: Re: defconfig for panda
Date: Tue, 8 May 2012 15:04:35 -0700
Message-ID: <20120508220434.GL5088@atomide.com>
References: <1F91D012-8308-45BB-83AD-90E52D472AC2@kernel.crashing.org>
 <20120330184859.GB8240@atomide.com>
 <B05E7CFB-E2F3-426C-AAA8-622D715DB86A@kernel.crashing.org>
 <20120330213930.GC8240@atomide.com>
 <20120420160126.GA21441@beef>
 <20120420171345.GE21106@atomide.com>
 <CAMrsUdKWx=PDWiMpExBZuUjLeaaheJiZXJowGn5G5MBZ5+5RTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23300 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab2EHWEi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 18:04:38 -0400
Content-Disposition: inline
In-Reply-To: <CAMrsUdKWx=PDWiMpExBZuUjLeaaheJiZXJowGn5G5MBZ5+5RTA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Matt Porter <mporter@ti.com>, Kumar Gala <galak@kernel.crashing.org>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

* Raja, Govindraj <govindraj.raja@ti.com> [120424 02:26]:
> On Fri, Apr 20, 2012 at 10:43 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Matt Porter <mporter@ti.com> [120420 09:04]:
> >> On Fri, Mar 30, 2012 at 02:39:32PM -0700, Tony Lindgren wrote:
> >> > * Kumar Gala <galak@kernel.crashing.org> [120330 14:14]:
> >>
> >> FWIW, the same EHCI + SMSC95xx config is used for Beagle xM for
> >> nfsroot. First thing I enable on any builds.
> >
> > OK, can somebody please do a minimal patch to omap2plus_defconfig
> > for this?
> >
> > Basically run make savedefconfig with those changes added and
> > then diff against omap2plus_defconfig.
> >
> 
> I have not seen the patch to enable this on the list,
> so here is the patch[1] to do the same.

Thanks applying into board branch.

Tony
