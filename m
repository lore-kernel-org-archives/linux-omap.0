From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 26 Oct 2012 22:03:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com> <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com> <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com> <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com> <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41234 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933198Ab2JZWDM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 18:03:12 -0400
In-Reply-To: <20121026201539.GD29548@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

Hi Felipe,

On Fri, 26 Oct 2012, Felipe Balbi wrote:

> On Thu, Oct 25, 2012 at 01:12:12PM +0300, Felipe Balbi wrote:
> > On Tue, Oct 23, 2012 at 09:23:03PM +0200, Jean Pihet wrote:
> > > On Tue, Oct 23, 2012 at 9:19 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > > > On Mon, 22 Oct 2012, Jean Pihet wrote:
> > > >
> > > >> On Mon, Oct 22, 2012 at 6:12 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> > > >>
> > > >> > Do you have CPU_IDLE enabled?
> > > >> FYI the issue is not present with CPU_IDLE enabled.
> > > >
> > > > Hmm, how can you tell?  I thought you weren't able to reproduce it with
> > > > CPU_IDLE disabled either?
> > > I could not reproduce the issue, with and without CPU_IDLE enabled.
> > > What puzzles me is that the PM QoS code only has influence on the
> > > states chosen by cpuidle, so the change should not have any impact
> > > with CPU_IDLE enabled. I reallt need to reproduce the issue.
> > > Let me try with the same setup as yours (bootloader images,
> > > omap2pus_defconfig, angstrom roots).
> > 
> > I just sent a patch to fix a bug I found on OMAP4 panda but while
> > reading this thread again, I think it could be that it's the same bug
> > which is just easier to reproduce on Paul's setup.
> > 
> > Paul, Aaro, can you see if [1] makes the problem go away ? that would be
> > another reason to push [1] during this -rc cycle.
> > 
> > [1] http://marc.info/?l=linux-omap&m=135115602407925&w=2

Thanks for mentioning it, but this patch doesn't fix the I2C timeout 
problem here.  Log fragment below from the 3530ES3 Beagle.


- Paul

Starting portmap daemon: portmap.
Tue Jul 22 00:18:00 UTC 2008
[   23.476684] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   24.492309] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   24.495574] twl: i2c_read failed to transfer all messages
[   24.498535] twl_rtc: Could not read TWLregister D - error -110
[   24.501800] twl_rtc twl_rtc: twl_rtc_read_time: reading CTRL_REG, error 
-110
INIT: Entering runlevel: 5

