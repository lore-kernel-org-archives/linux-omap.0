From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Mon, 18 Aug 2014 15:41:12 -0400
Message-ID: <20140818154112.6601cbff@gandalf.local.home>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
	<1408202315-20006-6-git-send-email-mpa@pengutronix.de>
	<53F244DA.3070803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:64591 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750915AbaHRTlP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Aug 2014 15:41:15 -0400
In-Reply-To: <53F244DA.3070803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, =?ISO-8859-1?B?QmVub+50?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Mon, 18 Aug 2014 23:54:26 +0530
Mugunthan V N <mugunthanvnm@ti.com> wrote:

> On Saturday 16 August 2014 08:48 PM, Markus Pargmann wrote:
> > +	mac_addr[5] = (macid_lo >> 8) & 0xff;
> > +	mac_addr[4] = macid_lo & 0xff;
> > +	mac_addr[3] = (macid_hi >> 24) & 0xff;
> > +	mac_addr[2] = (macid_hi >> 16) & 0xff;
> > +	mac_addr[1] = (macid_hi >> 8) & 0xff;
> > +	mac_addr[0] = macid_hi & 0xff;
> > +
> This will fail incase of DRA74x and DRA72x platforms, please check for
> u-boot src for parsing logic as TRM is not out yet. Below is the actual
> code for DRA7 platforms for MAC address parsing
> 
> mac_addr[0] = (mac_hi & 0xFF0000) >> 16;
> mac_addr[1] = (mac_hi & 0xFF00) >> 8;
> mac_addr[2] = mac_hi & 0xFF;
> mac_addr[3] = (mac_lo & 0xFF0000) >> 16;
> mac_addr[4] = (mac_lo & 0xFF00) >> 8;
> mac_addr[5] = mac_lo & 0xFF;
> 

But this fails with my beaglebone white.

I tested Markus's patches and it came up with the same ethaddr that
U-Boot had.

>From U-Boot:

ethaddr=d4:94:a1:8b:ec:78

With Markus's changes:

 eth0      Link encap:Ethernet  HWaddr D4:94:A1:8B:EC:78

But when I changed the code to match what you wrote, I got this:

 eth0      Link encap:Ethernet  HWaddr CE:5A:8B:0E:44:45

but it also gave me:

cpsw 4a100000.ethernet: Random MACID = ce:5a:8b:0e:44:45

which means it failed the valid mac test.

Here's how I implemented your change:

#if 1
        mac_addr[0] = (macid_hi & 0xFF0000) >> 16;
        mac_addr[1] = (macid_hi & 0xFF00) >> 8;
        mac_addr[2] = macid_hi & 0xFF;
        mac_addr[3] = (macid_lo & 0xFF0000) >> 16;
        mac_addr[4] = (macid_lo & 0xFF00) >> 8;
        mac_addr[5] = macid_lo & 0xFF;

#else   
        mac_addr[5] = (macid_lo >> 8) & 0xff;
        mac_addr[4] = macid_lo & 0xff;
        mac_addr[3] = (macid_hi >> 24) & 0xff;
        mac_addr[2] = (macid_hi >> 16) & 0xff;
        mac_addr[1] = (macid_hi >> 8) & 0xff;
        mac_addr[0] = macid_hi & 0xff;
#endif  

Just to be consistent, I updated the code as this too:

        mac_addr[0] = (macid_hi >> 16) & 0xFF;
        mac_addr[1] = (macid_hi >> 8) & 0xFF;
        mac_addr[2] = macid_hi & 0xFF;
        mac_addr[3] = (macid_lo >> 16) & 0xFF;
        mac_addr[4] = (macid_lo >> 8) & 0xFF;
        mac_addr[5] = macid_lo & 0xFF;

With the same affect.

Thus, for this patchset, as is:

Tested-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
