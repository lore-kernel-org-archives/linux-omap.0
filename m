From: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
Subject: Re: [PATCH v2] twl4030 reboot workaround
Date: Fri, 30 Jul 2010 08:48:15 +0300
Message-ID: <20100730054815.GN12063@edollo>
References: <20100729061608.GG12063@edollo> <1280385678-4366-1-git-send-email-ext-mikko.rapeli@nokia.com> <AANLkTi=OkfRGvW05ZTOaSU+-r7jo40wHFK_pkQM9Hmw=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51579 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0G3Fs0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jul 2010 01:48:26 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=OkfRGvW05ZTOaSU+-r7jo40wHFK_pkQM9Hmw=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Rapoport <mike.rapoport@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "mturquette@ti.com" <mturquette@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>

On Thu, Jul 29, 2010 at 09:10:43PM +0200, ext Mike Rapoport wrote:
> On Thu, Jul 29, 2010 at 9:41 AM, Mikko Rapeli
> <ext-mikko.rapeli@nokia.com> wrote:
> > From: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
> >
> > Original patch: http://marc.info/?l=linux-omap&m=126522625032441&w=2
> >
> > "Removes TWL4030 sleep script prior to rebooting, only on OMAP3. This is
> > necessary since DPLL3 reset causes SYS_OFFMODE pin to go low, resulting
> > in the sleep script being executed on TWL4030. This usually results in
> > VDD1 & VDD2 voltage collapse while ROM code is executing, followed by an
> > MPU Watch Dog reset or worse, an irrecoverable hang."
> 
> I had a similar issue when my system hanged on hard reset when there
> was a TWL sleep script installed.
> The workaround I've found was to install the sleep script immediately
> before entering the suspend state and remove the script on the resume
> path.
> If you think that such approach is appropriate I can send a patch.

Yes, I think this patch would be a good idea too since it fixes a real
issue.

-Mikko
