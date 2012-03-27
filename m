From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V2 2/3] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Tue, 27 Mar 2012 17:03:50 +0530
Message-ID: <CAF0AtAvKY2=8sVfKoKEvV0aCRK9ABLR-6RND-BzBW0CD5oYUig@mail.gmail.com>
References: <1332323516-9050-1-git-send-email-cmahapatra@ti.com>
	<1332845843.1867.126.camel@deskari>
	<CAF0AtAtOSw73YuKyTxc6=RwN75oQaFxRCBW3_=PTmUoxgAFyew@mail.gmail.com>
	<1332847059.1867.140.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45667 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751114Ab2C0Ldw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 07:33:52 -0400
Received: by mail-lb0-f176.google.com with SMTP id l5so52319lbo.21
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 04:33:51 -0700 (PDT)
In-Reply-To: <1332847059.1867.140.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Mar 27, 2012 at 4:47 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Tue, 2012-03-27 at 16:37 +0530, Mahapatra, Chandrabhanu wrote:
>> On Tue, Mar 27, 2012 at 4:27 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > On Wed, 2012-03-21 at 15:21 +0530, Chandrabhanu Mahapatra wrote:
>> >> In OMAP3 DISPC video overlays suffer from some undocumented horiz=
ontal position
>> >> and timing related limitations leading to SYNCLOST errors. Whenev=
er the image
>> >> window is moved towards the right of the screen SYNCLOST errors b=
ecome
>> >> frequent. Checks have been implemented to see that DISPC driver r=
ejects
>> >> configuration exceeding above limitations.
>> >>
>> >> This code was successfully tested on OMAP3. This code is written =
based on code
>> >> written by Ville Syrj=E4l=E4 <ville.syrjala@nokia.com> in Linux O=
MAP kernel. Ville
>> >> Syrj=E4l=E4 <ville.syrjala@nokia.com> had added checks for video =
overlay horizontal
>> >> timing and DISPC horizontal blanking length limitations.
>> >>
>> >> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> >> ---
>> >> =A0drivers/video/omap2/dss/dispc.c | =A0 97 +++++++++++++++++++++=
++++++++----------
>> >> =A01 files changed, 72 insertions(+), 25 deletions(-)
>> >>
>> >> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap=
2/dss/dispc.c
>> >> index 5a1963e..d8a1672 100644
>> >> --- a/drivers/video/omap2/dss/dispc.c
>> >> +++ b/drivers/video/omap2/dss/dispc.c
>> >> @@ -1622,6 +1622,57 @@ static void calc_dma_rotation_offset(u8 ro=
tation, bool mirror,
>> >> =A0 =A0 =A0 }
>> >> =A0}
>> >>
>> >> +static int check_horiz_timing(enum omap_channel channel, u16 pos=
_x,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 u16 width, u16 height, u16 out_width, u=
16 out_height)
>> >
>> > I think the function could be named check_horiz_timing_omap3 or
>> > something. It's kinda hard to realize that this is an omap3 work-a=
round.
>> > Perhaps a short comment above the function would be in order.
>> >
>>
>> Yes, you are right! Do you mean to include some comments within the
>> code definition itself? The patch description includes all that this
>> function does.
>
> I mean just a short comment above the function that mentions that thi=
s
> function is used to avoid the synclosts on omap3, because yadda yadda=
,
> so that the reader will immediately realize that this is doing some
> special handling.
>

Ok.

>> > I don't the change to dispc_mgr_lclk_rate has anything to do with =
this
>> > patch (fixing omap3 sync lost error). Shouldn't it be a separate f=
ix?
>> >
>> > =A0Tomi
>> >
>> I am thinking to to move this fix to the third patch in the series
>> "OMAPDSS: DISPC: Correct DISPC functional clock usage" and make it
>> separate patch from the series and if possible move it ahead of the
>> predecimation patch series. What do you say?
>
> This patch is using dispc_mgr_lclk_rate. Does it depend on the change=
?
> If so, it needs to be fixed before this patch. But yes, separating it
> sounds fine.
>
> =A0Tomi
>
To a certain extent it does. Moving it to the third patch will
introduce certain code changes as
if (dispc_mgr_is_lcd(channel)) while initialising dispc_core_clk.
Anyways that can be cleaned up in the third patch.

--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
