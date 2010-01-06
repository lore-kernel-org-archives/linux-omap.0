From: Francisco Alecrim <alecrim@gmail.com>
Subject: Re: problem with n810 boot up
Date: Tue, 05 Jan 2010 22:46:27 -0400
Message-ID: <4B43F983.5050200@gmail.com>
References: <200912290152.16357.luke@dashjr.org> <4B43CA48.3070009@gmail.com> <201001051747.02221.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:33082 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab0AFCqn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 21:46:43 -0500
Received: by yxe26 with SMTP id 26so16288764yxe.4
        for <linux-omap@vger.kernel.org>; Tue, 05 Jan 2010 18:46:42 -0800 (PST)
In-Reply-To: <201001051747.02221.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

Hi Luke,

Luke-Jr wrote:
> On Tuesday 05 January 2010 05:24:56 pm Francisco Alecrim wrote:
>> Luke-Jr wrote:
>>> Tested on Nokia N810 in Linux-OMAP tree. Mainline is not bootable yet.
>> I'm with some problems to boot-up latest l-o(commit
>> abb74381235a05f15a3b07e9e3831034942c67fb) with n810. The error message
>> can be found below and full boot output in the end of email.
>>
>> dsme: No correct bootreason found, entering the malfunction state
> 
> That's DSME, part of Maemo userland. You can possibly write a LD_PRELOAD 
> workaround if you want to run it anyway...

I tried but it doesn't work. I included a line to print the
/proc/bootreason value and there is no bootreason. :P

cat: /proc/bootreason: No such file or directory

I guess that's the problem.

> 
>> What rootfs do you use? Did you change initfs?
> 
> Gentoo. I modified my initfs to chainload its init if a new kernel is running.

I don't know how to do it. Could you send me yours?
> 
> Unfortunately, I have come to the realisation that moving forward with the 
> Linux port to N8x0 would take me more time than simply spending the same time 
> doing paid work and buying a N900* or Pandora instead. So short some other 
> reimbursement for porting Linux to N8x0 (like maybe a promise of BME sources 
> or a N900 after the rest is done to finish the job), I'm probably not going to 
> spend any more time on it. :(

Maybe, you're right. Or they can produce something using a SoC cheaper
than OMAP3.

> 
> Luke
> 
> * N900 is supposedly mostly mainlined already, and supposedly Nokia will 
> actually finish the job with unlike N8x0; it also has nicer hardware, even if 
> you just ignore the cellular capabilities

Thank you! :)
Alecrim
