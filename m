From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC][PATCH 3/3] OMAP: DSS2: Use vdds_sdi regulator supply in
 SDI
Date: Mon, 15 Mar 2010 13:32:59 +0200
Message-ID: <1268652779.2417.51.camel@tubuntu.research.nokia.com>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-3-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-4-git-send-email-roger.quadros@nokia.com>
	 <1268646814.2417.39.camel@tubuntu.research.nokia.com>
	 <4B9E1973.50504@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16419 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936136Ab0COL6T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 07:58:19 -0400
In-Reply-To: <4B9E1973.50504@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-03-15 at 12:26 +0100, Quadros Roger (Nokia-D/Helsinki)
wrote:
> Hi,
> 
> Valkeinen Tomi (Nokia-D/Helsinki) wrote:
> > On Fri, 2010-03-12 at 16:27 +0100, Quadros Roger (Nokia-D/Helsinki)
> > wrote:
> >> From: Roger Quadros <roger.quadros@nokia.com>
> >>
> >> This patch enables the use of vdds_sdi regulator in SDI subsystem.
> >> We can disable the vdds_sdi voltage when not in use to save
> >> power.
> >>
> >> Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
> >> ---
> >>  drivers/video/omap2/dss/sdi.c |   23 +++++++++++++++++++++--
> >>  1 files changed, 21 insertions(+), 2 deletions(-)
> >>

<snip>

> > And why do you test for omap34xx?
> > 
> I just assumed that, so i guess that was wrong. Will check the TRM and fix it.

Well, SDI is only for omap34xx. But why do you test it inside sdi.c, and
only for the regulator? I don't think SDI will work any better on
OMAP3630 (which doesn't have the SDI block), even if you don't use the
regulators ;).

So I think it's safe to assume inside sdi.c that we are running on a
device with SDI HW block.

 Tomi


