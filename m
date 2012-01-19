From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Thu, 19 Jan 2012 21:26:12 +0800
Message-ID: <CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
	<4F0B182D.7060507@us.ibm.com>
	<20120109224945.GA23090@mudshark.cambridge.arm.com>
	<CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
	<CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
	<CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
	<CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
	<CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
	<CAMsRxfJmHkZw2f0A+4FsStJpXk_vrxvDduRcRGkcWpqp8a9m_w@mail.gmail.com>
	<CACVXFVOQNDRs=c8A2YC+WvYAHs5Abbz-QUEe1VJqrj2esFO11g@mail.gmail.com>
	<CAMsRxf+e38jRcyxESLhYDZ3OL910AQdapZD9P8vWDXfUE34DAA@mail.gmail.com>
	<CACVXFVPnhSy_DbdK+ro8G78QjL2s6fBBq1Dvq-pmxJ20qA-ymA@mail.gmail.com>
	<CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
	<CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55172 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab2ASN0P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2012 08:26:15 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1Rns0L-0008Vy-V3
	for linux-omap@vger.kernel.org; Thu, 19 Jan 2012 13:26:14 +0000
Received: by pbaa10 with SMTP id a10so36391pba.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 05:26:12 -0800 (PST)
In-Reply-To: <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eranian@gmail.com
Cc: Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Thu, Jan 19, 2012 at 9:14 PM, Ming Lei <ming.lei@canonical.com> wrote:
> On Thu, Jan 19, 2012 at 8:51 PM, stephane eranian
> <eranian@googlemail.com> wrote:
>> On Thu, Jan 19, 2012 at 1:45 PM, Ming Lei <ming.lei@canonical.com> wrote:
>>> Hi,
>>>
>>> On Thu, Jan 19, 2012 at 7:34 PM, stephane eranian
>>> <eranian@googlemail.com> wrote:
>>>> Hi,
>>>>
>>>> Ok some update on this.
>>>> With your .config file + 3.2.0 (Linus) + patch 3, 4, 5, 6, I get a kernel that
>>>
>>> You forget patch 1 and patch 2?
>>>
>> They are already in 3.2.0. Unless I am mistaken.
>
> Sorry, I just found that they have been merged to 3.2.

After a double check, the two patches are not merged to 3.2, but have
been merged to the latest linus tree and can be seen in 3.3-rc1.

Also the commit 3c50729b(ARM: OMAP4: PM: Initialise all the clockdomains
to supported states) has been merged to linus tree too.

So if you just tested the latest linus tree simply, you need to apply
the patch[1]
(I have mentioned the problem in the thread.)

thanks,
--
Ming Lei

[1],
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..41d2260 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
       .prcm_partition   = OMAP4430_PRM_PARTITION,
       .cm_inst          = OMAP4430_PRM_EMU_CM_INST,
       .clkdm_offs       = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-       .flags            = CLKDM_CAN_HWSUP,
+       .flags            = CLKDM_CAN_SWSUP,
 };

 static struct clockdomain l3_dma_44xx_clkdm = {
