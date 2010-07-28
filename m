From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 5/5] omap:hwspinlocks-ensure the order of registration
Date: Wed, 28 Jul 2010 12:05:00 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4D2F377F@dlee03.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-6-git-send-email-h-kanigeri2@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A021@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37599 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755649Ab0G1RFF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 13:05:05 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A021@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

Sanjeev,

Thanks for your comments.

> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
> > Sent: Monday, July 19, 2010 10:20 PM
> > To: Linux Omap; Tony Lindgren
> > Cc: Shilimkar, Santosh; Cousson, Benoit; Que, Simon; Kanigeri, Hari
> > Subject: [PATCH 5/5] omap:hwspinlocks-ensure the order of registration
> >
> > Ensure that the hwspinlock driver is registered prior to
> > I2C driver registration since I2C is dependent on hwspinlock.
> 
> [sp] Is there another patch where this dependency is introduced?

Basically, hwspinlock driver should be registered prior to any other modules that uses it. I2C driver is currently using hwspinlock and we noticed an issue if hwspinlock wasn't registered early on.

I don't know if the I2C patch was communicated on mailing list yet. Balaji, can you please share your patch.

> 
> >

Best regards,
Hari
