From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 1/9] OMAP: ID: introduce chip detection for OMAP4460
Date: Thu, 26 May 2011 16:15:15 -0700
Message-ID: <87d3j59hq4.fsf@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
	<1306375016-707-2-git-send-email-nm@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D177F64@dbde02.ent.ti.com>
	<20110526142741.GA2082@olorun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:35341 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754820Ab1EZXPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 19:15:18 -0400
Received: by mail-pz0-f54.google.com with SMTP id 27so848347pzk.27
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 16:15:17 -0700 (PDT)
In-Reply-To: <20110526142741.GA2082@olorun> (Nishanth Menon's message of "Thu,
	26 May 2011 07:27:44 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "V, Aneesh" <aneesh@ti.com>

Nishanth Menon <nm@ti.com> writes:

> On 14:03-20110526, Premi, Sanjeev wrote:
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org 
>> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>> > Sent: Thursday, May 26, 2011 7:27 AM
>> > To: linux-omap
>> > Cc: V, Aneesh; Menon, Nishanth
>> > Subject: [RFC][PATCH 1/9] OMAP: ID: introduce chip detection 
>> > for OMAP4460
>> > 
>> > From: Aneesh V <aneesh@ti.com>
>> > 
>> > Add support for detecting the latest in the OMAP4 family: OMAP4460
>> > Among other changes, the new chip also can support 1.5GHz A9s,
>> > 1080p stereoscopic 3D and 12 MP stereo (dual camera). In addition,
>> > we have changes to OPPs supported, clock tree etc, hence having a
>> > chip detection is required.
>> > 
>> > Starting from OMAP4460 ES1.0, we are moving from HAWKEYE to 
>> > Ramp system
>> > for chip identification. Since the bit offsets are the same, 
>> > just rename
>> > the variable for dual use.
>> > 
>> > For more details on OMAP4460, see
>> > Highlights:
>> > http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?c
>> > ontentId=53243&navigationId=12843&templateId=6123
>> > Public TRM is available here as usual:
>> > http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?t
>> > emplateId=6123&navigationId=12667
>> > 
>> > [nm@ti.com: cleanups and introduction of ramp system]
>> > Signed-off-by: Nishanth Menon <nm@ti.com>
>> > Signed-off-by: Aneesh V <aneesh@ti.com>
>> > ---
>> >  arch/arm/mach-omap2/id.c              |   19 ++++++++++++++-----
>> >  arch/arm/plat-omap/include/plat/cpu.h |   12 ++++++++++++
>> >  2 files changed, 26 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> > index 2537090..724be0a 100644
>> > --- a/arch/arm/mach-omap2/id.c
>> > +++ b/arch/arm/mach-omap2/id.c
>> > @@ -331,7 +331,7 @@ static void __init omap3_check_revision(void)
>> >  static void __init omap4_check_revision(void)
>> >  {
>> >  	u32 idcode;
>> > -	u16 hawkeye;
>> > +	u16 hawkeye_ramp;
>> 
>> [sp] Why is this change required?
> As explained in the commit message, using hawkeye will not be accurate
> anymore for 4460 onwards. The variable naming is changed to prevent confusion in
> the future as we continue to use ramp_system. As far as I know, there is
> no unique bit to differentiate between the two and so far have been
> unique.

So if the register is the same, and all the bit offsets are the same,
what has changed?  IOW, if there's no difference to the SW, then the
variable rename is probably superfluous, and could be covered by a
comment in the code.

Kevin
