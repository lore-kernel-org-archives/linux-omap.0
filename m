From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Thu, 8 Nov 2012 10:32:59 +0530
Message-ID: <509B3D03.4080003@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35287 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab2KHFDK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 00:03:10 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@linaro.org>

On Thursday 08 November 2012 06:42 AM, Mike Turquette wrote:
> I also tested on OMAP4460 Panda-ES.  Boot is fine and PRCM programming
> appears sane.  However Panda-ES never comes back from suspend/resume.
> This problem exists on the PRM/CM branch I based on and was not
> introduced by this series.  I am investigating that independently of
> this series.

Don't bother. Its been a know issue for a long time now.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg72056.html
