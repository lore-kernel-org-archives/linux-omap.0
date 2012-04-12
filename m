From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 11:10:05 -0600
Message-ID: <4F870C6D.3030203@mlbassoc.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com> <4F859C5D.3090400@mlbassoc.com> <87hawqt6vt.fsf@ti.com> <4F86B227.90802@mlbassoc.com> <87aa2hjavi.fsf@ti.com> <4F86F4B2.3080101@mlbassoc.com> <87aa2ganwj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:52204 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578Ab2DLRKH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 13:10:07 -0400
In-Reply-To: <87aa2ganwj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

On 2012-04-12 10:57, Kevin Hilman wrote:
> +Felipe for EHCI question
>
> Gary Thomas<gary@mlbassoc.com>  writes:
>
> [...]
>
>> This worked a treat, thanks.  My network performance is better
>> now, but still not what it was.  The same TFTP transfer now takes
>> 71 seconds, so about 50% slower than on the 3.0 kernel.  Applying the
>> second [unnamed] patch (arch/arm/mach-omap2/cpuidle34xx.c) made no difference.
>
> And does a CONFIG_PM=n kernel get you back to your v3.0 performance?

Correct.

>
>> I am interested in having PM working as I'm designing a battery powered
>> portable unit, so I need to keep pursuing this.
>
> So do I. :)
>
>> Note: I noticed that when I built with CONFIG_PM off and no other
>> changes, my EHCI USB didn't work properly.  Should this be the case?
>
> Probably not, but haven't tested EHCI USB.  I've Cc'd Felipe to see if
> he has any ideas why EHCI wouldn't work with CONFIG_PM=n.

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
