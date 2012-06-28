From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: Move the stubbed prm and cm functions to
 prcm.c file and make them __weak.
Date: Thu, 28 Jun 2012 17:28:14 +0530
Message-ID: <CAJ7qFSfu3yyj8YqETTzx+wipi1Nbf5m5fDLC26Tfojav+Lb56Q@mail.gmail.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
	<1336669615-16454-3-git-send-email-r.sricharan@ti.com>
	<alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com>
	<CAJ7qFSdiMgM3S5Q+XaFAGrgcL5M5f8CLHyKSRtBKu4AK6ei-BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:48143 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752177Ab2F1L6V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 07:58:21 -0400
Received: by danh15 with SMTP id h15so3341731dan.37
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 04:58:20 -0700 (PDT)
In-Reply-To: <CAJ7qFSdiMgM3S5Q+XaFAGrgcL5M5f8CLHyKSRtBKu4AK6ei-BA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, paul@pswan.com

 Ping..

Thanks,
 Sricharan

On Thu, Jun 14, 2012 at 5:26 PM, R, Sricharan <r.sricharan@ti.com> wrot=
e:
> Hi Paul,
>
>>> Some prm and cm registers read/write and status functions
>>> are built only for some custom OMAP2+ builds and are stubbed
>>> in header files for other builds under ifdef statements.
>>> But this results in adding new CONFIG_ARCH_OMAPXXX
>>> checks when SOCs are added in the future. So move them
>>> to a common place for OMAP2+ and make them 'weak' implementations.
>>
>> Thanks for the patch. =A0These stubs aren't needed any longer, so we=
 can
>> just get rid of them; no need to mark them __weak. =A0I've got a pat=
ch to
>> just drop them here to be posted soon as part of a larger PRCM clean=
up.
>>
>>
> =A0Is the PRCM cleanup series available now ?
>
> Thanks,
> =A0Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
