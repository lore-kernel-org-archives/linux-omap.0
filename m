From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFT/RFC/PATCH 00/10] several cleanup patches
Date: Thu, 3 Dec 2009 00:32:36 +0200
Message-ID: <20091202223236.GB14921@nokia.com>
References: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64124 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbZLBWc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:32:58 -0500
Content-Disposition: inline
In-Reply-To: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, Dec 02, 2009 at 11:28:22PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>on the following we have section mismatch fixes,
>compile fix to board-nokia770.c, compile fix to sossi.c,
>compile fix to hwa742.c, compile fix to tahvo-usb.c
>and a few cleanups to cbus driver.
>
>It's compile tested only as I don't have 770s or n8x0 with
>the development jig available right now, so please, if you
>have any of those boards dusting around, test the following
>patches.

drop these... there was a missing hunk on one of the patches
that broke n8x0 compilation... sending againg in a while.

-- 
balbi
