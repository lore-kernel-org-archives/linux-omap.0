From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 7/8] OMAP4: Keyboard board support
Date: Fri, 1 Oct 2010 16:22:16 -0700
Message-ID: <201010011622.18204.dmitry.torokhov@gmail.com>
References: <1285824973-25550-1-git-send-email-x0066660@ti.com> <20101001225127.GE3117@atomide.com> <87wrq14ipg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37532 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab0JAXW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:22:26 -0400
In-Reply-To: <87wrq14ipg.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Abraham Arce <x0066660@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

On Friday, October 01, 2010 04:05:47 pm Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [100929 23:32]:
> >> HI Abraham,
> >> 
> >> On Thu, Sep 30, 2010 at 12:36:13AM -0500, Abraham Arce wrote:
> >> > From: Syed Rafiuddin <rafiuddin.syed@ti.com>
> >> > 
> >> > Keyboard support for SDP OMAP4430
> >> 
> >> I think this would benefit from "const" sprinkled on it.
> >> 
> >> BTW, I picked up patches 2, 3, 4, 5, 8 (all touching drivers/input).
> > 
> > Thanks, I'll take 1, 6 & 7.
> 
> Dmitry,
> 
> Can you please drop patch 8 (the pm runtime one.)  As pointed out by
> Charu,  with the proposed platform changes, this cannot work
> correctly with runtime PM.

Right, will do.

-- 
Dmitry
