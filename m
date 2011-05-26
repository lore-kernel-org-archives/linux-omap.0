From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC][PATCH 1/9] OMAP: ID: introduce chip detection for OMAP4460
Date: Thu, 26 May 2011 16:35:00 -0700
Message-ID: <BANLkTi=ZGo61JwwoxF5KQOT12S3q1KrL+g@mail.gmail.com>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-2-git-send-email-nm@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D177F64@dbde02.ent.ti.com>
 <20110526142741.GA2082@olorun> <87d3j59hq4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47846 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758552Ab1EZXfX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 19:35:23 -0400
Received: by wyb33 with SMTP id 33so1091680wyb.37
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 16:35:20 -0700 (PDT)
In-Reply-To: <87d3j59hq4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "V, Aneesh" <aneesh@ti.com>

On Thu, May 26, 2011 at 16:15, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> On 14:03-20110526, Premi, Sanjeev wrote:
>>> > -----Original Message-----
>>> > From: linux-omap-owner@vger.kernel.org
>>> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nis=
hanth
>>> > Sent: Thursday, May 26, 2011 7:27 AM
>>> > To: linux-omap
>>> > Cc: V, Aneesh; Menon, Nishanth
>>> > Subject: [RFC][PATCH 1/9] OMAP: ID: introduce chip detection
>>> > for OMAP4460
>>> >
>>> > From: Aneesh V <aneesh@ti.com>
>>> >
>>> > Add support for detecting the latest in the OMAP4 family: OMAP446=
0
>>> > Among other changes, the new chip also can support 1.5GHz A9s,
>>> > 1080p stereoscopic 3D and 12 MP stereo (dual camera). In addition=
,
>>> > we have changes to OPPs supported, clock tree etc, hence having a
>>> > chip detection is required.
>>> >
>>> > Starting from OMAP4460 ES1.0, we are moving from HAWKEYE to
>>> > Ramp system
>>> > for chip identification. Since the bit offsets are the same,
>>> > just rename
>>> > the variable for dual use.
>>> >
>>> > For more details on OMAP4460, see
>>> > Highlights:
>>> > http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?c
>>> > ontentId=3D53243&navigationId=3D12843&templateId=3D6123
>>> > Public TRM is available here as usual:
>>> > http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?t
>>> > emplateId=3D6123&navigationId=3D12667
>>> >
>>> > [nm@ti.com: cleanups and introduction of ramp system]
>>> > Signed-off-by: Nishanth Menon <nm@ti.com>
>>> > Signed-off-by: Aneesh V <aneesh@ti.com>
>>> > ---
>>> > =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 19 +=
+++++++++++++-----
>>> > =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 12 ++++++++++++
>>> > =A02 files changed, 26 insertions(+), 5 deletions(-)
>>> >
>>> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>>> > index 2537090..724be0a 100644
>>> > --- a/arch/arm/mach-omap2/id.c
>>> > +++ b/arch/arm/mach-omap2/id.c
>>> > @@ -331,7 +331,7 @@ static void __init omap3_check_revision(void)
>>> > =A0static void __init omap4_check_revision(void)
>>> > =A0{
>>> > =A0 =A0u32 idcode;
>>> > - =A0u16 hawkeye;
>>> > + =A0u16 hawkeye_ramp;
>>>
>>> [sp] Why is this change required?
>> As explained in the commit message, using hawkeye will not be accura=
te
>> anymore for 4460 onwards. The variable naming is changed to prevent =
confusion in
>> the future as we continue to use ramp_system. As far as I know, ther=
e is
>> no unique bit to differentiate between the two and so far have been
>> unique.
>
> So if the register is the same, and all the bit offsets are the same,
> what has changed? =A0IOW, if there's no difference to the SW, then th=
e
> variable rename is probably superfluous, and could be covered by a
> comment in the code.

OK. that'd be easier - I agree.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
