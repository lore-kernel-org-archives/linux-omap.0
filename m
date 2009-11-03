From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Restart after 4 min of operation?
Date: Tue, 03 Nov 2009 11:47:38 -0600
Message-ID: <4AF06CBA.3040609@billgatliff.com>
References: <4AEFA4EE.40308@billgatliff.com> <4AF01901.2050100@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:36303 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZKCRrf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 12:47:35 -0500
Received: by yxe17 with SMTP id 17so5620835yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 03 Nov 2009 09:47:40 -0800 (PST)
In-Reply-To: <4AF01901.2050100@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>, linux-omap@vger.kernel.org

Gary Thomas wrote:
> On 11/02/2009 08:35 PM, Bill Gatliff wrote:
>> Guys:
>>
>>
>> Can someone give me any ideas as to why my Beagleboard-like platform
>> would spontaneously restart after precisely four minutes of operation?
>> No OOPS, no nothing.  This is with 2.6.32-rc5.
>>
>
> BeagleBoard like?  More details are probably required for much help.
>
> How do you power it?  My BeagleBoard is powered via the OTG.  I've
> seen it reset if I hang too much on the USB host port (exceed the
> meager power budget)

It's a clone of a BeagleBoard, but with more and friendlier I/O.  CUS
package, and they use the TPS65023RSB power supply manager.  I'm not
ready to bury anyone in more details yet, since it's a client's hardware
and I feel like I'm imposing already...  :)

When I boot it to my kernel, which is based on 2.6.32-rc5, it comes up
fine and then for no apparent reason after four minutes goes through a
reset again.  I know it's approximately the same each time, because I
have uptime running in a loop so that I can conveniently see when it
dies.  The very same tree boots and runs properly on a true BeagleBoard
rev C.

What's even more wierd is that even when sitting at the u-boot prompt
before launching any kernel at all, the board does the same thing---
spontaneous reset after about four minutes.  The client provided me the
u-boot image, and it says it's a modified one from the OMAP3EVM--- it
even provides that machine id. 

The above behavior makes me suspect hardware, but read on before you agree.

Finally, the client provided me a kernel of unknown origin (it says it's
a 2.6.29-rc2) that appears to run fine---- no hiccup at 4 minutes.  Of
course, that kernel doesn't have the features they need.  I'm going over
it now to see if there's a magic bit somewhere that mine is missing, but
I'm at a bit of a loss to explain what I'm seeing right now.

Anyone have any ideas?  Bizzare.


(BTW, nice to hear from you again, Gary!  It's been a while.)


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

