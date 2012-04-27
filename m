From: Liam Girdwood <lrg@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 15:56:42 +0100
Message-ID: <1335538602.4150.12.camel@odin>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk>
	 <CAMQu2gw0pYcb5SoVLbWPL4rfda24EZVPPUUziU8gxZxviDBLZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:34079 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760158Ab2D0O4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 10:56:46 -0400
Received: by wgbds1 with SMTP id ds1so611742wgb.4
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 07:56:44 -0700 (PDT)
In-Reply-To: <CAMQu2gw0pYcb5SoVLbWPL4rfda24EZVPPUUziU8gxZxviDBLZg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Fri, 2012-04-27 at 19:45 +0530, Shilimkar, Santosh wrote:
> + Peter and Liam to comment
> 
> On Fri, Apr 27, 2012 at 7:28 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Can someone please hint on what audio is supported on these two OMAP
> > boards?  From what I can tell, the answer is either "nothing" or "hdmi",
> > both of which are useless to me if someone wants me to convert the OMAP
> > ASoC driver to DMA engine.
> >
> > From what I can see on the 4430SDP, there's a 3.5mm headset jack,
> > microphones and speakers on the board, so the board does have audio
> > hardware.  However, it seems (as, I'm afraid to say, seems to be pretty
> > much standard practice with OMAP) there's a total lack of software
> > support in mainline.
> >
> > This kind'a prevents me testing changes to the DMA support for OMAP
> > ASoC...
> >
> > What can be done to remedy this situation?
> >

Peter now has has the final patches for Legacy mode (i.e. without ABE)
now upstream in 3.4-rc. Legacy mode gives a direct SDMA -> McPDM ->
twl6040 audio path so would be a good starting point for DMA testing.

Regards

Liam


