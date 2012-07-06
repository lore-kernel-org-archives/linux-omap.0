From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
Date: Fri, 6 Jul 2012 14:54:49 +0530
Message-ID: <CAMQu2gw9ccxk3KL8KUVxnLX8nTsDMSWyokHVMqR8Feo6DyrNWA@mail.gmail.com>
References: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com>
 <CAMQu2gyZQGGVQQtidGwOCux-0hX=FmPVP+9Sej_VRrQMurd=mw@mail.gmail.com> <4FF6AE6F.4000808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57408 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754906Ab2GFJZL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 05:25:11 -0400
Received: by qcmv28 with SMTP id v28so6627430qcm.39
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 02:25:09 -0700 (PDT)
In-Reply-To: <4FF6AE6F.4000808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

+ Russell

On Fri, Jul 6, 2012 at 2:52 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 07/06/2012 11:02 AM, Shilimkar, Santosh wrote:
>> On Fri, Jul 6, 2012 at 2:19 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>> The sys_nirq2 is used for twl6040, make sure the pin is configured
>>> correctly.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>> Should remove the boot-loader pin-muxing dependency.
>> Was this the reason, Audio had some issues on OMAP4430
>> SDP as reported by Russell ?
>
> The boot loader never configured the sys_nirq2, I have sent a patch for u-boot
> to do this, but it is said that the kernel should take care of this.
>
> We did not had jack detection working with upstream u-boot, kernel (I have
> patched u-boot so I have not seen this issue).
> Now if the board is booted without HS connected, upon connecting the HS we
> will recognize it and it should be all fine.
> So yes this was the reason why Russell had issues with audio.
>
Thanks Peter for tracking it down.

Regards
santosh
