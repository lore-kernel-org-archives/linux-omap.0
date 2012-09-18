From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: How to disable message "Uncompressing linux..." on kernel start?
Date: Tue, 18 Sep 2012 17:23:52 +0530
Message-ID: <CAJe_ZhcEvW+M3OwvwDtH62pEDbaUwbZoy0ewpmYEUabu_3VfEA@mail.gmail.com>
References: <CAJe_ZhcnBnNhTkV1VXmh3kvkOo-NuYj6pNoxo0zN1TSKFnYmnw@mail.gmail.com>
	<5448984682E7954C9BFF27F747A9C6CA56E31C@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33693 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab2IRLxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 07:53:52 -0400
Received: by vcbfo13 with SMTP id fo13so7372778vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Sep 2012 04:53:52 -0700 (PDT)
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E31C@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: linux-omap@vger.kernel.org

>> > On 18 September 2012 12:09, Maximilian Schwerin
>> > <Maximilian.Schwerin@tigris.de> wrote:
>> >> Hi all,
>> >>
>> >> I have been convinced that my patch for disabling the message
>> >> "Uncompressing linux..." on kernel start was not all that
>> good an idea.
>> >> As the problem still remains an issue for me and I'd like
>> to find a fix
>> >> for everyone I'd like to ask for pointers where or how to fix this.
>> >>
>> >> To sum up my problem: I'm using the primary serial port on
>> an OMAP3 as a
>> >> debug console for development. In production we set the
>> u-boot silent
>> >> option which disables all kernel logging to this serial
>> port. The only
>> >> kernel message that remains is "Uncompressing linux..." at the very
>> >> beginning. As we connect an external device via this port
>> in production
>> >> environments this is not acceptable.
>> >>
>> > Perhaps adding config choice under "Kernel low-level
>> debugging port",
>> > to select the UART port to direct the early prints to, would help.
>> > Like some platforms already do. See DEBUG_CLPS711X_UART1/2 ,
>> > DEBUG_MSM_UART1/2/3 etc.
>>
>> On a second thought, I think we need a new config independent
>> of DEBUG_LL.
>> Something like what Samsung code does with symbol
>> S3C_LOWLEVEL_UART_PORT in arch/arm/plat-samsung/Kconfig
>
> In my case I need to be able to disable it completely.
>
The idea is to direct the output to some other (unused) UART port.

Also if one doesn't select DEBUG_LL, I wonder if it makes sense to
expect the "Uncompressing .... " message, which too is just dumping
raw data onto UART. So another option might be to simply use
CONFIG_DEBUG_LL instead of CONFIG_DEBUG_DECOMPRESS_KERNEL ?
