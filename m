From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Thu, 31 Mar 2011 18:36:06 +0530
Message-ID: <20110331130606.GB3938@avinash-laptop>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
 <20110314161609.GA10506@avinash-laptop>
 <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
 <4D8CA9C4.3060504@ti.com>
 <alpine.DEB.2.00.1103251121060.21987@utopia.booyaka.com>
 <20110326113138.GA3668@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59891 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757381Ab1CaNGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 09:06:18 -0400
Received: by yib12 with SMTP id 12so1464635yib.1
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 06:06:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110326113138.GA3668@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <kh>

> Thanks Benoit. You are right.=20
>=20
> The TRM Section '18.3.1.3.2 Software Reset' explains the steps for
> softresetting I2C. The steps are below:
>=20
> 1. Ensure that the module is disabled (clear the I2Ci.I2C_CON[15] I2C=
_EN
> bit to 0).
> 2. Set the I2Ci.I2C_SYSC[1] SRST bit to 1.
> 3. Enable the module by setting I2Ci.I2C_CON[15] I2C_EN bit to 1.
> 4. Check the I2Ci.I2C_SYSS[0] RDONE bit until it is set to 1 to indic=
ate
> the software reset is complete.

Hi paul,=20

I have been able to implement the function. It took a while because,
even after implementing the above sequence, i was seeing the I2C wasn't
resetting.=20

The issue turned out that i was doing '32 bit data access' which was
corrupting the i2c register contents. I missed the TRM section where it
tells, "i2c registers are limited to 8-bit or 16-bit access". Special
thanks to balaji.t.k for helping me debug this and pointing this was th=
e
issue. On correcting this, the function worked cleanly and i2c was
reset.

I ll send out the patch tomorrow.

br ,
- avinash

>=20
> >=20
> > Thanks Beno=EEt.
> >=20
> > So then, Avinash, you might need to create a custom hwmod class=20
> > reset function for the I2C block (viz., struct omap_hwmod_class.res=
et)
>=20
> OK Paul. I'll add the I2C_CON register and follow the above sequence =
as
> suggested in the TRM in the custom I2C reset function.
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
