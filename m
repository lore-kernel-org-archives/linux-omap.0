From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/7] omap4: Temporary fix silicon version detection
Date: Thu, 9 Sep 2010 18:31:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD17ED5E@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
 <20100909114255.GK21060@legolas.emea.dhcp.ti.com> <4C88C940.6070000@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D3A37@dbde02.ent.ti.com>
 <20100909120746.GB17000@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35917 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718Ab0IINBo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 09:01:44 -0400
In-Reply-To: <20100909120746.GB17000@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Balbi, Felipe
> Sent: Thursday, September 09, 2010 5:38 PM
> To: Shilimkar, Santosh
> Cc: Cousson, Benoit; Balbi, Felipe; linux-omap@vger.kernel.org;
> tony@atomide.com; khilman@deeprootsystems.com
> Subject: Re: [PATCH 2/7] omap4: Temporary fix silicon version detection
> 
> Hi Santosh,
> 
> On Thu, Sep 09, 2010 at 07:02:46AM -0500, Shilimkar, Santosh wrote:
> >Felipe is suggesting not to add this support where as you want to
> >have this support.
> >
> >Sorry if I haven't understood the comment. Care to clarify
> 
> no, I suggested not to revert :-) So, just change the comment saying why
> you need that extra check and remove the "this patch should be reverted
> later" part :-)
> 
Ok. I agree. We can actually keep this code.

Will change the comment and send V2

Regards,
Santosh 
