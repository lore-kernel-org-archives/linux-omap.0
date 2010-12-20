From: Abdoulaye Walsimou GAYE <awg@embtoolkit.org>
Subject: Re: Is changing serial from /dev/ttySx to /dev/ttyOx a good idea?
Date: Mon, 20 Dec 2010 08:20:51 +0100
Message-ID: <4D0F03D3.7040506@embtoolkit.org>
References: <201012201546.12319.manningc2@actrix.gen.nz> <AANLkTi=P58XerK8jdyvfT9JS6tU3U11tYP=KH4_B-cn=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from walscop001.walsimou.com ([82.228.201.70]:40574 "EHLO
	bekkor.walsimou.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab0LTHZW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 02:25:22 -0500
In-Reply-To: <AANLkTi=P58XerK8jdyvfT9JS6tU3U11tYP=KH4_B-cn=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Charles Manning <manningc2@actrix.gen.nz>, linux-omap@vger.kernel.org

On 12/20/2010 04:04 AM, Ming Lei wrote:
> Hi,
>
> 2010/12/20 Charles Manning<manningc2@actrix.gen.nz>:
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
> In fact, the transition is not friendly indeed for a user. I don't know why
> the transition is introduced, for what purpose? Who can give a explanation?
>
> thanks,

Hello,
And another question, why there is no entry in Documentation/devices.txt?
Regards,
AWG
