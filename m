From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 2/2] iommu/omap: fix NULL pointer dereference
Date: Sun, 26 Feb 2012 12:20:12 +0200
Message-ID: <CAK=WgbYg80AJCfHq==ShNkkfuxz6mfmc71hD9Z=JF_8CE9Xjcg@mail.gmail.com>
References: <1329902086-13868-1-git-send-email-ohad@wizery.com>
 <20120223161109.GB2454@amd.com> <CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg@mail.gmail.com>
 <20120224131638.GH2454@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32879 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2BZKUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Feb 2012 05:20:32 -0500
Received: by iazz13 with SMTP id z13so2027595iaz.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Feb 2012 02:20:32 -0800 (PST)
In-Reply-To: <20120224131638.GH2454@amd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <Joerg.Roedel@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Hiroshi Doyu <hdoyu@nvidia.com>

On Fri, Feb 24, 2012 at 3:16 PM, Joerg Roedel <Joerg.Roedel@amd.com> wrote:
> Applied both and added stable-tag to the second patch. I'll send the
> pull-request when you guys also send me the correct fix for the
> outstanding initialization order issue on OMAP.

It's out, thanks!
