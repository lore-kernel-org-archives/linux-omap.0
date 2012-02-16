From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 6/6] arm: omap: pm-debug: enhanced usecount debug support
Date: Thu, 16 Feb 2012 11:06:38 -0600
Message-ID: <CAOMWX4cg4mfBQGcHLodjFaVY0vVGnKJKvsa9ngMLO-0Ca7gBTQ@mail.gmail.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
 <1329237402-26008-7-git-send-email-t-kristo@ti.com> <20120214202740.GT1426@atomide.com>
 <87fwed58dm.fsf@ti.com> <20120214235218.GX1426@atomide.com>
 <1329294866.4102.343.camel@sokoban> <874nus5djf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41124 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877Ab2BPRHB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 12:07:01 -0500
Received: by werh12 with SMTP id h12so1813863wer.4
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 09:06:58 -0800 (PST)
In-Reply-To: <874nus5djf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: t-kristo@ti.com, Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 15, 2012 at 09:20, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> On Tue, 2012-02-14 at 15:52 -0800, Tony Lindgren wrote:
>>> * Kevin Hilman <khilman@ti.com> [120214 14:28]:
>>> > Tony Lindgren <tony@atomide.com> writes:
>>> >
>>> > > * Tero Kristo <t-kristo@ti.com> [120214 08:19]:
>>> > >> Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
>>> > >> their own file, 'usecount'. This file shows the usecounts for every
>>> > >> active domain and their children recursively. 'count' file now only
>>> > >> shows power state counts for powerdomains.
>>> > >>
>>> > >> This patch also provices a way to do printk dumps from kernel code,
>>> > >> by calling the pm_dbg_dump_X functions. The plan is to call these
>>> > >> functions once an error condition is detected, e.g. failed suspend.
>>> > >
>>> > > Why don't you replace this all with a userspace tool that deciphers
>>> > > the registers for you?
>>> >
>>> > This patch isn't deciphering registers, it's just dumping usecounts, and
>>> > I think that is extremely useful to have in debugfs.
>>> >
>>> > I've already removed all the register dumping from the kernel in the
>>> > hopes that someone will write a userspace tool for that.
>>>
>>> OK good to hear you're already considering it.
>>
>> Yes, register dumps are gone, and I am actually one of the persons who
>> is missing it.
>>
>> I think there should still be some capability to get register snapshots
>> from certain points during kernel execution, this is useful for
>> debugging purposes. I don't know if it would be possible to do a
>> call_usermodehelper() or something from kernel space just before wfi to
>> read all (or part of) the PRCM registers, store them somewhere, and then
>> decipher this data later with another tool. Any comments to this?
>
> You should look into the omapconf tool (TI internal only currently)
>
> This tool already has the ability to use /dev/mem to read/decipher OMAP
> PM related registers.
>
> IMO, the one thing we're still missing is the ability to take register
> snapshots (like immediately before and after WFI) and somehow feed those
> to omapconf for deciphering.
>
Something like this perhaps?
https://github.com/nmenon/linux-omap-ti-pm/commit/3cd1994fc0df9a8e3e0be74ec3f3add3ff3aef95

Regards,
Nishanth Menon
