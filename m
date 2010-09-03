From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] omap3/omap4 hsmmc: Register offset handling
Date: Fri, 03 Sep 2010 08:44:30 -0700
Message-ID: <87eida4ysh.fsf@deeprootsystems.com>
References: <23570.10.24.255.18.1283190527.squirrel@dbdmail.itg.ti.com>
	<4C80A76F.3060108@ti.com>
	<AANLkTi=OW_sykGsf8u8Gi94ApLCYjiR+xS4aEu1Tf3pC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52745 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0ICPog convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 11:44:36 -0400
In-Reply-To: <AANLkTi=OW_sykGsf8u8Gi94ApLCYjiR+xS4aEu1Tf3pC@mail.gmail.com>
	(kishore kadiyala's message of "Fri, 3 Sep 2010 13:51:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishorek.kadiyala@gmail.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>

kishore kadiyala <kishorek.kadiyala@gmail.com> writes:

> Hi Benoit
>
> <snip>
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap_readl(base + reg_off)&
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMCHS_SYSSTATUS_=
RESETDONE))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>>
>> Why does that series not seems to be based on your hwmod migration? =
The
>> reset is fully handle by the hwmod framework now.
>
> Agree. But Kevin has  suggested to post this patch  independent of hw=
mod.
> Does this patch has to go in hwmod series ?

I suggested that this register conversion patch could be merged before
the hwmod conversion as it is independent of that.

The hwmod conversion (based on this series) would then just remove the
reset from here.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
