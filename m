From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/2] remoteproc: use a flag to detect the presence of IOMMU
Date: Mon, 4 Aug 2014 14:50:47 +0300
Message-ID: <CAK=Wgbbf5JNxzW16z=vXHi9D8Om1KnLEEr7hEw5T0oN7GuM=og@mail.gmail.com>
References: <1404836521-59637-1-git-send-email-s-anna@ti.com>
 <1404836521-59637-2-git-send-email-s-anna@ti.com> <CAK=Wgbawdik3ZB0Zbeaa7eXd7M+9ev9u713GcfOc4Gy0+O80Dg@mail.gmail.com>
 <53D7C769.6080500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53D7C769.6080500@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Robert Tivy <rtivy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 29, 2014 at 7:10 PM, Suman Anna <s-anna@ti.com> wrote:
> We are trying to add a remoteproc driver for a small Cortex M3 called
> the WkupM3 used for suspend/resume management on TI AM335/AM437x SoCs.
> This processor does not have an MMU. Same is the case with another
> processor subsystem PRU-ICSS on AM335/AM437x. All these are platform
> devices, and the current iommu_present check will not scale for the same
> kernel image to support OMAP4/OMAP5 and AM335/AM437x.

That's perfect, thanks. Can you please add this use case description
to the commit log?

This way we'll be able to recover it easily one day if needed.

Thanks,
Ohad.
