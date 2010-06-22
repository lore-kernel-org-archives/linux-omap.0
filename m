From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] OMAP FB code to set DISPC_TIMING_{H,V} doesn't match TRM
Date: Tue, 22 Jun 2010 11:38:25 +0200
Message-ID: <B85BA683-2C80-4740-BCAE-68EAC6E9272F@student.utwente.nl>
References: <20100616214340.GA27198@gibbs.hungrycats.org> <AANLkTinaUy_aPsEZIUUFFSgUdn1RmyAOKRPOop9AfSqL@mail.gmail.com> <20100621213123.GQ1248@gibbs.hungrycats.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59015 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab0FVJia convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 05:38:30 -0400
Received: by wyb33 with SMTP id 33so2964729wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 02:38:28 -0700 (PDT)
In-Reply-To: <20100621213123.GQ1248@gibbs.hungrycats.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>


Op 21 jun 2010, om 23:31 heeft Zygo Blaxell het volgende geschreven:

> On Mon, Jun 21, 2010 at 04:34:33PM +0300, Grazvydas Ignotas wrote:
>> (CC Tomi)
>> 
>> On Thu, Jun 17, 2010 at 12:43 AM, Zygo Blaxell
>> <vger-linux-omap-esightcorp@mailtoo.hungrycats.org> wrote:
>>> The TRM and the OMAP FB driver have different ideas about the widths
>>> of various bit fields in the DISPC_TIMING_{H,V} registers.  This patch
>>> is based on what the TRM (TI document SPRUF98G) says.
>>> 
>>> Note:  this patch changes the meanings of the vertical timing values
>>> by one scan line.  It still works with my display, but it might break
>>> things for other people.
>> 
>> Why? The TRM doesn't say VFP, VBP have to be programmed with value -1.
> 
> Hmmm...that's correct.  Only VSW in DISPC_TIMING_V needs -1.  Sorry,
> my bad.
> 
> On the other hand, I've since found the equivalent code in the DSS driver,
> and it looks like this:
> 
>        if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
>                timing_h = FLD_VAL(hsw-1, 5, 0) | FLD_VAL(hfp-1, 15, 8) |
>                        FLD_VAL(hbp-1, 27, 20);
> 
>                timing_v = FLD_VAL(vsw-1, 5, 0) | FLD_VAL(vfp, 15, 8) |
>                        FLD_VAL(vbp, 27, 20);
>        } else {
>                timing_h = FLD_VAL(hsw-1, 7, 0) | FLD_VAL(hfp-1, 19, 8) |
>                        FLD_VAL(hbp-1, 31, 20);
> 
>                timing_v = FLD_VAL(vsw-1, 7, 0) | FLD_VAL(vfp, 19, 8) |
>                        FLD_VAL(vbp, 31, 20);
>        }
> 
> so it would seem that the wider field widths are only available on
> newer hardware than the old omapfb code was intended to support?

It is unclear when the wider registers were introduced. According to the TRM it's ES3.0, but all my ES2.1 SoCs already have them.

regards,

Koen