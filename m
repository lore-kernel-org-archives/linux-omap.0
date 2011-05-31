From: Kevin Hilman <khilman@ti.com>
Subject: Re: boot hang using OMAP for-next + Russell's for-linus
Date: Tue, 31 May 2011 09:13:44 -0700
Message-ID: <87ipsqsv9j.fsf@ti.com>
References: <87d3j3x28x.fsf@ti.com> <20110530080533.GF11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46029 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756998Ab1EaQNs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 12:13:48 -0400
Received: by mail-px0-f175.google.com with SMTP id 17so2716564pxi.20
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 09:13:47 -0700 (PDT)
In-Reply-To: <20110530080533.GF11352@atomide.com> (Tony Lindgren's message of
	"Mon, 30 May 2011 01:05:33 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110527 14:24]:
>> FYI... I just found this, but won't be able to look into it until next
>> week, so if anyone needs a weekend debug project...
>> 
>> Using Tony's for-next branch, I'm able to boot an omap2plus_defconfig (+
>> busybox initramfs) kernel on my 3430/n900 just fine.   I then tried to
>> merge in Russell's for-linus branch and it hangs during boot.
>> 
>> It appears to hang in the init/registration of i2c busses.  Commenting
>> out the i2c bus registration from board-rx51-peripherals and disabling a
>> few of the users of i2c, I was able to boot.
>
> Looks like at least v3.0-rc1 boots just fine, so whatever that was
> has been already fixed.

Indeed, rc1 is booting fine for me now.

Kevin
