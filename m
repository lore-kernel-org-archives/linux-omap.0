From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to match
 hardware/TRM
Date: Thu, 28 Mar 2013 05:18:41 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3B9C6@DBDE01.ent.ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
	<1364389156-8273-2-git-send-email-hvaibhav@ti.com>
 <87k3ot6kq9.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38117 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3C1FS5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 01:18:57 -0400
In-Reply-To: <87k3ot6kq9.fsf@dell.be.48ers.dk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Porter, Matt" <mporter@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
> Korsgaard
> Sent: Wednesday, March 27, 2013 6:52 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Cousson, Benoit; Porter, Matt; devicetree-discuss@lists.ozlabs.org
> Subject: Re: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to
> match hardware/TRM
> 
> >>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
>  Vaibhav> With DT support, where naming convention is based on base-
> addr
>  Vaibhav> and not id, so we should follow TRM/Spec numbering label.
> 
>  Vaibhav> This patch changes I2C numbering as per TRM, as I2C0, I2C1
> and I2C2.
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> What about the uart numbers while we're at it?
> 
Just responded to Matt on the same note,
I will change it and submit the next version with your acked-by.

Thanks,
Vaibhav
