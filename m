From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH-V2] OMAP3EVM: Replace vdvi regulator supply with
 vdds_dsi
Date: Mon, 28 Jun 2010 10:37:53 +0300
Message-ID: <1277710673.2474.13.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1268997679-27869-1-git-send-email-hvaibhav@ti.com>
	 <19F8576C6E063C45BE387C64729E7394044E85304E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52310 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab0F1HiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 03:38:05 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E85304E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Thu, 2010-06-10 at 17:41 +0200, ext Hiremath, Vaibhav wrote:
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Friday, March 19, 2010 4:51 PM
> > To: linux-omap@vger.kernel.org
> > Cc: tomi.valkeinen@nokia.com; tony@atomide.com; Hiremath, Vaibhav
> > Subject: [PATCH-V2] OMAP3EVM: Replace vdvi regulator supply with vdds_dsi
> > 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > 
> > With recent changes happened in OMAP2/3 DSS library for regulator interface,
> > it
> > is required to define DSI regulator supply, without this DSS (in turn Fbdev)
> > fails to get regulator.
> > 
> [Hiremath, Vaibhav] Tony,
> 
> I have also completely missed about this patch, and today I realized that this patch is not merged.
> 
> Tony,
> 
> I have verified that this patch still gets applied cleanly ontop of linux-omap/master.
> 
> Can it be merged, without this Video Display won't work on EVM?

I have taken this patch into my tree (again). Let's see if we manage to
handle it without conflicts this time =).

 Tomi


