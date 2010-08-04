From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v2] OMAP3630: Add ES1.1 and ES1.2 detection
Date: Wed, 4 Aug 2010 14:01:42 +0300
Message-ID: <20100804110142.GA19377@nokia.com>
References: <20100803073940.GS12293@atomide.com>
 <1280865564-6456-1-git-send-email-gadiyar@ti.com>
 <20100804103029.GI9881@atomide.com>
 <20100804105138.GJ9881@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17482 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0HDLDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 07:03:14 -0400
Content-Disposition: inline
In-Reply-To: <20100804105138.GJ9881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Manjunatha GK <manjugk@ti.com>

hi,

On Wed, Aug 04, 2010 at 12:51:39PM +0200, ext Tony Lindgren wrote:
>diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>index fd1904b..0a0ff0c 100644
>--- a/arch/arm/mach-omap2/id.c
>+++ b/arch/arm/mach-omap2/id.c
>@@ -269,11 +269,29 @@ static void __init omap3_check_revision(void)
> 		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
> 		break;
> 	case 0xb891:
>+		/* Handle 36xx devices */
>+		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
>+
>+		switch(rev) {
>+		case 0: /* Take care of early samples */
>+			omap_revision = OMAP3630_REV_ES1_0;
>+			break;
>+		case 1:
>+			omap_revision = OMAP3630_REV_ES1_1;
>+			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
>+			break;
>+		case 2:
>+			omap_revision =  OMAP3630_REV_ES1_2;
>+			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
>+			break;
>+		default:
>+			/* FALLTHROUGH */

did you forget a break here

>+		}
> 	/* FALLTHROUGH */
> 	default:
> 		/* Unknown default to latest silicon rev as default*/
>-		omap_revision = OMAP3630_REV_ES1_0;
>-		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
>+		omap_revision =  OMAP3630_REV_ES1_2;
>+		omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;

and here ?

-- 
balbi

DefectiveByDesign.org
