From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [DSPBRIDGE RFC] Combining Reserve and Map into a new IOCTL
Date: Thu, 03 Sep 2009 12:39:12 +0300 (EEST)
Message-ID: <20090903.123912.71561215.Hiroshi.DOYU@nokia.com>
References: <4A9D2313.4040408@nokia.com>
	<20090902153823.GB6174@annwn.research.nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E3F3CC003@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26086 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbZICJjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 05:39:20 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3F3CC003@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, linux-omap@vger.kernel.org, omar.ramirez@ti.com, x0095840@ti.com, roman.tereshonkov@nokia.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [DSPBRIDGE RFC] Combining Reserve and Map into a new IOCTL
Date: Wed, 2 Sep 2009 18:16:26 +0200

> The initial idea behind DSPProcessor_ReserveMemory call was to
> provide the User's the option of doing DSP buffer management for a
> pool of memory by themselves. So, call Reserve one time, and do
> map/unmap multiple times within that region, and call Unreserve only
> once you are done using the Buffer. But obviously that's not how
> this is being used.

Would it be possible to explan a little bit more about the advantage
of above use case, where it reserves onece, and maps/unmaps multiple
times?
