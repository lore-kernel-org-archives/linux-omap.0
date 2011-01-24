From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Mon, 24 Jan 2011 10:45:22 -0500
Message-ID: <87k4hu8fvx.fsf@gmail.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com> <87fwsqm3b2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41596 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab1AXPp2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 10:45:28 -0500
In-Reply-To: <87fwsqm3b2.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

On Tue, 18 Jan 2011 14:15:13 -0500, Ben Gamari <bgamari.foss@gmail.com> wrote:
> On Mon,  6 Dec 2010 13:43:31 +0530, Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
> > As the control.h have been moved to new location and it's
> > uses are not allowed to drivers directly so moving the phy
> > control, interrupt clear and reset functionality to board
> > files.
> > 
> What happened to the board changes for board-am3517evm?

Ping. A response would be appreciated.

Cheers,

- Ben
