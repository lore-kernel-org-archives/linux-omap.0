From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant
 code from DSS.
Date: Wed, 29 Jun 2011 19:21:55 +0300
Message-ID: <1309364515.20494.20.camel@deskari>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
	 <1308823101.1834.79.camel@deskari>
	 <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
	 <1308832274.1834.109.camel@deskari>
	 <BANLkTik1TYgaGBYKqYxih1RjPKn8nU_cAA@mail.gmail.com>
	 <1309179518.1813.38.camel@lappyti>
	 <BANLkTi=VAaTf7SwXJikHAJGmxJLmbg84Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40736 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753919Ab1F2QWB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 12:22:01 -0400
Received: by mail-bw0-f53.google.com with SMTP id 12so1400843bwg.12
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 09:21:58 -0700 (PDT)
In-Reply-To: <BANLkTi=VAaTf7SwXJikHAJGmxJLmbg84Dw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, 2011-06-29 at 19:08 +0530, K, Mythri P wrote:
> Hi Tomi,

> As the HDMI PLL , PHY and video blocks are logical blocks it would
> make sense to have the API's for all and the DSS HDMI (interface
> driver - user driver) would make a call to configure this in a
> particular sequence to enable HDMI , in case you the call to be
> generic across OMAPS in future then we should i either have a funtion
> in hdmi.c which will do this sequence and will be  aware of underlying
> IP , Which doesnt appear to be the solution you prefer but then there
> would be a need to have an intermediate file which would take the
> common API call(function pointer) and then arbitrate between different
> IP's based on the make , Is that what you are suggesting ?

I agree that they are separate blocks, and at some level they need to be
separate with own functions for each. But I don't see why the user needs
to know about it.

For example, consider OMAP DSI. DSI has protocol, PLL and PHY blocks,
and the driver has functions to initialize them, use them etc. But the
user of DSI, in this case panel drivers, do not need to know about it,
and the API exported to the panel drivers does not contain any functions
related to PLL or PHY. The panel drivers just enable the DSI driver and
use it.

So I'm still asking: what benefit does it give to the user that the API
has functions to handle the blocks separately? There has to be a reason
for the functions in the API.

> > And it just occurred to me that perhaps our views of the API are a bit
> > different, and that's why we have differing opinions. I see this API as
> > something that could be used by OMAP DSS (and equivalent components on
> > other SoCs) to use the HDMI HW on OMAP4 and any future OMAPs. And
> > perhaps you see this API more as an API to use the current HDMI HW in
> > the OMAP4.
> 
> Tomi , Yes my Idea of this API is for OMAP and Netra series only , I
> am unable to envision a common HDMI API library , in that case it
> would make more sense to have an intermediate file and have function
> pointer , which would take common API calls like hdmi_enable ,
> hdmi_avi_confg etc and then arbitrate based on the build. Please let
> me know if you have anything else in mind.

I didn't mean a generic HDMI API either. I meant a TI HDMI API,
currently for OMAP and Netra. But my comments would be valid even if the
API would be only OMAP DSS internal. 

 Tomi


