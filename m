From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Upstream linux-omap kernel on Nokia N900?
Date: Mon, 19 Apr 2010 15:00:43 +0300
Message-ID: <20100419115855.GG3544@nokia.com>
References: <87iq7nslvo.fsf@small.ssi.corp>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16521 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0DSMBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 08:01:11 -0400
Content-Disposition: inline
In-Reply-To: <87iq7nslvo.fsf@small.ssi.corp>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arnaud Ebalard <arno@natisbad.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Leukkunen Lauri (Nokia-D/Helsinki)" <lauri.leukkunen@nokia.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>

Hi,

On Mon, Apr 19, 2010 at 01:49:15PM +0200, ext Arnaud Ebalard wrote:
>Nokia N900 is shipped to users with a 2.6.28 omap kernel. Many patches
>for the hardware and various features have been pushed upstream by Nokia
>developers and possibly others. Those are now available in current l-o
>tree.
>
>Nonetheless, many drivers and various features are still missing
>upstream. Simply put, one cannot expect to run a current l-o kernel on
>the device (and expect to get a GUI and/or make call with the device).

tell me about it :-p

Thing is that it doesn't really depend only on Nokia to get those parts 
done. Well, we can get the kernel part done by just cleaning up and 
porting the 2.6.28 drivers to current mainline, but in case of e.g. SGX 
we still miss the xorg driver and I don't think that'll be released any 
time soon.

Another problem is that the bootloader believes it can pass all the 
obsoleted OMAP TAGs to kernel and the 2.6.28 kernel depends on those, 
maybe that can be worked around. I don't know whether kernel simply 
drops invalid TAGs or not...

Good work anyways... At least it's now documented ;-)

PS:

BTW, CBUS isn't really necessary for n900 and I have almost 40 patches 
cleaning that up pending in this mailing list :-p

-- 
balbi
