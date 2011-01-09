From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH 0/3] OMAP4: DSS OMAP4 hwmod support
Date: Sun, 9 Jan 2011 14:19:46 +0530
Message-ID: <AANLkTi=A75kAw_=829CLPSPcd3=B6SxgQzrXEvOub6fG@mail.gmail.com>
References: <1294249444-11951-1-git-send-email-sumit.semwal@ti.com> <87wrmgjp1e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50864 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1AIIuH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 9 Jan 2011 03:50:07 -0500
Received: by mail-bw0-f43.google.com with SMTP id 14so20229882bwz.2
        for <linux-omap@vger.kernel.org>; Sun, 09 Jan 2011 00:50:06 -0800 (PST)
In-Reply-To: <87wrmgjp1e.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hi Kevin,

On Sat, Jan 8, 2011 at 4:32 AM, Kevin Hilman <khilman@ti.com> wrote:
> Sumit Semwal <sumit.semwal@ti.com> writes:
>
>> This patch series enables support for OMAP4 DSS, and adds hwmod supp=
ort
>> for dss, dispc, dsi1, dsi2, hdmi, rfbi and venc hwmods.
>
> This series is confusing as the 3 patches here do not do all the thin=
gs
> described here.
>
> It also doesn't apply to the master branch (e.g. PATCH 3/3 modifies
> display.c, which doesn't exist until your other series.)
=46irst up, apologies for submitting these patches while the dependent
patch series is still under discussion - I guess I should've waited
till the hwmod patch series is accepted, but I thought mentioning the
dependency might be sufficient. will take care in future.

Though I don't quite understand why you think that the 3 patches don't
do all that is described.

The first patch enables building DSS for OMAP4 by updating the Kconfig
accordingly.
The second patch enables hwmod support for all the dss IP hwmod
devices, and the third one enhances the hwmod lookup to lookup OMAP4
devices as well.

If you could tell me what is missing or extra, I would correct that
and send an updated version.

Thanks, and best regards,
~Sumit.
>
> Please take care when writing these cover letters to be sure they are
> accurate, otherwise reviewers/maintainers can't help but be confused
> about what is going on.
>
> Kevin
>
>
>> In OMAP4 there are severals IPs that can be reached by differents
>> interconnect paths depending of the access initiator (MPU vs. SDMA).
>>
>> In the case of the DSS, both L3 direct path and L4 CFG path can be
>> used to access all the DSS IPs.
>> dss is also considered as an IP as dispc, rfbi, and named as dss_dss=
=2E
>>
>> TODO:
>> This patch doesn't handle the opt clocks via hwmod - there will be a=
 separate
>> patch series which will take opt clock roles from hwmod, populate th=
em in
>> the device structure, so that the driver can ask for relevant opt-cl=
ocks.
>>
>> Also TBD is the migration to pm_runtime APIs, which need to be adapt=
ed a little
>> for handling DSS-family of clocks completely.
>>
>> Patch Base:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> url =3D git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-o=
map-2.6.git
>> branch "master"
>> Commit id: fa3b4e23ec20cfc944db7cc2b30b0d82c20e4472
>> Description: =A0cbus: Fix retu_rtc_do_reset
>> +
>> hwmod patches under discussion: http://www.mail-archive.com/linux-om=
ap@vger.kernel.org/msg41534.html
>> +
>> patch series: OMAP2PLUS: DSS: Generalize clock names
>> --------------------------------------------------------
>>
>> Benoit Cousson (1):
>> =A0 OMAP4: hwmod data: add DSS DISPC DSI1,2 RFBI HDMI VENC
>>
>> Mayuresh Janorkar (1):
>> =A0 OMAP2PLUS: DSS2: Add OMAP4 support
>>
>> Sumit Semwal (1):
>> =A0 OMAP4: DSS2: Add hwmod device names for OMAP4.
>>
>> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 23=
 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0588 +++++++++++++=
+++++++++++++++
>> =A0drivers/video/omap2/dss/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06=
 +-
>> =A0drivers/video/omap2/omapfb/Kconfig =A0 =A0 =A0 =A0 | =A0 =A06 +-
>> =A04 files changed, 609 insertions(+), 14 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
