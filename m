From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Thu, 31 Jul 2008 19:17:44 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208A6A04F@dbde02.ent.ti.com>
References: <486BDD2A.5070500@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com>
 <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl>
 <486F21F6.7020208@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com>
 <87vdzi2ln0.fsf@trdhcp146196.ntc.nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9263@dbde02.ent.ti.com>
 <746A464E-F4E2-467A-9D01-DFE2AB3BB02E@student.utwente.nl>
 <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9641@dbde02.ent.ti.com>
 <0680EC522D0CC943BC586913CF3768C00208A6A03F@dbde02.ent.ti.com>
 <B8C1A084-3C54-48C6-A4DE-A437C80E2C52@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:42263 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbYGaNsB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jul 2008 09:48:01 -0400
In-Reply-To: <B8C1A084-3C54-48C6-A4DE-A437C80E2C52@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, H?gander Jouni <jouni.hogander@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Koen:

> -----Original Message-----
> From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> Sent: Thursday, July 31, 2008 7:03 PM
> To: Syed Mohammed, Khasim
> Cc: Gadiyar, Anand; H?gander Jouni; Dirk Behme; linux-omap@vger.kernel.org
> Subject: Re: Kernel hang on OMAP3 based Beagle board, RTC issue?
>
<snip>
> >>>>
> >
> > Hi Jouni,
> >
> > Commenting the lines did fix my UART 3 issue, but I am not clear as
> > to what is happening by having it enabled. Before I dig in further
> > can you give your thoughts as to why these lines could result in
> > UART3 hang?
>
> I've had these lines commented out for some weeks now and still get
> the hang.
>

I didn't apply any other patches to OMAP GIT, I just cloned a new version of OMAP GIT and built it for Beagle using default config, also commented the lines mentioned by Jouni.

If I don't comment these lines then UART hangs immediately after 30min approx, with lines commented I am running for 10 hrs now with out a hang.

Any way the issue could still exists, I would like to know what exactly this code does to help me in focusing on a specific area.

May be we miss porting some lines of code to Beagle.

Regards,
Khasim
