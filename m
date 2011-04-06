From: Kevin Hilman <khilman@ti.com>
Subject: Re: What is missing from musb - linux-omap merge?
Date: Wed, 06 Apr 2011 07:59:41 -0700
Message-ID: <8762qrjuhu.fsf@ti.com>
References: <20110406162334.8dcb5a7d.jhnikula@gmail.com>
	<20110406133439.GH25654@legolas.emea.dhcp.ti.com>
	<20110406175138.eb700a7e.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:47372 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756151Ab1DFO7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 10:59:45 -0400
Received: by mail-iw0-f173.google.com with SMTP id 42so1845410iwl.4
        for <linux-omap@vger.kernel.org>; Wed, 06 Apr 2011 07:59:44 -0700 (PDT)
In-Reply-To: <20110406175138.eb700a7e.jhnikula@gmail.com> (Jarkko Nikula's
	message of "Wed, 6 Apr 2011 17:51:38 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: balbi@ti.com, OMAP Linux discussion <linux-omap@vger.kernel.org>, Hema HK <hemahk@ti.com>

Jarkko Nikula <jhnikula@gmail.com> writes:

> On Wed, 6 Apr 2011 16:34:40 +0300
> Felipe Balbi <balbi@ti.com> wrote:
>
>> Hi,
>> 
>> On Wed, Apr 06, 2011 at 04:23:34PM +0300, Jarkko Nikula wrote:
>> > Hi
>> > 
>> > I've been trying to hunt why the OMAP3 retention on Nokia N900 went
>> > broken in 2.6.39-rc and reason is somewhere around musb code merge with
>> > linux-omap code or vise versa.
>> > 
>> > I bisected this into:
>> 
>> I guess it's the missing Hema's patch which should be queued already.
>> Here it is:
>> 
>> commit 84cebd52a4b5d590af476869dc5b786fe567c095
>> Author: Hema HK <hemahk@ti.com>
>> Date:   Thu Mar 17 16:11:58 2011 +0530
>> 
>>     usb: musb: Fix for merge issue
>>     
> Yeah, that was missing from the commits I was testing but it was in
> where I started bisecting and where I noticed the retention issue so
> this don't fix it.
>
>> you might also need the one below:
>> 
>> commit ee262c660a855864efa78181cf7b7095b6416098
>> Author: Hema HK <hemahk@ti.com>
>> Date:   Tue Mar 22 16:02:12 2011 +0530
>> 
>>     usb: musb: Fix the crash issue during reboot
>>     
> Applies fine to 2.6.39-rc2 but still doesn't fix the retention issue.

Without actually trying this myself, what is likely affecting retention
is probably a missing (or failed) reset of the MUSB module.

Retention was also broken on several platforms before the MUSB cleanup &
hwmod conversion because the reset happens during hwmod init.  Because
most bootloaders are using MUSB, they often leave it in a state that
prevents idle (and thus retention), so a hwmod reset is the most
reliable way go get the IP into a known state.

Kevin

