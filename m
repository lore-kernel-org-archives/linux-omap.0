From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap3: alsa-soc: Remove restrictive checks for cpu
 type
Date: Wed, 16 Mar 2011 13:58:13 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C30799E@dbde02.ent.ti.com>
References: <1300116162-25488-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51831 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435Ab1CPI21 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 04:28:27 -0400
In-Reply-To: <1300116162-25488-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Monday, March 14, 2011 8:53 PM
> To: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org; 
> linux-arm-kernel@lists.infradead.org
> Cc: Premi, Sanjeev
> Subject: [PATCHv2] omap3: alsa-soc: Remove restrictive checks 
> for cpu type
> 
> Current checks for cpu type were too restrictive leading
> to failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  Changes in this version:
>  1) Added one more check to the changes.
>  2) Updated commit message to use plurals.
> 
>  sound/soc/omap/omap-mcbsp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

[sp] This patch didn't seem to be lost in transit!
     Sending it again.

     Did anyone else ever face this issue?

~sanjeev
