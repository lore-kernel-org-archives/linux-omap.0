From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv3 00/11] staging tidspbridge: iommu migration
Date: Fri, 15 Oct 2010 23:10:08 +0300
Message-ID: <AANLkTikfn9w-FMKXOVXibwHVy4vt72GdveDLVv0z3GmT@mail.gmail.com>
References: <1286310944-25035-1-git-send-email-x0095840@ti.com>
	<AANLkTimoTmhAw11jJihiuyByzKZ9KTFHvx6iw8oeLCGg@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B2BB1@dlee06.ent.ti.com>
	<AANLkTim6XRgnefA0vmRNeW=TONhxz68WYAjuA96LqWOj@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B3002@dlee06.ent.ti.com>
	<AANLkTik3hhWy+tRxThtrbwNXTssV7nf9+_LGn5Ct3iet@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F48817EF@dlee06.ent.ti.com>
	<AANLkTi=juk+824k1R8mJrDostKhRz+nRNqj9E-rNYWrv@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F4881816@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48849 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756Ab0JOUSE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 16:18:04 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602F4881816@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "ohad@wizery.com" <ohad@wizery.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Oct 15, 2010 at 7:53 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>> If you want I can provide my working branch on top of .36-rc8
>> with next-staging merged. If I revert your patches, it works fine.
>
> That could be interested. Can you send me the link?

There you go:
git://gitorious.org/~felipec/linux-omap/felipec.git (fc-dsp-work)

HEAD works, HEAD^ doesn't.

-- 
Felipe Contreras
