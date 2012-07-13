From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP4: twl-common: Support for additional devices
 on i2c1 bus
Date: Fri, 13 Jul 2012 12:20:38 +0200
Message-ID: <4FFFF676.1090304@ti.com>
References: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com> <CAOMWX4e81gKYa_j8DHE_dn06+JfLwfEPuyj5kYVmDUBdG0n-1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55055 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932482Ab2GMKUW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 06:20:22 -0400
Received: by obbtb18 with SMTP id tb18so4344990obb.7
        for <linux-omap@vger.kernel.org>; Fri, 13 Jul 2012 03:20:19 -0700 (PDT)
In-Reply-To: <CAOMWX4e81gKYa_j8DHE_dn06+JfLwfEPuyj5kYVmDUBdG0n-1A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/13/2012 12:14 PM, Menon, Nishanth wrote:
> We still need a way to switch to I2C highspeed mode
> omap4_pmic_init still does register in 400KHz mode, while setting a b=
it in 6040
> should let us talk 3.3MHz on the bus.

We need to have a way to do this runtime I think. The twl6040 comes up =
with
100kbps as a default speed. So far we had no issue with 400kbps bus, bu=
t if we
increase it we might not be able to communicate with twl6040...

--=20
P=E9ter


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
