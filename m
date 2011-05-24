From: Kevin Hilman <khilman@ti.com>
Subject: Re: context_loss_count error value
Date: Tue, 24 May 2011 16:45:43 -0700
Message-ID: <87lixv1x3s.fsf@ti.com>
References: <1305704452.1834.12.camel@deskari> <87k4douvsd.fsf@ti.com>
	<1305718422.1834.23.camel@deskari> <877h9ot7c3.fsf@ti.com>
	<1305729690.30372.7.camel@deskari> <1306252069.2194.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49005 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757375Ab1EXXps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 19:45:48 -0400
Received: by mail-pw0-f47.google.com with SMTP id 9so3455326pwj.20
        for <linux-omap@vger.kernel.org>; Tue, 24 May 2011 16:45:46 -0700 (PDT)
In-Reply-To: <1306252069.2194.28.camel@deskari> (Tomi Valkeinen's message of
	"Tue, 24 May 2011 18:47:49 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Wed, 2011-05-18 at 17:41 +0300, Tomi Valkeinen wrote:
>> On Wed, 2011-05-18 at 16:24 +0200, Kevin Hilman wrote:
>> 
>> > Looking closer at the code, a zero return happens only when
>> > 
>> > 1) no hwmod associated to omap_device
>> > 2) no power domain associated to hwmod
>> > 3) power domain has not (yet) lost context
>> > 
>> > None of these are actually error conditions per-se, and in all cases, it
>> > indidates that context has not been lost (or we can't tell if context
>> > has been lost.) 
>> 
>> If the pm code cannot tell whether the context has been lost or not, the
>> driver must assume it has been lost, do you agree? If so, the driver
>> must handle zero return value differently, and always restore context.
>> 
>> > So I think the current code is correct.
>> 
>> How is it correct if it returns an error even if no error has happened
>> =)? Either the code or the documentation is wrong.
>> 
>> How about the wrap-around case? Does the loss count go back to zero?
>
> Any conclusion on this?

Sorry for the lag... been travelling, and finally back home...

You're right, the code is just wrong here and would lead to strange
return value checking in the callers to be correct.

I think the best fix for this problem is to use a signed return value
which can wrap as expected, and then use return negative error codes
(e.g. -ENODEV).

Care to send a patch?  or do you have any other suggestions for a fix?

Thanks,

Kevin
