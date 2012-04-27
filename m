From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 19:45:46 +0530
Message-ID: <CAMQu2gw0pYcb5SoVLbWPL4rfda24EZVPPUUziU8gxZxviDBLZg@mail.gmail.com>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:56160 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756683Ab2D0OQJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 10:16:09 -0400
Received: by qcsk26 with SMTP id k26so412915qcs.12
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 07:16:07 -0700 (PDT)
In-Reply-To: <20120427135802.GA28062@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>

+ Peter and Liam to comment

On Fri, Apr 27, 2012 at 7:28 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Can someone please hint on what audio is supported on these two OMAP
> boards? =A0From what I can tell, the answer is either "nothing" or "h=
dmi",
> both of which are useless to me if someone wants me to convert the OM=
AP
> ASoC driver to DMA engine.
>
> From what I can see on the 4430SDP, there's a 3.5mm headset jack,
> microphones and speakers on the board, so the board does have audio
> hardware. =A0However, it seems (as, I'm afraid to say, seems to be pr=
etty
> much standard practice with OMAP) there's a total lack of software
> support in mainline.
>
> This kind'a prevents me testing changes to the DMA support for OMAP
> ASoC...
>
> What can be done to remedy this situation?
>
> Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
