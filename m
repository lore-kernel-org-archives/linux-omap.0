From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH] arm: oprofile: remove locking from suspend/resume
Date: Wed, 19 May 2010 15:44:29 -0700
Message-ID: <8739xnjyuq.fsf@deeprootsystems.com>
References: <1274227981-20130-1-git-send-email-khilman@deeprootsystems.com>
	<20100519070459.GA22212@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38339 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab0ESWoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 18:44:34 -0400
Received: by vws9 with SMTP id 9so4277549vws.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 15:44:33 -0700 (PDT)
In-Reply-To: <20100519070459.GA22212@n2100.arm.linux.org.uk> (Russell King's message of "Wed\, 19 May 2010 08\:04\:59 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, May 18, 2010 at 05:13:01PM -0700, Kevin Hilman wrote:
>> Since oprofile is a sysdev, its suspend/resume methods are called with
>> interrupts disabled.  Using a mutex (which might sleep) in this atomic
>> context is not safe.
>
> It isn't a sysdev anymore.  Suggest you take a look at the ARM tree once
> in a while.

Indeed, I see it is fixed already there.

Sorry for the noise,

Kevin
