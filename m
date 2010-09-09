From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/7] omap4: Temporary fix silicon version detection
Date: Thu, 9 Sep 2010 17:32:46 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D3A37@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
 <20100909114255.GK21060@legolas.emea.dhcp.ti.com> <4C88C940.6070000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43409 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab0IIMCy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 08:02:54 -0400
In-Reply-To: <4C88C940.6070000@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Thursday, September 09, 2010 5:17 PM
> To: Balbi, Felipe
> Cc: Shilimkar, Santosh; linux-omap@vger.kernel.org; tony@atomide.com;
> khilman@deeprootsystems.com
> Subject: Re: [PATCH 2/7] omap4: Temporary fix silicon version detection
> 
> Hi Santosh,
> 
> On 9/9/2010 1:42 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Thu, Sep 09, 2010 at 06:23:10AM -0500, Santosh Shilimkar wrote:
> >> @@ -308,6 +308,16 @@ static void __init omap4_check_revision(void)
> >> 	hawkeye = (idcode>>  12)&  0xffff;
> >> 	rev = (idcode>>  28)&  0xff;
> >>
> >> +	/*
> >> +	 * FIXME: This patch should be reverted later.
> >> +	 * Few initial ES2.0 samples IDCODE is same as ES1.0
> >> +	 * Use ARM register to detect the correct ES version
> >> +	 */
> >
> > I wonder if it actually doesn't make sense to keep this in tree, the
> > overhead is minimum when rev is set correctly and it's safe for the
> > initial es2.0 samples which are buggy.
> 
> Yep, I agree with that, if some early ES2 samples are already out there,
> we will have no way to control the device upgrade in the future. So we
> will still have to support these early buggy devices just in case.
> 
Felipe is suggesting not to add this support where as you want to
have this support.

Sorry if I haven't understood the comment. Care to clarify

Regards,
Santosh

 

