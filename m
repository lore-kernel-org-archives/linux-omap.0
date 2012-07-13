From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional
 states
Date: Fri, 13 Jul 2012 10:56:53 +0530
Message-ID: <4FFFB19D.2090808@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com> <1339685591-11177-3-git-send-email-j-pihet@ti.com> <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:34276 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754410Ab2GMF1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 01:27:01 -0400
Received: by obbeh20 with SMTP id eh20so4500218obb.24
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 22:26:59 -0700 (PDT)
In-Reply-To: <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On Friday 13 July 2012 08:31 AM, Menon, Nishanth wrote:
> my Crib about the above apis are lack of logic power state handling:(
> which forces code like cpuidle to use different apis for logic
> power state and force them to use these apis just for pwrst.

Have you looked at an alternate approach that was proposed here..
https://patchwork.kernel.org/patch/1160431/

