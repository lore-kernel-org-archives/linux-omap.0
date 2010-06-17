From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] OMAP3630: Update ES1.1 silicon revision detection
Date: Thu, 17 Jun 2010 11:38:56 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0133360CA7@dlee02.ent.ti.com>
References: <1272466280-2784-1-git-send-email-manjugk@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03230B2831@dbde02.ent.ti.com>
 <4C03C933.4090009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48699 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab0FQQjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 12:39:00 -0400
In-Reply-To: <4C03C933.4090009@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>


> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Monday, May 31, 2010 9:36 AM
> To: Gadiyar, Anand
> Cc: G, Manjunath Kondaiah; linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: [PATCH] OMAP3630: Update ES1.1 silicon revision detection
> 
> On 05/31/2010 03:50 PM, Gadiyar, Anand wrote:
> > Manjunatha GK wrote:
> >> This patch updates ES1.1 silicon revision ID for OMAP3630
> >> processor. The silicon revision can be read by reading hawkeye
> >> and revision bits in IDCODE register.
> >>
> >> Tested on 3630sdp(with ES1.1 silicon) and Zoom3(with ES1.0) silicon.
> >>
> >> Signed-off-by: Manjunatha GK<manjugk@ti.com>
> >> Cc: Nishanth Menon<nm@ti.com>
> >> Cc: Tony Lindgren<tony@atomide.com>
> >
> > Ping?
> >
> > FWIW, tested on other OMAP3 ES1.1 boards too.
> >
> >> ---
> >>   arch/arm/mach-omap2/id.c              |   20 ++++++++++++++++----
> >>   arch/arm/plat-omap/include/plat/cpu.h |    3 +++
> >>   2 files changed, 19 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> >> index 37b8a1a..dd26092 100644
> >> --- a/arch/arm/mach-omap2/id.c
> >> +++ b/arch/arm/mach-omap2/id.c
> >> @@ -259,11 +259,20 @@ void __init omap3_check_revision(void)
> >>   		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
> >>   		break;
> >>   	case 0xb891:
> >> -	/* FALLTHROUGH */
> >> -	default:
> >> -		/* Unknown default to latest silicon rev as default*/
> >> -		omap_revision = OMAP3630_REV_ES1_0;
> >> +		/* Handle 36xx devices */
> >>   		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
> >> +
> >> +		switch(rev) {
> >> +		case 0: /* Take care of early samples */
> >> +			omap_revision = OMAP3630_REV_ES1_0;
> >> +			break;
> >> +		case 1:
> >> +		/* Fall through */
> >> +		default:
> >> +			/* Use the latest known revision as default */
> >> +			omap_revision =  OMAP3630_REV_ES1_1;
> >> +			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
> 
> just a late realization relooking at the code: omap_chip.oc is ES1 and
> ES1_1?

Just realized that the logic is really sane. Thanks anand for pointing out.

Acked-by: Nishanth Menon <nm@ti.com>

Regards,
Nishanth Menon
