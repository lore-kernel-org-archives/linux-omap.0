From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Fri, 14 May 2010 13:11:43 +0300
Message-ID: <AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	 <20100505150209.GC2606@n2100.arm.linux.org.uk>
	 <20100513174023.GB13001@n2100.arm.linux.org.uk>
	 <20100513211951.GH3428@atomide.com>
	 <20100513215825.GC13001@n2100.arm.linux.org.uk>
	 <20100513220139.GO3428@atomide.com>
	 <20100513221229.GD13001@n2100.arm.linux.org.uk>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:40845 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab0ENKLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 06:11:45 -0400
Received: by yxe29 with SMTP id 29so863634yxe.4
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 03:11:44 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Fri, May 14, 2010 at 10:24 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> On Thu, May 13, 2010 at 03:01:39PM -0700, Tony Lindgren wrote:
>> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 14:53]=
:
>> > > On Thu, May 13, 2010 at 02:19:51PM -0700, Tony Lindgren wrote:
>> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 10=
:35]:
>> > > > > And here's a patch which converts the OMAP FB code to use lm=
b_reserve
>> > > > > instead of poking about with bootmem stuff. =A0Untested, so =
I'd like to
>> > > > > hear back whether it works.
>> > > >
>> > > > Did a quick test with the following patches picked from your l=
mb
>> > > > branch on top of omap for-next branch:
>> > > >
>> > > > ARM: Remove useless linux/bootmem.h includes
>> > > > ARM: Ensure meminfo is sorted prior to sanity_check_meminfo
>> > > > ARM: initial LMB trial
>> > > > ARM: Move platform LMB memory reservations out of generic code
>> > > >
>> > > > and then this patch.
>> > > >
>> > > > It does not boot.. It seems to be related to the patch
>> > > > "ARM: initial LMB trial". If I only apply the first two patche=
s
>> > > > above the system boots.
>> > >
>> > > Hmm, I'm sure it worked for me when I tested it out. =A0Could yo=
u try
>> > > booting with lmb=3Ddebug please?
>> >
>> > No other output with that it seems.
>>
>> Hang on, you didn't pick up ARM: Move memory mapping into mmu.c ?
>
> I just gave a try on OMAP3430 and it does boot for me. But fb doesn't
> seems to be working. I have tried this on Tony's "omap-testing"
> branch where the LMB support is pulled in
>
> *********************************************************
> omapfb omapfb: failed to allocate framebuffer
> omapfb omapfb: failed to allocate fbmem
> omapfb omapfb: failed to setup omapfb
> omapfb: probe of omapfb failed with error -12
> twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:
> ***********************************************************

It seems you are using DSS2/CONFIG_FB_OMAP2, looks like this patch is
for DSS1/CONFIG_FB_OMAP.

DSS2 does have a problem on linux-next after 'ARM: Prohibit ioremap()
on kernel managed RAM' because it also uses reserve_bootmem() in
drivers/video/omap2/vram.c and later ioremap on RAM. Perhaps LMB can
be used to fix that too?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
