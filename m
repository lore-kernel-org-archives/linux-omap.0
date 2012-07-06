From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
Date: Fri, 6 Jul 2012 20:03:50 +0530
Message-ID: <CAMQu2gx4927Ze9tRUFq9QPubGFWfK9bHqZhVCb7c39O=WeWA3Q@mail.gmail.com>
References: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
 <1341580752-5501-2-git-send-email-peter.ujfalusi@ti.com> <874nplc6va.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33734 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752834Ab2GFOeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 10:34:25 -0400
Received: by qabj34 with SMTP id j34so535001qab.18
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 07:34:10 -0700 (PDT)
In-Reply-To: <874nplc6va.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 6, 2012 at 7:46 PM, Kevin Hilman <khilman@ti.com> wrote:
> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
>
>> The sys_nirq2 is used for twl6040, make sure the pin is configured
>> correctly.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-4430sdp.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
>> index c4e17641..72cd206 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -827,6 +827,9 @@ static void __init omap_4430sdp_display_init(void)
>>  #ifdef CONFIG_OMAP_MUX
>>  static struct omap_board_mux board_mux[] __initdata = {
>>       OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
>> +     /* NIRQ2 for twl6040 */
>> +     OMAP4_MUX(SYS_NIRQ2, OMAP_MUX_MODE0 |
>> +               OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
>
> Since this is TWL6030 specific, it should rather be done in TWL code
> like I did for sys_nirq1:
>
>    http://marc.info/?l=linux-omap&m=134090312118873&w=2
>
> That would avoid having to do this in both board files.
>
Though the pin is TWL specific, it need not be same on
different board with different SOCs. Especially when you need to
set MUX mode etc. So doing from board file is still better
since TWL6030/40 can be connected to non OMAP4 devices
where the muxing can be different.

With current know boards with TWL6030/40, this is not
a strong requirement though.

Regards
Santosh
