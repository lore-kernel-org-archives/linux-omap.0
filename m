From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [DSPBRIDGE RFC] Combining Reserve and Map into a new IOCTL
Date: Thu, 3 Sep 2009 11:50:34 +0300
Message-ID: <20090903085034.GB2978@annwn.research.nokia.com>
References: <4A9D2313.4040408@nokia.com> <20090902153823.GB6174@annwn.research.nokia.com> <8F7AF80515AF0D4D93307E594F3CB40E3F3CC003@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57261 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbZICIu5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 04:50:57 -0400
Content-Disposition: inline
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3F3CC003@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>

On Wed, Sep 02, 2009 at 06:16:26PM +0200, Hari Kanigeri wrote:
> The initial idea behind DSPProcessor_ReserveMemory call was to provide
> the User's the option of doing DSP buffer management for a pool of
> memory by themselves. So, call Reserve one time, and do map/unmap
> multiple times within that region, and call Unreserve only once you
> are done using the Buffer. But obviously that's not how this is being
> used.

And they still would be able to do that because the old ioctls are not
be removed (yet).

-- 
Felipe Contreras
