From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] musb: fix power field to hold all possible values
Date: Tue, 23 Feb 2010 13:04:02 +0200
Message-ID: <20100223110401.GA11891@gandalf>
References: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
 <20100223095154.GA12815@gandalf>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321A20364@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58599 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0BWLEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 06:04:11 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321A20364@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Feb 23, 2010 at 03:27:39PM +0530, Gadiyar, Anand wrote:
> > power on the arch code is same as bMaxPower it will be multiplied by two
> > on musb_core.c. See line 150 of that file.
> > 
> > Meaning 500mA is set to 250 on the board-file.
> > 
> 
> Any reason we have the "multiply by 2" there?

no big reason. It's just legacy code. Maybe it's to keep consistency
with the gadget framework, donno.

-- 
balbi

