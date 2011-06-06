From: Tony Lindgren <tony@atomide.com>
Subject: Re: Testing cbus in N800
Date: Mon, 6 Jun 2011 04:39:46 -0700
Message-ID: <20110606113945.GM11352@atomide.com>
References: <20110605221503.GA14454@spirit>
 <BANLkTimuJtuZk-khG4UMPzXuOVL285CcHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65497 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756446Ab1FFLju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 07:39:50 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimuJtuZk-khG4UMPzXuOVL285CcHw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Nicolau Werneck <nwerneck@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

* S, Venkatraman <svenkatr@ti.com> [110605 21:08]:
> Here is one attached which was known to be working (a few months ago,
> I haven't tested recently)
> 
> On Mon, Jun 6, 2011 at 3:45 AM, Nicolau Werneck <nwerneck@gmail.com> wrote:
> > Hello. I wanted to try the latest cbus patches in my N800. I
> > downloaded the branch from
> >
> > git://gitorious.org/usb/usb.git cbus
> >
> > But there is no "defconfig" file for either N800 or N810. Does
> > anybody have a config file ready to use?...

Looks like I've accidenentally merged some version of next into cbus
branch.. Anyways fixed it up now with some merge -s ours trickery.
Pushed out now, will take few minutes to show up on mirrors.

Regards,

Tony
