From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap: usb: ehci: fix use of hcd->regs)
Date: Fri, 12 Sep 2008 15:18:08 -0700
Message-ID: <5e088bd90809121518m31b92088nfb2bb61effb6404a@mail.gmail.com>
References: <20080912121024.GG759@gandalf.research.nokia.com>
	 <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo>
	 <200809121216.27116.david-b@pacbell.net>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC4@dbde02.ent.ti.com>
	 <20080912203834.GI7132@frodo>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.190]:64210 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYILWSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 18:18:10 -0400
Received: by rn-out-0910.google.com with SMTP id k40so798455rnd.17
        for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 15:18:09 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC7@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Sep 12, 2008 at 2:06 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> From: Felipe Balbi [me@felipebalbi.com]
>> On Sat, Sep 13, 2008 at 01:31:12AM +0530, Gadiyar, Anand wrote:
>> > By the way, how do you propose to test this driver? Do you have the
>> > expansion board for the SDP, or some other hardware that can be used?
>>
>> I have one version of beagle with one ehci port ;-)
>>
>
> There were only two major versions of the board - and I don't think there are
> many of either version floating around. I'm not sure how many people have the
> earlier one and how many have the later. I don't think you'll need to support the
> older board.
>
> The beagle should do. I guess you have a Rev A. ISTR there were some issues
> with data transfers, but you should be able to get enumeration at least.

The Overo also has an EHCI port and should be available "Real Soon
Now".  Like the TI Beagle folks, we're working hard to get a good,
reliable EHCI implementation.  It turns out to be a rather difficult
task.

Steve
