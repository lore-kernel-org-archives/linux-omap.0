From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 0/9] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 10 Mar 2011 10:57:55 +0530
Message-ID: <AANLkTi==-RuvQBgQedJjrhdORf3NAjue_QnaihRw5mME@mail.gmail.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299680106.2151.91.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52694 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751022Ab1CJF14 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 00:27:56 -0500
Received: by mail-vw0-f48.google.com with SMTP id 20so1321489vws.7
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 21:27:55 -0800 (PST)
In-Reply-To: <1299680106.2151.91.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,
yes This is based off your tree.

Thanks and regards,
Mythri.

On Wed, Mar 9, 2011 at 7:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
>> Adding HDMI support on OMAP4.
>>
>> HDMI is a driver that is similar to the VENC or the DSI driver to su=
pport
>> HDMI/DVI sink device.
>>
>> The current design adheres to the DSS2 architecture.
>>
>> It is split into the HDMI DSS driver and HDMI panel driver.
>
> This doesn't apply to my tree. Are you sure it's based on DSS master
> branch?
>
> Applying: OMAP4 : DSS2 : Add display type HDMI to DSS2
> Applying: OMAP4 : DSS2 : HDMI: Select between HDMI VENC clock source.
> Applying: OMAP4 : DSS2 : HDMI: HDMI dispc gamma table disable.
> Applying: OMAP4 : DSS2 : HDMI: HDMI driver header file addition
> Applying: OMAP4 : DSS2 : HDMI: HDMI driver addition in the DSS
> fatal: sha1 information is lacking or useless (drivers/video/omap2/ds=
s/dss.h).
> Repository lacks necessary blobs to fall back on 3-way merge.
> Cannot fall back to three-way merge.
> Patch failed at 0005 OMAP4 : DSS2 : HDMI: HDMI driver addition in the=
 DSS
> When you have resolved this problem run "git am -3 --resolved".
> If you would prefer to skip this patch, instead run "git am -3 --skip=
".
> To restore the original branch and stop patching run "git am -3 --abo=
rt".
>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
