From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 06/15] ARM: OMAP2+: hwmod: Enable OCMCRAM registration
 in AM33XX
Date: Sun, 4 Nov 2012 15:26:11 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD2B@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
 <5095436E.6030206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43166 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab2KDP0R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 10:26:17 -0500
In-Reply-To: <5095436E.6030206@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Sat, Nov 03, 2012 at 21:46:46, Shilimkar, Santosh wrote:
> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > The hwmod data for OCMCRAM in AM33XX was commented out.
> > This data is needed by the power management code, hence
> > uncomment the same and register the OCP interface for it.
> >
> Why this data is needed by PM code ?
> 

It's needed to ensure that the clock to ocmcram is running
during boot and doesn't get disabled as part of the suspend
sequence. Will reword the changelog.

Regards,
Vaibhav
