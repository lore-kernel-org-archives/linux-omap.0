From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 09/10] OMAP4: DSS2: HDMI: Function pointer approach to call
Date: Tue, 6 Sep 2011 16:55:45 +0530
Message-ID: <CAP5A+B-zK-dxjDjr=uMoLcEQUEhdQTLkn9LGc=QdkAe21S-0jA@mail.gmail.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1314960470-2616-2-git-send-email-mythripk@ti.com> <1314960470-2616-3-git-send-email-mythripk@ti.com>
 <1314960470-2616-4-git-send-email-mythripk@ti.com> <1314960470-2616-5-git-send-email-mythripk@ti.com>
 <1314960470-2616-6-git-send-email-mythripk@ti.com> <1314960470-2616-7-git-send-email-mythripk@ti.com>
 <1314960470-2616-8-git-send-email-mythripk@ti.com> <1314960470-2616-9-git-send-email-mythripk@ti.com>
 <1314960470-2616-10-git-send-email-mythripk@ti.com> <1315220503.3214.28.camel@deskari>
 <CAP5A+B__VLN4Vr3v3Q7GXdKoxicTFOFQaTs8-UnoVC+XXRTETA@mail.gmail.com>
 <CAP5A+B8j8QHOOXp5H2d=rsEgn+YOdWcqB9_SjZ=aE3U4jovLNA@mail.gmail.com> <1315304261.1930.7.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47431 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753795Ab1IFL0I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 07:26:08 -0400
Received: by mail-vx0-f180.google.com with SMTP id 15so4657353vxh.25
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 04:26:07 -0700 (PDT)
In-Reply-To: <1315304261.1930.7.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Sep 6, 2011 at 3:47 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Tue, 2011-09-06 at 11:38 +0530, K, Mythri P wrote:
>> >> Did you consider how the code would look if the function pointers
>> were
>> >> just included into struct hdmi_ip_data, without any ops struct at
>> all?
>> >>
>> I tried without ops structure , but then using it in dss_features to
>> initialize would be a problem so i have moved it to ti_hdmi.h.
>
> I'm fine with the ops struct, but I don't see why it would be a probl=
em
> without it. You'd just pass the hdmi_ip_data to dss_features, which
> would initialize it.
well instead of passing the struct ops if the function pointers are
included in ip_data directly, in dss_features each function will have
to be initialized in the dss_init_hdmi_ip_ops function i thought it is
cleaner to initialize the struct :-) ,it just looked cleaner to me
:-). else the entire intialization will come in a if else condition
for CPU's.

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
