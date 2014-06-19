From: Daniel Mack <daniel@zonque.org>
Subject: Re: Gadget regression with enabling of MUSB babble interrupt handling
Date: Thu, 19 Jun 2014 12:36:36 +0200
Message-ID: <53A2BD34.1060409@zonque.org>
References: <20140619095655.GA29055@atomide.com> <53A2B6B0.2040804@zonque.org> <20140619103100.GB29055@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:51535 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757117AbaFSKgi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jun 2014 06:36:38 -0400
In-Reply-To: <20140619103100.GB29055@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, george.cherian@ti.com

Hi Tony,

On 06/19/2014 12:31 PM, Tony Lindgren wrote:
> * Daniel Mack <daniel@zonque.org> [140619 03:10]:
>> On 06/19/2014 11:56 AM, Tony Lindgren wrote:
>>> Looks like commit ca88fc2ef0d7 (usb: musb: add a work_struct
>>> to recover from babble errors) causes MUSB gadgets to stop
>>> enumerating at least on omap3. Reverting the the commit fixes
>>> the issue.
>>
>> Hmm, so do you see babble errors occuring?
> 
> Not that I noticed of.
>  
>> Also, there are some more patches for musb and babble error recovery on
>> the usb list, namely the ones starting here in v6:
>>
>>   http://marc.info/?l=linux-usb&m=140109627505065&w=4
>>
>> Care to give them a try?
> 
> I can confirm that "[PATCH v6 1/5] usb: musb: core: Handle Babble
> condition only in HOST mode" fixes the issue for me. Also the
> explanation in the patch description explains why it breaks, and
> probably for all gadgets too because "BABBLE and RESET share the
> same interrupt" so it's RESET in peripheral mode.

Ok, thanks for testing. I was told Felipe was out for some weeks, so I
don't know when these patches will be reviewed and merged.

> But that also raises a question: Were these patches merged for
> v3.16 ever even tested in peripheral mode?

At the time, I had no such hardware to test this on, so I was hoping for
more testers to give them a try in different environments, which
apparently didn't happen. It fixed a dead USB port condition on
host-mode enabled hardware, though.

We should make sure at least patch 1/5 from the series mentioned above
makes it to 3.16.


Thanks,
Daniel
