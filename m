From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 23 Dec 2010 12:16:22 -0500
Message-ID: <87hbe41kbd.fsf@gmail.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64225 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0LWRQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 12:16:30 -0500
In-Reply-To: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

On Fri,  3 Dec 2010 23:42:45 +0530, Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
> As the control.h have been moved to new location and it's
> uses are not allowed to drivers directly so moving the phy
> control, interrupt clear and reset functionality to board
> files.
> 
Is this change slated to go into 2.6.37? As it stands it looks like
2.6.37 will be released with completely broken musb support on many boards
(including the BeagleBoard).

- Ben
