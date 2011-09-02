From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 02/10] OMAP4: DSS: HDMI: Move pll and video configuration
Date: Fri, 2 Sep 2011 10:52:26 +0530
Message-ID: <CAP5A+B-7EWL81UVOB4Ncaed-uNbGp5Sp8T1-dJrib3t6MA_3Tw@mail.gmail.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com> <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314865665.2169.7.camel@lappyti> <CAP5A+B_Kx+sHj+n3MZRPFMjeh+1u_g_4KbyW5qCdD7SOZyF5Yw@mail.gmail.com>
 <1314940432.1907.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43167 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904Ab1IBFWr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 01:22:47 -0400
Received: by iafi7 with SMTP id i7so3981307iaf.21
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 22:22:46 -0700 (PDT)
In-Reply-To: <1314940432.1907.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 2, 2011 at 10:43 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-09-02 at 10:41 +0530, K, Mythri P wrote:
>> Hi,
>>
>> On Thu, Sep 1, 2011 at 1:57 PM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>> > On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
>> >> From: Mythri P K <mythripk@ti.com>
>> >>
>> >> As the pll and the video configuration info are part of the ip_da=
ta those
>> >> structures are moved to the ip_data strtucure.Also the functions =
are modified
>> >> accordingly to take care of this movement.
>> >
>> > structure typoed, and use a space after period.
>> >
>> >> Signed-off-by: Mythri P K <mythripk@ti.com>
>> >> ---
>> >> =A0drivers/video/omap2/dss/hdmi.c | =A0 34 +++++++++++++++-------=
------------
>> >> =A0drivers/video/omap2/dss/hdmi.h | =A0 18 ++++++++++--------
>> >> =A02 files changed, 25 insertions(+), 27 deletions(-)
>
>> >> -static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
hdmi_pll_info *fmt)
>> >> +static int hdmi_pll_program(struct hdmi_ip_data *ip_data)
>> >> =A0{
>> >> =A0 =A0 =A0 u16 r =3D 0;
>> >> =A0 =A0 =A0 enum hdmi_clk_refsel refsel;
>> >> @@ -399,7 +397,7 @@ static int hdmi_pll_program(struct hdmi_ip_da=
ta *ip_data,
>> >>
>> >> =A0 =A0 =A0 refsel =3D HDMI_REFSEL_SYSCLK;
>> >>
>> >> - =A0 =A0 r =3D hdmi_pll_init(ip_data, refsel, fmt->dcofreq, fmt,=
 fmt->regsd);
>> >> + =A0 =A0 r =3D hdmi_pll_init(ip_data, refsel);
>> >
>> > I don't think I quite understood why refsel is not part of the pll=
 info.
>> > And if it has to be hardcoded, you could as well do that in
>> > hdmi_pll_init().
>> >
>> Ok , yes that is better.
>
> So, why refsel is not part of the pll info? The HW doesn't support
> changing it? If so, is it only for OMAPs or for all SoCs?
It is a variable parameter ,H/w supports changing it but it is never tr=
ied,
I was considering hard-coding it in the hdmi.c and passing it,
so that there would be no hard-coding in IP functions.

Thanks and regards,
Mythri.
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
