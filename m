From: Marc Butler <marc@plastictigers.com>
Subject: Re: [RFC PATCH] slimbus message encoding/decoding
Date: Fri, 9 Mar 2012 17:39:52 -0500
Message-ID: <20120309223952.GA5669@plastictigers.com>
References: <20120309002106.GA605@plastictigers.com>
 <4F5A5F00.70508@codeaurora.org>
Reply-To: marc@plastictigers.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li158-162.members.linode.com ([173.230.148.162]:35987 "EHLO
	plastictigers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030299Ab2CIWjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 17:39:53 -0500
Content-Disposition: inline
In-Reply-To: <4F5A5F00.70508@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sagar Dharia <sdharia@codeaurora.org>
Cc: kheitke@codeaurora.org, gclemson@audience.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 09, 2012 at 12:50:24PM -0700, Sagar Dharia wrote:
> On 03/08/2012 05:21 PM, Marc Butler wrote:
> 
> Thanks for providing this patch. My understanding is that this patch
> provides helper functions for h/w controllers which rely on s/w to
> provide the exact message to be sent out on the bus.

Yes. The ti omap4430 expects the messages, to be complete except for
the PI, MR, and MI fields which are encoded by the h/w.

> Just like CRC, some other fields may be populated by HW. e.g.
> Qualcomm chip also populates Arbitration priority, Arbitration
> Extension fields. So it expects SW to only program a few fields,
> a.k.a logical/elemental address, MT,MC, DT etc.(that too, SW
> programs this based on software interface manual). The hardware will
> convert this information to actual slimbus-compliant message and
> send it on the bus.

Understood. The functions are not incompatible with construction
partial messages, but as it will not likely work when inserting the
header field, as it goes about trying to compute the remaining length,
based on the current (icomplete) message including the arbitration
header.

> Being said that, I am not aware of how majority of h/w controllers
> work and will be open to have this patch if other hardwares rely on
> s/w to provide the exact message as well.

The ti omap4430 requires this support.

Regards,
-m
