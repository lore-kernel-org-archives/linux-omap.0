From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 4/9] OMAP4 : DSS2 : HDMI: HDMI driver header file addition
Date: Thu, 10 Mar 2011 10:32:22 +0530
Message-ID: <AANLkTimyrak4WfxWuiVvGT21k9jc0G6gz=R6=P8osvVj@mail.gmail.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299671118-20839-2-git-send-email-mythripk@ti.com>
	<1299671118-20839-3-git-send-email-mythripk@ti.com>
	<1299671118-20839-4-git-send-email-mythripk@ti.com>
	<1299671118-20839-5-git-send-email-mythripk@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C1922C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52372 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699Ab1CJFCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 00:02:24 -0500
Received: by vxb39 with SMTP id 39so1229829vxb.29
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 21:02:22 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C1922C2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sanjeev,

On Wed, Mar 9, 2011 at 9:26 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of K, Mythri P
>> Sent: Wednesday, March 09, 2011 5:15 PM
>> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
>> Cc: K, Mythri P
>> Subject: [PATCH v4 4/9] OMAP4 : DSS2 : HDMI: HDMI driver header file
>> addition
>>
>> Adding the hdmi interface driver header file (hdmi.h) to the dss driver.
>> Register and structure declaration done here.
>
> [sp] Any specific reason to keep header file in separate patch?
>
When i had posted it earlier there were several compliants  that the
patch is huge,
if i include header file with the corresponding c file , and hence
difficult to review. So it just to make
reviewers job easy.

>>
> [snip]...[snip]
>
Thanks and regards,
Mythri.
