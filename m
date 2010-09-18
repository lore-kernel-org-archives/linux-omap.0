From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/14] omap sram, omap4 control module and es2.0 support
Date: Sat, 18 Sep 2010 13:02:31 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307F35@dbde02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1009171147560.6562@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48290 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab0IRHcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Sep 2010 03:32:41 -0400
In-Reply-To: <alpine.DEB.2.00.1009171147560.6562@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Friday, September 17, 2010 11:21 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 00/14] omap sram, omap4 control module and es2.0
> support
> 
> Hello Santosh
> 
> On Fri, 17 Sep 2010, Santosh Shilimkar wrote:
> 
> > This is consolidated patch series targetted for 2.6.37 merge window.
> > All of these patches have been already posted/reviewed on the list.
> 
> Patch 6 is missing, could you please look into why?
> 
Mostly because of size of the patch, You can pick this from the
below git link 

> Also, please split all of the SCM changes out into a separate
> series/branch since they will be going in through my tree.  Am reviewing
> those now.
> 
Ok done. I have split the series and kept scm changes on 'omap4_scm_2.6.37'
head and rest on 'omap_for_2.6.37'

Regards,
Santosh
---
The following changes since commit 03a7ab083e4d619136d6f07ce70fa9de0bc436fc:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../sfrench/cifs-2.6

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap4_scm_2.6.37

Santosh Shilimkar (4):
      omap4: control: Add ctrl_pad_base to omap_globals
      omap4: control: Add accessor api's for pad control module
      omap4: control: Add the register definition headers
      omap4: control: Fix the control module register accesses

 

