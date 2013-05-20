From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] ARM: OMAP AM33XX: clock data: Enable clkout2 as
 part of init
Date: Mon, 20 May 2013 05:30:17 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8E70F@DBDE04.ent.ti.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
 <1367919574-21353-2-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1305200248280.2656@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52100 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab3ETFas convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 May 2013 01:30:48 -0400
In-Reply-To: <alpine.DEB.2.00.1305200248280.2656@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, May 20, 2013 8:20 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Cousson, Benoit;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] ARM: OMAP AM33XX: clock data: Enable clkout2
> as part of init
> 
> On Tue, 7 May 2013, Vaibhav Hiremath wrote:
> 
> > clkout2 comes out on the pad and is being used by various
> > external on-board peripherals like, Audio codecs and stuff.
> > So enable the clkout2 by default during init sequence itself.
> 
> I don't like this: the clock should be enabled by the drivers for those
> external peripherals, not enabled by default.  

Neither do I. And certainly respective driver should make sure that
he enables all required clocks.

The gap here is, we only support DT only boot and currently clock bindings
Is not coming from DT. Once we get there this needs to change.

Also, note that, I do not expect impact on PM (atleast on AM335x).

> So I think you should
> reconsider the part of the patch that enables it upon init.  But if you
> really want to do this, I'm not inclined to stand in the way; you can
> add
> my ack.
> 

Thanks for your ack, I will send out next version shortly.

Thanks,
Vaibhav
