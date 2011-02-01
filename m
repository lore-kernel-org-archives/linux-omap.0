From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Tue, 1 Feb 2011 09:26:43 +0200
Message-ID: <20110201072643.GK2675@legolas.emea.dhcp.ti.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com>
 <87fwsqm3b2.fsf@gmail.com>
 <87k4hu8fvx.fsf@gmail.com>
 <20110127044810.GJ2429@legolas.emea.dhcp.ti.com>
 <877hdq8r50.fsf@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36407 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752080Ab1BAH0s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 02:26:48 -0500
Content-Disposition: inline
In-Reply-To: <877hdq8r50.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Jan 27, 2011 at 07:31:23AM -0500, Ben Gamari wrote:
> On Thu, 27 Jan 2011 06:48:10 +0200, Felipe Balbi <balbi@ti.com> wrote:
> > sorry, quite busy at the moment, but here's one answer. Check this
> > commit:
> > 
> > commit a9c037832e9624e240c5019d0e01e9352e8f638d
> > ...
> 
> Thanks for the reply! So I take it that omap's usb_musb_init takes care
> of all of the new *_board_data fields now and therefore no board changes
> are necessary?

correct.

-- 
balbi
