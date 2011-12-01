From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 00/11] arm:omap:am33xx: Add basic voltage, power, clock & HWMOD data
Date: Thu, 01 Dec 2011 06:58:23 -0800
Message-ID: <87vcq0s5io.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<87ty5lt6dm.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A804761D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:42507 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752435Ab1LAO6a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 09:58:30 -0500
Received: by ggnr5 with SMTP id r5so1862161ggn.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 06:58:27 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A804761D@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Thu, 1 Dec 2011 12:02:18 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin
>> Sent: Thursday, December 01, 2011 7:12 AM
>> To: Hiremath, Vaibhav
>> Cc: linux-omap@vger.kernel.org; tony@atomide.com; paul@pwsan.com; linux-
>> arm-kernel@lists.infradead.org; Cousson, Benoit
>> Subject: Re: [RFC PATCH 00/11] arm:omap:am33xx: Add basic voltage, power,
>> clock & HWMOD data
>> 
>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > This patch series adds support for AM335X basic voltage, power,
>> > clock and HWMOD data to existing OMAP framework.
>> 
>> This series is missing patch 05/11.
>> 
> Ohhh...not sure what went bad.
>
> You can access it from, http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=commit;h=c2754eb60b65c6c574f2d6d871d8846358e40414
>
>
> I had published the whole series @ Arago.
>

OK, but using Arago, I will also get a bunch of other out of tree code.

Can you create a branch for base am33x support against a recent mainline
(like v3.2-rc3) for easier review/testing of just the AM33x support?

Kevin
