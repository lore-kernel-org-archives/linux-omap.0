From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Can't mount proc filesystem
Date: Sun, 23 Aug 2009 13:01:05 -0600
Message-ID: <4A9191F1.9000009@mlbassoc.com>
References: <d9ca78710908231126n5082c0e6tc86acd9448f5e2c9@mail.gmail.com>	 <4A918B79.5030607@mlbassoc.com>	 <d9ca78710908231137uf28715bm9fb41cf4a6266fce@mail.gmail.com>	 <4A918D07.4020506@mlbassoc.com> <d9ca78710908231141j654eb5d8td462e6a0ef8bd63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:5886 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063AbZHWTBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 15:01:17 -0400
In-Reply-To: <d9ca78710908231141j654eb5d8td462e6a0ef8bd63@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Tar Gz wrote:
> hemmm you're right...
> 
> if i want to run bash, i must declare bash shell in the /etc/inittab ?
> 

No, you'd have to build 'bash' and include it in your file system.

What's wrong with the busybox shell?  What are you trying to do that it can't?

> On 8/23/09, Gary Thomas <gary@mlbassoc.com> wrote:
>> Tar Gz wrote:
>>> because my kernel booting and enter the busybox manually
>>>
>>> how to enter to shell like bash?
>> The busybox shell is already running.  It's more like 'sh' than 'bash'
>>
>> What do you want to do that you don't think you can??
>>
>>> On 8/23/09, Gary Thomas <gary@mlbassoc.com> wrote:
>>>> Tar Gz wrote:
>>>>> hi all
>>>>>
>>>>> i try to develop linux 2.6.26 kernel with omap patch but when i'm
>>>>> booting, i'm enter busybox and running /etc/init.d/rcS
>>>>>
>>>>> but failed to mount proc filesystem...i have enabled kernel /rpoc
>>>>> filesystems support but it's still can't mounting..any idea?
>>>> You should not be running /etc/init.d/rcS manually.  The log
>>>> you sent previously shows it has already run.
>>>>
>>>> What makes you think that /proc wasn't mounted?
>>>> Why are you running /etc/init.d/rcS by hand?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
