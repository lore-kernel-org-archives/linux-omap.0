From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: AM35xx
Date: Fri, 13 Jan 2012 05:39:25 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A43A5@DBDE01.ent.ti.com>
References: <CAOd_LFxqZ6RKL_Q9Pp2biUJ8W61a+6ScXH6c_zWpTgyEtF-stw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56398 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab2AMFj3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 00:39:29 -0500
In-Reply-To: <CAOd_LFxqZ6RKL_Q9Pp2biUJ8W61a+6ScXH6c_zWpTgyEtF-stw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>, Linux OMAP Users <linux-omap@vger.kernel.org>

On Fri, Jan 13, 2012 at 03:37:07, Cliff Brake wrote:
> What kernel trees are recommended for v3.1 or v3.2 AM35xx support?
> 
> I've been using Linus' v3.2 tree.  We have quite a bit working, but
> wondering if there is a place with additional fixes, etc.
> 
AFAIK, not on any of v3.x kernel versions. There is a release
available on 2.6.37 which has been tested against AM3517EVM, 

http://arago-project.org/git/projects/?p=linux-omap3.git;a=shortlog;h=refs/heads/OMAPPSP_04.02.00.07


As up-streaming patches takes their own time, You have to forward port 
patches to the v3.x kernel.

Thanks,
Vaibhav

> Thanks,
> Cliff
> 
> -- 
> =================
> http://bec-systems.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

