From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] usb: musb: pass configuration specifics via pdata
Date: Tue, 19 Aug 2008 17:40:19 +0300
Message-ID: <20080819144019.GD23346@gandalf.research.nokia.com>
References: <1218648977-5685-1-git-send-email-felipe.balbi@nokia.com> <1218648977-5685-2-git-send-email-felipe.balbi@nokia.com> <1218648977-5685-3-git-send-email-felipe.balbi@nokia.com> <5e088bd90808181643x2fa0c192wefe8eeff7c507f1b@mail.gmail.com> <20080819093903.GB23346@gandalf.research.nokia.com> <5e088bd90808190721i7a2cf809r95723434ea472e2f@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46374 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYHSOjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 10:39:35 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90808190721i7a2cf809r95723434ea472e2f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 19, 2008 at 07:21:21AM -0700, ext Steve Sakoman wrote:
> I've been testing it on the Gumstix Overo board (with no board
> specific platform-data) and have also seen no issues.
> 
> I asked because I had noticed that a few people reported USB issues on
> the #beagle irc channel.  One specifically mentioned that this patch
> caused his issue.  So I just wanted to verify that board specific
> platform data was not required for all omap3 boards.

point him to linux-usb mailing list. It's the best place for us to
discuss usb related problems :-)

also, was him using linux-omap or the beagle provided kernel ?

Did he bisect to point out exactly this patch been the root cause ? I'm
saying that cuz people had more than one month for trying out this patch
and now that it's applied on both linux-omap and mainline the problems
start to appear. Quite awkward but ok, not everybody follows the
patches.

Anyways, I didn't have any problems with this patch since I started
using it. It passes testusb (left running for two days in a row using
test.sh).

If there really is an issue, let's narrow it down and fix it.

-- 
balbi
