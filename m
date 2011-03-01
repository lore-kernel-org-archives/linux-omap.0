From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [Patch v2 1/2] OMAP2PLUS:DSS2: add opt_clock_available in pdata
Date: Tue, 1 Mar 2011 11:57:04 +0530
Message-ID: <AANLkTim2S7La5-ASRqkOUpD0-J1agu2zx_TsPQrEDLzr@mail.gmail.com>
References: <1298905363-28871-1-git-send-email-sumit.semwal@ti.com>
 <1298905363-28871-2-git-send-email-sumit.semwal@ti.com> <1298909028.9809.139.camel@deskari>
 <AANLkTi=gTJLBeSNxTbteWydru9wnfSNDMi89cS-QB_UC@mail.gmail.com> <1298960399.2011.3.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:47170 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754562Ab1CAG1Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 01:27:25 -0500
Received: by mail-vx0-f169.google.com with SMTP id 38so4878731vxc.0
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 22:27:24 -0800 (PST)
In-Reply-To: <1298960399.2011.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

On Tue, Mar 1, 2011 at 11:49 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Mon, 2011-02-28 at 23:42 -0600, Semwal, Sumit wrote:
>> On Mon, Feb 28, 2011 at 9:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > On Mon, 2011-02-28 at 09:02 -0600, Semwal, Sumit wrote:
>> >> Provide a function in pdata to allow dss submodules to check if a=
 given
>> >> clock is available on a platform as an optional clock.
>> >>
>> >> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> >> (based on implementation from Senthil)
>> >>
>> >> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> >> ---
>> >> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 20=
 ++++++++++++++++++++
>> >> =A0arch/arm/plat-omap/include/plat/display.h | =A0 =A02 ++
>> >> =A02 files changed, 22 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/=
display.c
>> >> index 5ab6a74..9f4f862 100644
>> >> --- a/arch/arm/mach-omap2/display.c
>> >> +++ b/arch/arm/mach-omap2/display.c
>> >> @@ -42,6 +42,25 @@ static struct omap_device_pm_latency omap_dss_=
latency[] =3D {
>> >> =A0 =A0 =A0 },
>> >> =A0};
>> >>
>> >> +static bool opt_clock_available(const char *clk_role)
>> >> +{
>> >> + =A0 =A0 int i;
>> >> + =A0 =A0 struct omap_hwmod *oh;
>> >> +
>> >> + =A0 =A0 /* opt_clks are always associated with dss hwmod */
>> >> + =A0 =A0 oh =3D omap_hwmod_lookup("dss_core");
>> >> + =A0 =A0 if (!oh) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not look up dss_core.\n")=
;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> >
>> > The function returns a bool. Perhaps the lookup would be better do=
ne in
>> > omap_display_init(), and stored in a static variable.
>> Yes; I guess I should go with your earlier suggestion - of keeping
>> this 'oh' as part of pdata, and then use it here.
>
> I don't think it needs to be part of pdata. It's internal to this fil=
e,
> and if I'm not mistaken, omap_display_init() is called just once from
> the current board file. Thus the data could as well be stored in a
> static variable.
:) ok, that's correct; though we might need to make 'oh' part of pdata
based on our adaptation to the reset functionality - but that will
come later.
>
>> > Or if it's clear that this should never happen, BUG_ON(!oh);
>> Well, multiple people have 'frowned' upon using BUG_ON in dss -
>> especially because some people might still want their kernel to keep
>> working despite a display failure?
>
> Yes, BUG is an easy, not good, way out =3D).
:) hmmm... should I just return 'false' and print out a warning?
>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
