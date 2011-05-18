From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 02/11] OMAP3+: PM: voltage: add required
 debugfs interfaces
Date: Wed, 18 May 2011 03:41:46 -0500
Message-ID: <BANLkTimEGxmjHPGprfFp=updA6bXOT_Cbw@mail.gmail.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com> <1305695854-9638-3-git-send-email-nm@ti.com>
 <20110518075948.GD6815@atomide.com> <BANLkTinH8Rs8Tn8A8gf++UuM2zAxd1e54Q@mail.gmail.com>
 <20110518083434.GE6815@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50971 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754565Ab1ERImH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 04:42:07 -0400
Received: by mail-ww0-f54.google.com with SMTP id 20so1369261wwd.11
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 01:42:06 -0700 (PDT)
In-Reply-To: <20110518083434.GE6815@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kevin <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, May 18, 2011 at 03:34, Tony Lindgren <tony@atomide.com> wrote:
> * Menon, Nishanth <nm@ti.com> [110518 11:03]:
>> On Wed, May 18, 2011 at 02:59, Tony Lindgren <tony@atomide.com> wrot=
e:
>> > * Nishanth Menon <nm@ti.com> [110518 08:13]:
>> >> Kevin's patch:
>> >> OMAP3+: voltage: remove unneeded debugfs interface
>> >>
>> >> removed ability to check the voltages in the domains.
>> >> This puts a crunch on validation we can do, hence we
>> >> re-introduce them back in
>> >
>> >> Signed-off-by: Nishanth Menon <nm@ti.com>
>> >> ---
>> >> =A0arch/arm/mach-omap2/voltage.c | =A0 66 +++++++++++++++++++++++=
++++++++++++++++++
>> >> =A0arch/arm/mach-omap2/voltage.h | =A0 =A01 +
>> >> =A02 files changed, 67 insertions(+), 0 deletions(-)
>> >
>> > Hmm, this seems to be adding the debug code instead?
>>
>> Yes, we need some interface to know what the current voltages are fo=
r
>> each of the domain when verifying if dvfs is actually scaling voltag=
e
>> or not. the other option is to use omapconf (not yet public and only
>> supports OMAP4) to see what the voltages are. Though omapconf is an
>> option, it shows what it's computation of voltage from vsel is, not
>> what the kernel internally thinks (vsel_uv functions) it is.
>
> I guess I just got confused reading the patch description..

sorry - will fix it up for v3 after waiting for further comments - and
if Sanjeev is ok, will wrap it up under #ifdefs for DEBUG_FS as well
to prevent !DEBUGFS builds..

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
