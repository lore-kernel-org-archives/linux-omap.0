From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] OMAP4: dma: Correct CPU version check for dma_common_ch_end
Date: Thu, 23 Feb 2012 09:29:05 +0200
Message-ID: <4F45EAC1.5070309@ti.com>
References: <1329470706-29682-1-git-send-email-peter.ujfalusi@ti.com> <20120222230714.GV18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:38863 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753175Ab2BWH27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 02:28:59 -0500
Received: by lagz14 with SMTP id z14so1950535lag.27
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 23:28:56 -0800 (PST)
In-Reply-To: <20120222230714.GV18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

On 02/23/2012 01:07 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120217 00:54]:
>> CCDN is the last common channel register in all OMAP4 versions. Use
>> cpu_is_omap44xx() instead of the cpu_is_omap4430() - which is anyway=
 not
>> doing what it supposed to do.
>=20
> This is a bit unclear.. Which is not doing what is supposed to do?
> DMA driver? Or one of the cpu_is_omap?

The cpu_is_omap4430() returns 0 unconditionally. Because of this the
dma_common_ch_end is wrongly configured on OMAP4 (even on OMAP4430).

> If this should be queued as a fix, then we need some kind of
> description here what breaks.

I will resend the patch with a better commit message. This is a bug for
sure, but I'm not sure how severe it is. At best we are not clearing th=
e
registers between CCFN, and CCDN on OMAP4.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
