From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Thu, 11 Mar 2010 09:28:42 +0200
Message-ID: <20100311072842.GE20878@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
 <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
 <20100305070330.GB12757@nokia.com>
 <20100308230422.GH2900@atomide.com>
 <20100309143020.GA12260@gandalf>
 <20100309153827.GR2900@atomide.com>
 <20100309154754.GI3851@gandalf>
 <20100310004826.GD2900@atomide.com>
 <20100310062159.GB3878@gandalf>
 <20100310171548.GI2900@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16647 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab0CKH3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 02:29:36 -0500
Content-Disposition: inline
In-Reply-To: <20100310171548.GI2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

hi,

On Wed, Mar 10, 2010 at 06:15:49PM +0100, ext Tony Lindgren wrote:
>Updated patch below, is this what you want to do? Maybe reply with
>an updated patch if you want usb_ehci_init not to use const?

I'm happy with your version.

>Also, there are other ehci related warnings, see the attached
>file for that.

I saw those other warnings and they come from the framework and are 
normal. If I remember Anand had put a patch on ehci-hub.c to kill those 
warnings, maybe it didn't get applied yet.

-- 
balbi
