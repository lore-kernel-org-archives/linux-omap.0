From: David Brownell <david-b@pacbell.net>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old iPod will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 09:03:10 -0700
Message-ID: <200804070903.11354.david-b@pacbell.net>
References: <386072610804070316i15ee172cue9c0cc5803f9a934@mail.gmail.com> <5bd10b9010c8281ff117f7ebb02f7d39@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:35238 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751973AbYDGQFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 12:05:51 -0400
In-Reply-To: <5bd10b9010c8281ff117f7ebb02f7d39@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>, Bryan Wu <cooloney@kernel.org>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Monday 07 April 2008, Felipe Balbi wrote:
> > e) So I hacked the usb-storage driver code, the Linux host on Blackfin
> > will not wait for the 2nc CSW. Then this bug is gone.
> > 
> > This is just a workaround for that, it should not be the right way.
> > Does anyone here meet this issue before, on Davinci or OMAP?
> > We always need a real fix, thanks a lot
> 
> I've seen this already with n800/n810. It came up after a merge with
> mainline that changed usb subsystem a bit.

Which merge was that?

My guess would be that the host side fault reporting
changes (short packet?) didn't get fully reflected in
the MUSB code.

How is "usbtest" behaving?  I'm not sure that would
show errors like this, but at least it'd be good to
know that's not an issue.


> Tony made musb driver work again after the merge
> but still some issues that should be addressed.
> 


