From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 3 Apr 2012 10:47:49 +0100
Message-ID: <20120403094749.GH17741@mudshark.cambridge.arm.com>
References: <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
 <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55225 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429Ab2DCJsH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 05:48:07 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, "eranian@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Apr 03, 2012 at 10:42:30AM +0100, Shilimkar, Santosh wrote:
> On Tue, Apr 3, 2012 at 2:55 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Did you ever get to the bottom of this? This change really is required in
> > order to generate PMU interrupts with the CTI and I don't know of any
> > alternative to the above.
> >
> > Any suggestions?
> >
> Sorry I lost track of this one. There is one relevant patch in Kevin's queue
> for 3.4/fixes. [1] which I generated for perf time stamp issue.

Thanks, I'll take a look.

> Can you try that patch and see if it helps the CTI issue as well ? There
> is an outside chance that it might help. If it doesn't, we should commit
> Ming Lei  patch.

It seems that they're both needed to get reliable PMU operation. Without the
CLKDM_CAN_SWSUP fix, no interrupts are generated at all. Without the patch
below ([1]), it seems that we don't generate enough. So it looks like we
need them both.

> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/089679.html

Cheers,

Will
