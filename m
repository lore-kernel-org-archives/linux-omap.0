From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ANNOUNCE] updated PM branch, based on 2.6.32-rc1
Date: Fri, 09 Oct 2009 10:30:30 -0700
Message-ID: <87bpkgwk3t.fsf@deeprootsystems.com>
References: <87iqezdmas.fsf@deeprootsystems.com>
	<87eipgnmfh.fsf@deeprootsystems.com>
	<a46a26fd0910081509u426b0f9fraa24ea8c99a5717e@mail.gmail.com>
	<87ab014iun.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:54128 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316AbZJIRbL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 13:31:11 -0400
Received: by pxi9 with SMTP id 9so6910266pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 09 Oct 2009 10:30:33 -0700 (PDT)
In-Reply-To: <87ab014iun.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 08 Oct 2009 15\:32\:48 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Juha Kuikka <juha.kuikka@gmail.com> writes:
>
>> On Tue, Oct 6, 2009 at 4:16 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>>
>>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>>
>>> > Hello,
>>> >
>>> > I've rebased/updated the PM branch based on current linux-omap ma=
ster
>>> > branch (2.6.32-rc1 based.)
>>> >
>>> > I've also updated the OMAP Power Management wiki, and the 'Curren=
t
>>> > version' section highlights the changes, supported platforms as w=
ell
>>> > as the features that have made it into mainline.
>>> >
>>> > =A0 =A0 =A0http://elinux.org/OMAP_Power_Management#Current_versio=
n
>>> >
>>>
>>> FYI... I just rebased the PM branch onto current omap/master.
>>>
>>> Some important user-visible changes: The /sys/power/* options are
>>> moving into debugfs. =A0For mainline, these primarily debug options=
 need
>>> to move to debugfs so I've moved them there. =A0So, if you're missi=
ng
>>> some flag under /sys/power, it's now under /debug/pm_debug.
>>>
>>> I've updated the 'Using the PM branch' seciont of PM wiki[1] with
>>> the new filenames.
>>>
>>> Kevin
>>>
>>> [1] http://elinux.org/OMAP_Power_Management
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>
>> Hi,
>
> Hi Juha,
>
>> I build and tried this latest on Beagleboard (C2). Booting from MMC
>> using ramdisk image. I changed the LL console to the 3rd UART.
>>
>> The issue I have is that after the system boots up it works for as
>> long as I keep actively using it but if I leave it idle for a short
>> time (~5s) it stops responding. I have tried waking it up using both
>> UART and "USER" button on the board. This is with the default PM
>> configuration.
>
> Thanks for testing, and reporting your problem.  I have noticed
> exactly the same problem and am still investigating it.
>
>> If I put the board into suspend (retention) it wakes up without any =
issues.
>>
>> Also, if I enable "/debug/pm_debug/sleep_while_idle" board wakes up
>> without issues. Well the first couple characers on the console seem =
to
>> go missing but I guess without CTS/RTS that is expected?
>
> Yes, the loss of the first character is expected.
>
>> Any pointers would be appreciated.
>
> I also noticed that it works when 'sleep_while_idle' is enabled, and
> this has led me to suspect a bug in that serial timout path, but I
> have yet to debug further.

=46YI...

I haven't figured out exactly why yet, but this patch gets things
working again.

Basically, I'm just leaving smart-idle disabled all the time.

Kevin

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 492dd02..90a284c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -305,7 +305,7 @@ static void omap_uart_block_sleep(struct omap_uart_=
state *uart)
 {
 	omap_uart_enable_clocks(uart);
=20
-	omap_uart_smart_idle_enable(uart, 0);
+/* 	omap_uart_smart_idle_enable(uart, 0); */
 	uart->can_sleep =3D 0;
 	if (uart->timeout)
 		mod_timer(&uart->timer, jiffies + uart->timeout);
@@ -323,7 +323,7 @@ static void omap_uart_allow_sleep(struct omap_uart_=
state *uart)
 	if (!uart->clocked)
 		return;
=20
-	omap_uart_smart_idle_enable(uart, 1);
+/* 	omap_uart_smart_idle_enable(uart, 1); */
 	uart->can_sleep =3D 1;
 	del_timer(&uart->timer);
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
