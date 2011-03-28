From: Kevin Hilman <khilman@ti.com>
Subject: Re: Smartreflex on 'pm-wip/voltdm' Branch
Date: Mon, 28 Mar 2011 09:27:05 -0700
Message-ID: <874o6nky7a.fsf@ti.com>
References: <AANLkTi=czLooLOFEZq-TYKLOqwFxn8eB6aTs7-3k_YSY@mail.gmail.com>
	<e3b58bb0f126f8849c7358c8f7e67222@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49813 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755080Ab1C1Q1K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 12:27:10 -0400
Received: by gyf1 with SMTP id 1so1475827gyf.34
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 09:27:08 -0700 (PDT)
In-Reply-To: <e3b58bb0f126f8849c7358c8f7e67222@mail.gmail.com> (Vishwanath
	Sripathy's message of "Mon, 28 Mar 2011 19:10:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org

Vishwa, Shweta,

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

>> I am testing Smartreflex on your Branch 'pm-wip/voltdm'. There seems
>> an issue with reading VP registers.
>> For OMAP3 and OMAP4 reading debugfs entries shows constant voltage.

Thanks for testing.

[...]

> I did a quick debug on this and found that the root cause of the issue is
> in usage of ffs (because of this, i2c slave address was configured wrongly
> in vc).
> Basically ffs returns the position of the first (least significant) bit
> set in the word and the least significant bit is position 1 where as our
> bit operation assumes that least significant position is 0.

Vishwa, Thanks for findingg this.  Indeed, I had assumed ffs() was zero based,
but it is 1 based.  

> I tested the attached patch on OMAP3 and it seems to work fine.

> Kevin,
> You may want to incorporate this change in your next version if this seems
> OK to you.

Yes, I will fix this in forthcoming versions.

Thanks,

Kevin
