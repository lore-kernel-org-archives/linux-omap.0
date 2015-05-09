From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] remoteproc/wkup_m3: add a remoteproc driver for TI
 Wakeup M3
Date: Sat, 9 May 2015 11:42:11 +0300
Message-ID: <CAK=WgbaQPK1x6k8iq8DDCSRpna4HRyDJ-MTU+DTAst6VZy13_Q@mail.gmail.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com> <1427917039-43206-5-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37377 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbEIImd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 May 2015 04:42:33 -0400
Received: by igbsb11 with SMTP id sb11so38850530igb.0
        for <linux-omap@vger.kernel.org>; Sat, 09 May 2015 01:42:32 -0700 (PDT)
In-Reply-To: <1427917039-43206-5-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>

Hi Dave,

On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Add a remoteproc driver to load the firmware and boot a small
> Wakeup M3 processor present on TI AM33xx and AM43xx SoCs. This
> Wakeup M3 remote processor is an integrated Cortex M3 that allows
> the SoC to enter the lowest possible power state by taking control
> from the MPU after it has gone into its own low power state and
> shutting off any additional peripherals.

>From a remoteproc point of view this looks generally ok.

The only non-standard remoteproc aspect here is the handling of the
internal memories. Can you please generally describe how are these
memories being used in the context of remoteproc? how does the
resource table of your firmware look like - do you also have carveouts
or other resources?

Thanks,
Ohad.
