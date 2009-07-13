From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: N8x0 to mainline patches
Date: Mon, 13 Jul 2009 09:51:45 +0300
Message-ID: <87vdlx5b3y.fsf@litku.valot.fi>
References: <87zlb95dwx.fsf@litku.valot.fi> <20090713060354.GJ6589@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:39103 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbZGMGvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jul 2009 02:51:50 -0400
Received: by fg-out-1718.google.com with SMTP id e12so365238fga.17
        for <linux-omap@vger.kernel.org>; Sun, 12 Jul 2009 23:51:49 -0700 (PDT)
In-Reply-To: <20090713060354.GJ6589@nokia.com> (Felipe Balbi's message of "Mon\, 13 Jul 2009 09\:03\:54 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Tony Lindgren <tony@atomide.com>, Max Filippov <jcmvbkbc@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi <felipe.balbi@nokia.com> writes:

> Hi,
>
> On Mon, Jul 13, 2009 at 07:51:10AM +0200, ext Kalle Valo wrote:
>> Hello,
>> 
>> I started working on adding N8x0 support to mainline, currently serial
>> console works and I can mount initfs and rootfs on N800. The patches are
>> available here:
>> 
>> http://www.valot.fi/kalle/n8x0/patches/n8x0-add/
>
> I'd say at least patch #2 should be sent for to l-o right now since it
> gets rid of another OMAP_TAG.

I didn't implement omap1 part yet. As soon as I have done that, I'll
send it.

> All the other patches (besides #1) 

Yeah, patch #1 is some weird linker magic which I need to look at more.
The patch is in the set just to get things started and I'll remove it
from the final patchset.

> look fine and I guess you could send all of them here for people to
> take a look at.

Ok, I'll do that soon but I'll try to implement a bit more to the board
file first.

> But patch #2 clearly doesn't belong to that series and should be
> integrated

I agree. But isn't Tony on vacation the whole July and there is nobody
to push it to linux-omap?

Thanks for looking at the patches!

-- 
Kalle Valo
