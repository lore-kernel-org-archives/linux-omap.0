From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC][PATCH v2 1/1] ARM: OMAP2+: PM: Register suspend ops even
 in the presence of DT blob
Date: Fri, 20 Jul 2012 05:01:34 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB14B1E@DBDE01.ent.ti.com>
References: <1342699728-19831-1-git-send-email-vaibhav.bedia@ti.com>
 <5008E10F.4080706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48779 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab2GTFBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 01:01:51 -0400
In-Reply-To: <5008E10F.4080706@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pswan.com" <paul@pswan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 20, 2012 at 10:09:43, Nayak, Rajendra wrote:
> On Thursday 19 July 2012 05:38 PM, Vaibhav Bedia wrote:
> > As per the comment in omap2_common_late_init() looks like the
> > original intent of the DT check was to treat only the PMIC
> > and SR initialization differently. Recent changes to consolidate
> > the suspend-resume code across OMAP3/4 resulted into the
> > registration of suspend ops also being dependent on the check
> > for DT blob. Since the suspend-resume operation should not
> > really be dependent on the usage of DT remove this dependency
> > by wrapping the PMIC and SR init under the DT check.
> 
> So I am guessing you also tested suspend/resume on your hardware
> with this patch, when booting with a DT blob, and it passed.
> 

I am getting there ;)

I am in the process of getting a real suspend/resume functional. As part
of this I was just flow flushing the whole suspend process in the mainline
kernel by putting in a dummy implementation for the .enter op and found that
this change was needed.

Regards,
Vaibhav
