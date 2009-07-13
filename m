From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: N8x0 to mainline patches
Date: Mon, 13 Jul 2009 09:03:54 +0300
Message-ID: <20090713060354.GJ6589@nokia.com>
References: <87zlb95dwx.fsf@litku.valot.fi>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35929 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbZGMGEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jul 2009 02:04:15 -0400
Content-Disposition: inline
In-Reply-To: <87zlb95dwx.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kalle Valo <kalle.valo@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Max Filippov <jcmvbkbc@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, Jul 13, 2009 at 07:51:10AM +0200, ext Kalle Valo wrote:
> Hello,
> 
> I started working on adding N8x0 support to mainline, currently serial
> console works and I can mount initfs and rootfs on N800. The patches are
> available here:
> 
> http://www.valot.fi/kalle/n8x0/patches/n8x0-add/

I'd say at least patch #2 should be sent for to l-o right now since it
gets rid of another OMAP_TAG.

All the other patches (besides #1) look fine and I guess you could send
all of them here for people to take a look at.

But patch #2 clearly doesn't belong to that series and should be
integrated

-- 
balbi
