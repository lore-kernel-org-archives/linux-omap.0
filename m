From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2] OMAP3: beagle: add support for beagleboard xM revision
 C
Date: Fri, 27 May 2011 16:20:55 +0300
Message-ID: <4DDFA537.1060207@compulab.co.il>
References: <1306500018-19685-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:59637
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754046Ab1E0NU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 09:20:58 -0400
In-Reply-To: <1306500018-19685-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, jkridner@beagleboard.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Koen,


Please CC LAKML for patches like this,

otherwise Tony, will have to post all of them before pull requesting.



On 05/27/11 15:40, Koen Kooi wrote:

> The USB enable GPIO has been inverted again and the USER button moved.
>
> Future revisions will now fall back to xM rev C instead of unknown.
>
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
>
> Changes since v1:
> 	* updated against mainline to take Igors gpio cleanup into account
> 	* removed xM rev B checks, no boards with that ID were ever produced, rev B boards show up as rev A
> 	* double checked whitespace:
>
> 		total: 0 errors, 0 warnings, 89 lines checked
> 		patches/0001-OMAP3-beagle-add-support-for-beagleboard-xM-revision.patch has no obvious style problems and is ready for submission.
>
>  arch/arm/mach-omap2/board-omap3beagle.c |   31 +++++++++++++++++++++++--------
>  1 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index be71426..177769b 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c

[...]

> @@ -565,6 +576,10 @@ static void __init omap3_beagle_init(void)
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap3_beagle_init_rev();
>  	omap3_beagle_i2c_init();
> +
> +	if (cpu_is_omap3630())
> +			gpio_buttons[0].gpio = 4;

Don't get me wrong, I want this patch in mainline as soon as possible.
Just curious, what the hell happened to indentation here? :)
checkpatch.pl does not spot things like this... interesting...
If you want to leave this as is, go ahead, I don't mind, just curious.

-- 
Regards,
Igor.

