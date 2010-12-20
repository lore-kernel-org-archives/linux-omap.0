From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: Re: Is changing serial from /dev/ttySx to /dev/ttyOx a good idea?
Date: Sun, 19 Dec 2010 22:28:48 -0600
Message-ID: <AANLkTimcAs0X6B9j9DpbAg1K7aAT7JAyXoOyRZYCeNHG@mail.gmail.com>
References: <201012201546.12319.manningc2@actrix.gen.nz>
	<AANLkTi=P58XerK8jdyvfT9JS6tU3U11tYP=KH4_B-cn=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:56431 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0LTE2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Dec 2010 23:28:50 -0500
Received: by fxm18 with SMTP id 18so2607416fxm.2
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 20:28:49 -0800 (PST)
In-Reply-To: <AANLkTi=P58XerK8jdyvfT9JS6tU3U11tYP=KH4_B-cn=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Charles Manning <manningc2@actrix.gen.nz>, linux-omap@vger.kernel.org

Hi,

On Sun, Dec 19, 2010 at 9:04 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi,
>
> 2010/12/20 Charles Manning <manningc2@actrix.gen.nz>:
>> Hi All
>>
>> With the change to the new omap-serial stuff, the device names have changed
>> from /dev/ttySn to /dev/ttyOn.
>>
>> Using the "fit/form/function" argument, this would seem to be a bad idea.
>>
>> The kernel does not exist in a vacuum. It is surrounded by u-boot scripts,
>> command line options, init scripts etc etc. Flipping back and forth between
>> 2.6.36 and 2.6.37 kernels for testing purposes needs these to be changed.
>> Annoying and anti-productive.
>>
>> Isn't it just better to just replace the ttyOn name with ttyS. That would make
>> a far smoother transition.
>>
>> Thoughts?
>
> In fact, the transition is not friendly indeed for a user. I don't know why
> the transition is introduced, for what purpose? Who can give a explanation?
>

Patch itself has one explanation, kernel commit is
b612633b5928077441b979471869753bfa93d41a

http://www.spinics.net/lists/linux-serial/msg02788.html

Best Regards
Abraham
