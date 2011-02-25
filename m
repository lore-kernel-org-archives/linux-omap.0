From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/1] power_supply: twl4030_charger modification
Date: Fri, 25 Feb 2011 14:12:34 +0200
Message-ID: <20110225121234.GI4190@legolas.emea.dhcp.ti.com>
References: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56348 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753037Ab1BYMMj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 07:12:39 -0500
Received: by bwz13 with SMTP id 13so2519044bwz.17
        for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 04:12:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@nokia.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, notasas@gmail.com, cbouatmailru@gmail.com

On Fri, Feb 25, 2011 at 01:56:35PM +0200, Heikki Krogerus wrote:
> Hi guys,
> 
> Grazvydas, I don't have hardware to test this with. If this is OK to
> you, could you test it?
> 
> Felipe, was the idea that you take this with the atomic notifier
> support for otg patches? I guess this is how it needs to be done in
> order to keep things bisectable, right? Or does this simply go to
> Anton?

We can't change patches anymore :-( So as long as it goes on the merge
window, we should be ok, hopefully.

-- 
balbi
