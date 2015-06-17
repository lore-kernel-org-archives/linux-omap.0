From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v4 0/4] remoteproc: Introduce wkup_m3_rproc driver
Date: Wed, 17 Jun 2015 10:12:45 +0300
Message-ID: <CAK=WgbbQKaAuyfUJGWpzEmdSZFyReOsf+uPSQq9BMSaSh_xzaA@mail.gmail.com>
References: <1432327530-48032-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432327530-48032-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Fri, May 22, 2015 at 11:45 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Hi,
> This patch series is v4 of the series to add a wkup_m3_rproc driver
> for TI AM335xi and AM437x SoCs. This family of SoCs contains an ARM
> Cortex M3 coprocessor that is responsible for low-level power tasks
> that cannot be handled by the main ARM Cortex A8 so firmware running
> from the CM3 can be used instead. This driver handles loading
> of the firmware and reset of the CM3. Change info can be found
> with each patch.

Applied all 4 patches to remoteproc's for-next branch.

Thanks,
Ohad.
