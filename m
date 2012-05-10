From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Thu, 10 May 2012 15:19:08 +0530
Message-ID: <CAJ7qFSfnVAHE1jX0UcBcJU0JQPeNjKfgq_tj_yvf=BL0fN4jdA@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-3-git-send-email-r.sricharan@ti.com>
	<20120504223933.GX5613@atomide.com>
	<CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
	<20120507173351.GB5088@atomide.com>
	<CAJ7qFSeziNRTUsUWc2Owjqs=A99p_WgiVH8vnEBoVB42v2p+pQ@mail.gmail.com>
	<20120509160042.GM5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43269 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757753Ab2EJJtM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 05:49:12 -0400
Received: by lbbgh12 with SMTP id gh12so1216517lbb.11
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 02:49:09 -0700 (PDT)
In-Reply-To: <20120509160042.GM5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

Tony,
[snip]
>> =A0So after the cleanup patch introducing CONFIG_SOC_OMAP4PLUS
>> =A0it can be changed as
>> =A0#ifdef (CONFIG_SOC_OMAP4PLUS) && !(defined(CONFIG_ARCH_OMAP2) ||
>> defined(CONFIG_ARCH_OMAP3))
>>
>> So this will avoid patching this for the future socs. ?
>
> Well it seems that we've come to a conclusion that if we introduce
> new config options, they should be based on features instead. So
> CONFIG_SOC_HAS_OMAPXYZ_BLAH rather than CONFIG_SOC_OMAP4PLUS.
>
   Sure thanks for clarifying.
  Then i will introduce  a relevant config in my cleanup patch first an=
d
  then add OMAP5.

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
