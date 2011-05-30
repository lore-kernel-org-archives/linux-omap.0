From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: boot hang using OMAP for-next + Russell's for-linus
Date: Mon, 30 May 2011 18:58:36 +0530
Message-ID: <4DE39B84.40003@ti.com>
References: <87d3j3x28x.fsf@ti.com> <20110530080533.GF11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:44639 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756729Ab1E3N2n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 09:28:43 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so1885307gxk.33
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 06:28:42 -0700 (PDT)
In-Reply-To: <20110530080533.GF11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Tony,

On 5/30/2011 1:35 PM, Tony Lindgren wrote:
> * Kevin Hilman<khilman@ti.com>  [110527 14:24]:
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
>
I noticed couple of issues with v3.0-rc1 as reported [1]
on OMAP4430 SDP. Am I missing any trick for the console issue.

Regards
Santosh
[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50126.html

