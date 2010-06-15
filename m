From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 15 Jun 2010 11:04:49 +0300 (EEST)
Message-ID: <20100615.110449.27786947.Hiroshi.DOYU@nokia.com>
References: <AANLkTinixlUAjtwFZmGIkio4H0Gzy1Moww2ssoLBKQWr@mail.gmail.com>
	<20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
	<AANLkTikNX09s4xflcOax3Ry3o5XgJZF0JbbZXSGeKryR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20010 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab0FOIFL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 04:05:11 -0400
In-Reply-To: <AANLkTikNX09s4xflcOax3Ry3o5XgJZF0JbbZXSGeKryR@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com
Cc: fernando.lugo@ti.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org, rene.sapiens@ti.com

Hi Ohad,

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 15 Jun 2010 06:43:21 +0200

> Hi Hiroshi,
> 
> On Mon, Jun 14, 2010 at 3:58 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> Does dspbridge really need its own defered work for sending mailbox
>> messages?
> 
> We do, according to
> 
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/38240

I am wondering that this defered work may not be necessary just for
the serialization.

> (thanks Rene for the explanation).
> 
>> For recieving, its defered work(tasklet) can be trigered directly in
>> the above proposed callback, that callback can triger its own
>> workqueue if necessary, then.
> 
> Agree
> 
>> I think that, for recieving, some PM
>> command may has to be sent back immedieately inside of
>> tasklet. omap_mbox_msg_send_sync() may handle this case.
> 
> Not sure how much QoS is an issue with mailbox (do we really have
> latency issues ?), but I guess adding such interface can't hurt.

This solves the one case of lockdep issue.

>> I think that workqueue is only necessary when it has to sleep,
>> otherwise tasklet is prefered.
> 
> I must say I disagree; tasklets are really not friendly to the whole
> system's responsiveness and should be used only if really needed
> (there was even an attempt to remove them entirely in the past:
> http://lwn.net/Articles/239633/).

Evoking a workqueue may be overkilling just for putting several bytes
into registers since large part of contents is usually passed through
shared memory.

>> I'd like to allow mutiple listners in some way, as the flexibility of
>> mailbox functionalty.
> 
> This can be achieved using notifier chains of multiple listeners
> callback, but I agree with Felipe: do we really want this
> functionality ? I just rather not add code that no one is going to
> use.
> 
> What do you say we start with enforcing only 1 listener and later, if
> the use case of several listeners shows up, we'd add that support
> (promise! :) ?

Fair enough.
