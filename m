From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: Current state of AM33xx patches
Date: Mon, 11 Jun 2012 19:45:58 +0530
Message-ID: <4FD5FD9E.5040203@ti.com>
References: <4FD5BA4C.9070706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57021 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab2FKOQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:16:11 -0400
In-Reply-To: <4FD5BA4C.9070706@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



On 6/11/2012 2:58 PM, Daniel Mack wrote:
> Hey,
> 
> can anybody give me a quick wrap-up about the current state of AM33xx
> based SoCs in mainline? What are the next steps to get things merged?
> 

Daniel,

We are in the process of submitting all baseport patches to the
upstream, summary would be,

Accepted:
	- Machine and low-level init code
	- Basic DT required for boot.
	- Voltagedomain, Powerdomain, clockdomain implementation

Currently under work (already submitted multiple versions):
	- Clock Tree
	- HWMOD

I do maintain wiki page which you should refer for any updates:
http://processors.wiki.ti.com/index.php/Sitara_Linux_Upstream_Status

In order to get latest and greatest kernel to boot, you can use my repo:
https://github.com/hvaibhav/am335x-linux


Also, note that, currently there will be very minimal feature-set
supported in the kernel, so not sure how much can be leveraged for
production use-cases.


> I'm getting involved in a project that is based on a AM3352 and would
> like to provide help where necessary and wanted.
> 

That's great, help is always required and appreciated.

Thanks,
Vaibhav

> 
> Thanks,
> Daniel
> 

