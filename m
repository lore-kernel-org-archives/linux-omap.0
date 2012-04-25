From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH v2] arm: omap4: hsmmc: check for null pointer
Date: Wed, 25 Apr 2012 17:24:39 +0530
Message-ID: <CANrkHUak6ehg5+gF05rwfvT10iQzo+5tic8-R6MQkbRjMfnu6w@mail.gmail.com>
References: <1335192067-3666-1-git-send-email-balajitk@ti.com>
	<20120423144348.GF26302@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:50476 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759143Ab2DYLym convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 07:54:42 -0400
Received: by lbom4 with SMTP id m4so1836046lbo.16
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 04:54:39 -0700 (PDT)
In-Reply-To: <20120423144348.GF26302@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 23, 2012 at 8:13 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Apr 23, 2012 at 08:11:07PM +0530, Balaji T K wrote:
>> +int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *contro=
llers)
>> +{
>> + =A0 =A0 struct omap2_hsmmc_info *c;
>> +
>> + =A0 =A0 omap_hsmmc_init(controllers);
>> + =A0 =A0 for (c =3D controllers; c->mmc; c++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* pdev can be null if CONFIG_MMC_OMAP_HS =
is not set */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!c->pdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_twl6030_hsmmc_set_late_init(&c->pdev=
->dev);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>
> why are you even calling this if CONFIG_MMC_OMAP_HS isn't set ? Just
> stub it out if you don't have mmc support.

Ok, added in v3
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
