From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next - multi-omap image fails to boot on omap3/4
Date: Fri, 22 Oct 2010 14:38:43 -0700
Message-ID: <20101022213843.GJ17595@atomide.com>
References: <20101019182149.GC3038@atomide.com>
 <AANLkTikYGwH-kQV3b+gqDYOKVvuiXOU=kBDVLy3ryNjR@mail.gmail.com>
 <20101019225726.GE3038@atomide.com>
 <20101019233204.GA30991@atomide.com>
 <AANLkTikrVJ3bw3aKE6V7uH9DmheVDihedNOP+wypYunC@mail.gmail.com>
 <AANLkTimqymuGdD3_SX2RVj=6a9j+ODKy8ipYZ-6hqw+S@mail.gmail.com>
 <20101021161545.GC3616@atomide.com>
 <8fb818d83ad3cb8e8e979e9b4ac52736@mail.gmail.com>
 <20101022185254.GG17595@atomide.com>
 <4CC1F0FF.4000701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64488 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab0JVVir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 17:38:47 -0400
Content-Disposition: inline
In-Reply-To: <4CC1F0FF.4000701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

* Anand Gadiyar <gadiyar@ti.com> [101022 13:07]:
> On 10/22/2010 2:52 PM, Tony Lindgren wrote:
> >
> >Yeah, it's an alignment issue that's why it sometimes works depending
> >on the Kconfig options selected..
> >
> >For rererence, posted a fix for that at:
> >
> >https://patchwork.kernel.org/patch/276161/
> 
> The patch seems to work - thanks! Just curious, how do you go about
> debugging an issue like this?

Well it was a bit tricky to find out as random changes to .config
would make it work. Found the breaking patch with git bisect, but
could not see anything wrong with it. Then thought it somehow
misbehaves with CONFIG_SMP_ON_UP, but some printhex8 debugging
showed that it happens even earlier. Then went back few lines in
the boot to narrow it down, but finally had to step through it
with jtag to see that the address loaded into r5 was not aligned.

Tony
