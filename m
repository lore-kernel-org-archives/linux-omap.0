From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: [PATCH 1/2] regulator: twl: add clk32kg to twl-regulator
Date: Wed, 9 Feb 2011 22:15:28 +0530
Message-ID: <AANLkTi=aqr0gJTBasPOzBekz+OLzuhAjYW6cw3XsCCLT@mail.gmail.com>
References: <1297265845-21967-1-git-send-email-balajitk@ti.com>
	<20110209154444.GG24042@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38258 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754184Ab1BIQpa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Feb 2011 11:45:30 -0500
Received: by vws13 with SMTP id 13so207609vws.11
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 08:45:28 -0800 (PST)
In-Reply-To: <20110209154444.GG24042@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@slimlogic.co.uk, sameo@linux.intel.com, linux-omap@vger.kernel.org, tony@atomide.com

On Wed, Feb 9, 2011 at 9:14 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Feb 09, 2011 at 09:07:25PM +0530, Balaji T K wrote:
>
>> - =A0 =A0 TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x21)
>> + =A0 =A0 TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x21),
>> + =A0 =A0 TWL6030_FIXED_LDO(CLK32KG, 0x8C, 1000, 48, 0, 0x21),
>
> It'd seem better to implement a version of this that just doesn't hav=
e
> the voltage readback operation rather than putting in a dummy voltage=
=2E
> Otherwise this looks good.
>

yes, will do that.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
