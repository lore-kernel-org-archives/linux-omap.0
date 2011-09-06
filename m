From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 09/10] OMAP4: DSS2: HDMI: Function pointer approach
 to call
Date: Tue, 06 Sep 2011 13:17:41 +0300
Message-ID: <1315304261.1930.7.camel@deskari>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
	 <1314960470-2616-2-git-send-email-mythripk@ti.com>
	 <1314960470-2616-3-git-send-email-mythripk@ti.com>
	 <1314960470-2616-4-git-send-email-mythripk@ti.com>
	 <1314960470-2616-5-git-send-email-mythripk@ti.com>
	 <1314960470-2616-6-git-send-email-mythripk@ti.com>
	 <1314960470-2616-7-git-send-email-mythripk@ti.com>
	 <1314960470-2616-8-git-send-email-mythripk@ti.com>
	 <1314960470-2616-9-git-send-email-mythripk@ti.com>
	 <1314960470-2616-10-git-send-email-mythripk@ti.com>
	 <1315220503.3214.28.camel@deskari>
	 <CAP5A+B__VLN4Vr3v3Q7GXdKoxicTFOFQaTs8-UnoVC+XXRTETA@mail.gmail.com>
	 <CAP5A+B8j8QHOOXp5H2d=rsEgn+YOdWcqB9_SjZ=aE3U4jovLNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48411 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753316Ab1IFKRq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 06:17:46 -0400
Received: by bkas6 with SMTP id s6so9790629bka.1
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 03:17:43 -0700 (PDT)
In-Reply-To: <CAP5A+B8j8QHOOXp5H2d=rsEgn+YOdWcqB9_SjZ=aE3U4jovLNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2011-09-06 at 11:38 +0530, K, Mythri P wrote:
> >> Did you consider how the code would look if the function pointers
> were
> >> just included into struct hdmi_ip_data, without any ops struct at
> all?
> >>
> I tried without ops structure , but then using it in dss_features to
> initialize would be a problem so i have moved it to ti_hdmi.h.

I'm fine with the ops struct, but I don't see why it would be a problem
without it. You'd just pass the hdmi_ip_data to dss_features, which
would initialize it.

 Tomi


