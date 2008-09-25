From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Thu, 25 Sep 2008 10:34:15 -0700
Message-ID: <5e088bd90809251034h4de27054tfa00182814791645@mail.gmail.com>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
	 <01BA5FDD-AC4E-4450-B576-8A7DA867E314@student.utwente.nl>
	 <dfeb90390809250638r22474563q1262209d15974cb9@mail.gmail.com>
	 <200809251022.08544.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60587 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124AbYIYReQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 13:34:16 -0400
Received: by gxk9 with SMTP id 9so7343367gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 10:34:15 -0700 (PDT)
In-Reply-To: <200809251022.08544.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Arun KS <getarunks@gmail.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Thu, Sep 25, 2008 at 10:22 AM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 25 September 2008, Arun KS wrote:
>> >>> I narrowed this into CONFIG_SLUB. When it's set, I can reproduce the
>> >>> bug both with N810 and Beagle but not when using CONFIG_SLAB.
>
> So it's confirmed that SLUB is a factor, but
> the root cause is still not known or resolved?

Correct.  I suspect that somewhere in alsa-lib code is not checking an
error return on a memory allocation.  When I previously discussed this
issue with the folks on alsa-devel they suspected a bug in alsa-lib.
I'll give them this additional data and see if someone there wants to
help track down the root cause.

Steve
