From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional states
Date: Fri, 13 Jul 2012 02:14:27 -0500
Message-ID: <CAOMWX4dZ8w7xhW5mj-voPw3sNo3KJu4EYUNcQudLaCA3fJmtgA@mail.gmail.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
 <1339685591-11177-3-git-send-email-j-pihet@ti.com> <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
 <CAORVsuV9-KXqd386aOPMEw2SS8NtaV_TCRiTaVMG42MtkVtfEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42281 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752749Ab2GMHOu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 03:14:50 -0400
Received: by wgbdr1 with SMTP id dr1so2657807wgb.24
        for <linux-omap@vger.kernel.org>; Fri, 13 Jul 2012 00:14:47 -0700 (PDT)
In-Reply-To: <CAORVsuV9-KXqd386aOPMEw2SS8NtaV_TCRiTaVMG42MtkVtfEQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On Fri, Jul 13, 2012 at 2:07 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:

>> my Crib about the above apis are lack of logic power state handling :(
>> which forces code like cpuidle to use different apis for logic
>> power state and force them to use these apis just for pwrst.
> Please look at the rest of the series.

Thanks for doing these, but with
https://patchwork.kernel.org/patch/1160431/ in context, my comments on
this patch is redundant and i think we should go with Rajendra's patch
instead of this. I am currently dropping this patch in my internal
tree. Will comment further as i get to next set of patches in this
series.

Regards,
Nishanth Menon
