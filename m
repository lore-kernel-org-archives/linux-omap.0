From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v5 04/17] OMAP2,3 DSS2 Change driver name to omap_display
Date: Tue, 11 Jan 2011 10:47:16 +0530
Message-ID: <AANLkTi=NbceO4hAXyPssL2XcFXw5S8Szq=QGGFvsX-Fv@mail.gmail.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
 <1294399551-10457-5-git-send-email-sumit.semwal@ti.com> <alpine.DEB.2.00.1101101654100.5731@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:44576 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750901Ab1AKFRh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jan 2011 00:17:37 -0500
Received: by mail-bw0-f47.google.com with SMTP id 10so18733310bwz.34
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 21:17:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101101654100.5731@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tomi.valkeinen@nokia.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Paul,

On Tue, Jan 11, 2011 at 5:25 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 7 Jan 2011, Sumit Semwal wrote:
>
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> Change the driver name from omapdss to omap_display as the driver ta=
kes care of
>> the display devices ie number of panels, type of panels available in=
 the
>> platform. =A0Change the device name in the board files and 2420,2430=
,3xxx clock
>> files from omapdss to omap_display to match the driver name.
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> Sumit, your Signed-off-by: is missing on this and some of the other
> patches. =A0Please add it in if you will be submitting these.
Yes, I will be submitting these, so will add my Signed-off-by: for all.
>
>> ---
>> =A0arch/arm/mach-omap2/clock2420_data.c =A0 =A0 =A0 =A0 | =A0 =A08 +=
+++----
>> =A0arch/arm/mach-omap2/clock2430_data.c =A0 =A0 =A0 =A0 | =A0 =A08 +=
+++----
>> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 =A0 | =A0 14 +++=
++++-------
>
> The clkdev changes in the above three files are
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
Thanks!
~Sumit.
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
