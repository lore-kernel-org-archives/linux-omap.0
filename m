From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: HDMI: Disable HDMI DDC internal pull up
Date: Tue, 25 Oct 2011 15:05:10 +0530
Message-ID: <CAP5A+B8VxBZSDtPAfV9v2kH6RDLnXKvV9ODfvs5Zjo+EDOOnZQ@mail.gmail.com>
References: <1319189226-11019-1-git-send-email-mythripk@ti.com> <1319195967.2870.77.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:58169 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755687Ab1JYJfb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Oct 2011 05:35:31 -0400
Received: by iabn5 with SMTP id n5so647111iab.17
        for <linux-omap@vger.kernel.org>; Tue, 25 Oct 2011 02:35:30 -0700 (PDT)
In-Reply-To: <1319195967.2870.77.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

Hi,

On Fri, Oct 21, 2011 at 4:49 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-10-21 at 14:57 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Disables the internal pull resistor for SDA and SCL enabled by
>> default as there are expernal pull up's to avoid the EDID read failu=
re.
>
> What do you mean with external pull up? Outside OMAP? Then it's a boa=
rd
> specific feature, isn't it, and not related to the OMAP version?
yes it is not specific to OMAP. SDP/Panda  boards OMAP 4430 version
ES2.3 and 4460 have this  board change, but as there is not separate
board file as such for these boards i have added the check as above.Do
you have any other idea?

Thanks and regards,
Mythri.
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
