From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: N8x0 to mainline patches
Date: Fri, 07 Aug 2009 10:44:06 +0300
Message-ID: <87prb8m5kp.fsf@litku.valot.fi>
References: <87zlb95dwx.fsf@litku.valot.fi> <20090713060354.GJ6589@nokia.com>
	<87vdlx5b3y.fsf@litku.valot.fi> <20090713065341.GC16778@nokia.com>
	<20090806071038.GE7374@atomide.com> <87y6pwnc9t.fsf@litku.valot.fi>
	<da94abde0908060927s57a5bdcfxac4e46db16913820@mail.gmail.com>
	<20090807070317.GR2358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:58700 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbZHGHoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 03:44:09 -0400
Received: by fxm28 with SMTP id 28so1176642fxm.17
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2009 00:44:09 -0700 (PDT)
In-Reply-To: <20090807070317.GR2358@atomide.com> (Tony Lindgren's message of "Fri\, 7 Aug 2009 10\:03\:20 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Max Filippov <jcmvbkbc@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren <tony@atomide.com> writes:

>> > 2. finins and send tusb6010 patch
>> >
>> > + omap2-add-usb-tusb6010-c
>
> The tusb6010 could be added later on as a fix too if you want to cut
> down dependencies.

Good point, I'll send that separately.

Current n8x0 patches are here:

http://www.valot.fi/kalle/n8x0/patches/n8x0-add/2009-08-06-19:21/

They are just pending final testing and I'll send them after I have done
that, hopefully tonight.

Tony, on which tree should I base the patches? They are now against
linus's tree.

-- 
Kalle Valo
