From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Wed, 19 Jan 2011 22:37:42 +0100
Message-ID: <AANLkTikCoqPFhWwVS4BMvnjy8RZTOkPHCeN8Cqif2V17@mail.gmail.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
	<20110114155806.GA22505@n2100.arm.linux.org.uk>
	<AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
	<20110114173400.GB22505@n2100.arm.linux.org.uk>
	<AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
	<AANLkTinJPyXKWwbyW05+HUW0LJUxsu=1Exbrr6ut27Kr@mail.gmail.com>
	<AANLkTikPm8_vxjF7P84q7kHq+XSvLyF+jToFt=COs8Mj@mail.gmail.com>
	<20110118234215.GB17398@n2100.arm.linux.org.uk>
	<20110118234443.GV4957@atomide.com>
	<AANLkTin=XwKC5LvXimCfkNatLcq=RYqb-32x5HLx0rOa@mail.gmail.com>
	<20110119191057.GC4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55862 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab1ASVhp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 16:37:45 -0500
Received: by qwa26 with SMTP id 26so1315878qwa.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 13:37:44 -0800 (PST)
In-Reply-To: <20110119191057.GC4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi Tony,

On Wed, Jan 19, 2011 at 8:10 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Jean Pihet <jean.pihet@newoldbits.com> [110119 00:05]:
>> On Wed, Jan 19, 2011 at 12:44 AM, Tony Lindgren <tony@atomide.com> w=
rote:
>> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110118 15:41]=
:
>> >> On Tue, Jan 18, 2011 at 01:05:49PM +0100, Jean Pihet wrote:
>> >> > Dave, Russell,
>> >> >
>> >> > On Mon, Jan 17, 2011 at 4:46 PM, Dave Martin <dave.martin@linar=
o.org> wrote:
>> >> > > One way to work around this is would be to make omap_sram_pus=
h() a macro:
>> >> > >
>> >> > > #define omap_sram_push(funcp, size) \
>> >> > > =A0 =A0(typeof(funcp))_do_omap_sram_push((void *)(funcp), siz=
e)
>> >> > >
>> >> > > ... where the definition of _do_omap_sram_push() is the same =
is the
>> >> > > existing definition of omap_sram_push(). =A0Providing
>> >> > > _do_omap_sram_push() is not called directly, this should now =
be
>> >> > > type-safe.
>> >> > >
>> >> > Ok I reworked the patch from your suggestions. Indeed a few fun=
ctions
>> >> > types mismatch have been spotted and corrected using the fncpy =
API.
>> >> >
>> >> > New patch sent as '[PATCH v2] OMAP: use fncpy to copy the PM co=
de
>> >> > functions to SRAM'.
>> >>
>> >> Looks good, thanks. =A0Next problem to sort out is who's taking t=
he
>> >> patches...
>> >
>> > You can take them but we should have at least Kevin test and ack t=
hem.
>> Sure, this needs some testing on OMAP1 & 2 platforms. It has only be=
en
>> compile tested on those (means: compile OK, functions types mismatch=
es
>> fixed).
>>
>> Anyone with OMAP1 & 2 boards willing to test?
>
> Can you please repost the whole set one more time or have them in
> some git branch? That way I can pull them into linux-omap master
> branch for testing to make sure omap1 and 2 boards don't break.
There is only patch to apply: '[PATCH v2] OMAP: use fncpy to copy the
PM code functions to SRAM'
(http://marc.info/?l=3Dlinux-omap&m=3D129535214414192&w=3D2) which depe=
nds
on Dave Martin's ([PATCH v4] ARM: Thumb-2: Symbol manipulation macros
for function body copying'
(http://marc.info/?l=3Dlinux-omap&m=3D129503990527072&w=3D2).

Is this enough? If not I can have them in a branch of a gitorious tree.

>
> Tony
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
