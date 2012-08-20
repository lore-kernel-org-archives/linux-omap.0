From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v7] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Mon, 20 Aug 2012 04:33:59 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA1937D@DBDE01.ent.ti.com>
References: <1344866802-15980-1-git-send-email-anilkumar@ti.com>
 <502FEE11.7070305@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42707 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab2HTEeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Aug 2012 00:34:17 -0400
In-Reply-To: <502FEE11.7070305@pengutronix.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Marc,

On Sun, Aug 19, 2012 at 01:03:37, Marc Kleine-Budde wrote:
> On 08/13/2012 04:06 PM, AnilKumar Ch wrote:
> > Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> > APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> > register of C_CAN/D_CAN IP when clock is turned off.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> > This patch has been tested on AM335X EVM. Due to lack of hardware
> > I am not able to test c_can functionality. I appreciate if anyone
> > can test c_can functionality with this patch.
> > 
> > This patch is based on "can-next/master" 
> > 
> > Changes from v6:
> > 	- Incorporated Marc's commets on v6
> > 	  * changed dev pointer to priv
> 
> Sorry, I meant not to rename the variable, but change the signature of
> the function to:
> 
>   static inline void c_can_pm_runtime_get_sync(struct c_can_priv *priv)
> 

I will change in v8

Thanks
AnilKumar
