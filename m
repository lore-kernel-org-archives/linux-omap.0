From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 4/4] remoteproc/wkup_m3: add a remoteproc driver for
 TI Wakeup M3
Date: Mon, 11 May 2015 10:01:19 -0500
Message-ID: <5550C43F.3070507@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com> <1427917039-43206-5-git-send-email-d-gerlach@ti.com> <CAK=WgbaQPK1x6k8iq8DDCSRpna4HRyDJ-MTU+DTAst6VZy13_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44444 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbbEKPBr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 11:01:47 -0400
In-Reply-To: <CAK=WgbaQPK1x6k8iq8DDCSRpna4HRyDJ-MTU+DTAst6VZy13_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>

Hi Ohad,

On 05/09/2015 03:42 AM, Ohad Ben-Cohen wrote:
> Hi Dave,
> 
> On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>> Add a remoteproc driver to load the firmware and boot a small
>> Wakeup M3 processor present on TI AM33xx and AM43xx SoCs. This
>> Wakeup M3 remote processor is an integrated Cortex M3 that allows
>> the SoC to enter the lowest possible power state by taking control
>> from the MPU after it has gone into its own low power state and
>> shutting off any additional peripherals.
> 
> From a remoteproc point of view this looks generally ok.
> 
> The only non-standard remoteproc aspect here is the handling of the
> internal memories. Can you please generally describe how are these
> memories being used in the context of remoteproc? 

The WkupM3 executes its code entirely from this internal RAM.

how does the
> resource table of your firmware look like - do you also have carveouts
> or other resources?

We don't have any carveouts or usage of any external DDR, as this
processor is used during Power Management, like cpuidle or suspend path,
and is used to control the MPU and DDR states. The resource table is
very simple and straight-forward [1]. We used to have RSC_INTMEM as part
of the resource table in the previous version, but we removed them since
that approach was NACKed.

regards
Suman

[1]
https://git.ti.com/ti-cm3-pm-firmware/amx3-cm3/blobs/next-upstream/src/sys_exec/rsc_table.h
