From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] PWM: Add support for configuring polarity of PWM
Date: Tue, 24 Jul 2012 10:25:17 +0200
Message-ID: <500E5BED.6050401@metafoo.de>
References: <1342616053-7793-1-git-send-email-avinashphilip@ti.com> <20120723083032.GA12868@avionic-0098.mockup.avionic-design.de> <500DB0CB.1000600@metafoo.de> <20120724065121.GA30417@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:47175 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755632Ab2GXIXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 04:23:15 -0400
In-Reply-To: <20120724065121.GA30417@avionic-0098.mockup.avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "Philip, Avinash" <avinashphilip@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com

On 07/24/2012 08:51 AM, Thierry Reding wrote:
> 
> How about the following?
> 
> /**
>  * enum pwm_polarity - polarity of a PWM signal
>  * @PWM_POLARITY_NORMAL: a high signal for the duration of the duty-
>  *   cycle, followed by a low signal for the remainder of the pulse
>  *   period
>  * @PWM_POLARITY_INVERSED: a low signal for the duration of the duty-
>  *   cycle, followed by a high signal for the remainder of the pulse
>  *   period
>  */
> enum pwm_polarity {
> 	PWM_POLARITY_NORMAL,
> 	PWM_POLARITY_INVERSED,
> };
> 

Looks fine :)

Thanks,
- Lars
