From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 7/9] OMAP4 : DSS : HDMI: Call to HDMI module init to
 register driver.
Date: Thu, 10 Mar 2011 10:54:24 +0530
Message-ID: <AANLkTinoP-YeGYLKOEyi328F5PwHZgbmRsSoSBOr977R@mail.gmail.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299671118-20839-2-git-send-email-mythripk@ti.com>
	<1299671118-20839-3-git-send-email-mythripk@ti.com>
	<1299671118-20839-4-git-send-email-mythripk@ti.com>
	<1299671118-20839-5-git-send-email-mythripk@ti.com>
	<1299671118-20839-6-git-send-email-mythripk@ti.com>
	<1299671118-20839-7-git-send-email-mythripk@ti.com>
	<1299671118-20839-8-git-send-email-mythripk@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C1922BC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43447 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751435Ab1CJFY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 00:24:26 -0500
Received: by vws16 with SMTP id 16so1419051vws.13
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 21:24:25 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C1922BC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sanjeev,

On Wed, Mar 9, 2011 at 9:24 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of K, Mythri P
>> Sent: Wednesday, March 09, 2011 5:15 PM
>> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
>> Cc: K, Mythri P
>> Subject: [PATCH v4 7/9] OMAP4 : DSS : HDMI: Call to HDMI module init=
 to
>> register driver.
>>
>> calling the platform registration of HDMI driver from core
>> during initialization.
>
> [sp] Contrary to the subject, patch adds calls for both init and unin=
it
> =A0 =A0 functions.
Subject says calling of the registration function.
>
> =A0 =A0 Shouldn't this be included in same patch where init and unini=
t are
> =A0 =A0 being defined?
Again i would prefer to keep the hdmi.c separate , do you see any
issue in splitting ? I have made sure every
patch compiles.
>
> [snip]...[snip]
>
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
