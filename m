From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 6/8] tsl2563: move tsl2563 to drivers/hwmon
Date: Tue, 14 Oct 2008 17:38:47 +0300
Message-ID: <20081014143847.GD28161@gandalf.research.nokia.com>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-2-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-3-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-4-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-5-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-6-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-7-git-send-email-felipe.balbi@nokia.com> <20081014153824.3722411c@hyperion.delvare> <20081014135230.GA28019@gandalf.research.nokia.com> <20081014161426.552115e5@hyperion.delvare>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58115 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYJNOj7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 10:39:59 -0400
Content-Disposition: inline
In-Reply-To: <20081014161426.552115e5@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jean Delvare <khali@linux-fr.org>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <Jonathan.Cameron@gmail.com>

On Tue, Oct 14, 2008 at 04:14:26PM +0200, ext Jean Delvare wrote:
> I've implied a sysfs interface with my tsl2550 driver, essentially
> derived from the hwmon sysfs interface. I hope you followed it in your
> driver if possible. When these drivers have a new home, we can document
> the sysfs interface. Or, if these drivers end up in the industrial I/O
> subsystem, maybe a completely different interface will be used instead
> (but then it's in Jonathan's hands.)

Hmm, I didn't really write the driver, I'm just fixing a few stuff to
prepare for submission to mainline. If we end up with your sysfs
interface, I can change that, no problem.

-- 
balbi
