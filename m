From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Error displaying commit 4ca958bea8c1d6 in gitweb
Date: Tue, 13 May 2008 11:06:44 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02224F68E6@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02224F66E6@dbde02.ent.ti.com>
 <20080512160812.GA28999@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60513 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451AbYEMFh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 01:37:28 -0400
In-Reply-To: <20080512160812.GA28999@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "lvcargnini@gmail.com" <lvcargnini@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> * Gadiyar, Anand <gadiyar@ti.com> [080512 06:01]:
> > Hi Tony,
> >
> > I was trying to look at the history of the following file in gitweb:
> >         <include/asm-arm/arch-omap/mcbsp.h>
> >
> > It throws a parsing error seemingly because of characters
> in the above
> > commit's Author field.
> >
> > Any chance we can fix this? (I'm not even sure if we should, but if Luis
> > doesn't mind, maybe we could change it to something displayable).
>
> Well we could git-revert and reapply it, but I don't know if that
> really helps considering that it's been since September 2007.
>
> At least this displays it fine (with the messed up character set
> though):
>
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=4ca958bea8c1d6e3ad9725a112757013313d3bb5

Yup. This works fine. Thanks.

- Anand
