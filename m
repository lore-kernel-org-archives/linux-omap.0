From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCHv3 0/3] OMAP UART: Adding support for omap-serial driver.
Date: Tue, 24 Nov 2009 15:04:09 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402543D7A46@dbde02.ent.ti.com>
References: <35552.192.168.10.88.1256713953.squirrel@dbdmail.itg.ti.com>
 <44977.192.168.10.88.1258095220.squirrel@dbdmail.itg.ti.com>
 <d6a0f7aa0911200151xb948a28kf4f22d79e61b993e@mail.gmail.com>
 <20091123170544.GA10313@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44458 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932383AbZKXJeU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 04:34:20 -0500
In-Reply-To: <20091123170544.GA10313@lixom.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Govindraj <govindraj.ti@gmail.com>, "g@lixom.net" <g@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: Olof Johansson [mailto:olof@lixom.net] 
> Sent: Monday, November 23, 2009 10:36 PM
> To: Govindraj; g@lixom.net
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; Pandita, 
> Vikram; Raja, Govindraj; G, Manjunath Kondaiah
> Subject: Re: [PATCHv3 0/3] OMAP UART: Adding support for 
> omap-serial driver.
> 
> On Fri, Nov 20, 2009 at 03:21:26PM +0530, Govindraj wrote:
> > I have not seen any comments on this patch series yet.
> > 
> > Tony,
> > Is there something I need to modify?
> 
> Govindaj,
> 
> I'm having problems with these patches on Zoom2 with debug 
> board, since
> they don't seem to coexist very well together with 8250. Enabling both
> options will result in build errors.

Why do we need to enable both 8250 and omap-serial for console. The console
UART can be either external UART or any one of the omap UART right?

-Manjunath

> 
> Also, you have hardcoded and are using the same major/minor 
> versions as
> the 8250 driver, which results in failure to allocate those 
> devices when
> probing 8250. That needs to be corrected.
> 
> 
> -Olof
> 
> 