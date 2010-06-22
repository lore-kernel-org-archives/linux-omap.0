From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP FB code to set DISPC_TIMING_{H,V} doesn't match
 TRM
Date: Tue, 22 Jun 2010 11:50:25 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1006221135410.2550@tubuntu.research.nokia.com>
References: <20100616214340.GA27198@gibbs.hungrycats.org> <AANLkTinaUy_aPsEZIUUFFSgUdn1RmyAOKRPOop9AfSqL@mail.gmail.com> <20100621213123.GQ1248@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1565053519-1277196626=:2550"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47165 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab0FVIur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 04:50:47 -0400
In-Reply-To: <20100621213123.GQ1248@gibbs.hungrycats.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1565053519-1277196626=:2550
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT


On Mon, 21 Jun 2010, ext Zygo Blaxell wrote:

> On Mon, Jun 21, 2010 at 04:34:33PM +0300, Grazvydas Ignotas wrote:
>> (CC Tomi)
>>
>> On Thu, Jun 17, 2010 at 12:43 AM, Zygo Blaxell
>> <vger-linux-omap-esightcorp@mailtoo.hungrycats.org> wrote:
>>> The TRM and the OMAP FB driver have different ideas about the widths
>>> of various bit fields in the DISPC_TIMING_{H,V} registers.  This patch
>>> is based on what the TRM (TI document SPRUF98G) says.
>>>
>>> Note:  this patch changes the meanings of the vertical timing values
>>> by one scan line.  It still works with my display, but it might break
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

I would suggest to use the new driver, and fix any possible bugs on that 
one. The older driver is not really maintained anymore.

Of course if there's a critical bug in the old driver that appears on a 
board supported in the mainline kernel, the bug should be fixed.

  Tomi
--8323329-1565053519-1277196626=:2550--
