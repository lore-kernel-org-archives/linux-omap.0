From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH v4 4/9] OMAP4 : DSS2 : HDMI: HDMI driver header file
 addition
Date: Thu, 10 Mar 2011 11:07:32 +0200
Message-ID: <1299748052.2017.52.camel@deskari>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	 <1299671118-20839-2-git-send-email-mythripk@ti.com>
	 <1299671118-20839-3-git-send-email-mythripk@ti.com>
	 <1299671118-20839-4-git-send-email-mythripk@ti.com>
	 <1299671118-20839-5-git-send-email-mythripk@ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB593024C1922C2@dbde02.ent.ti.com>
	 <AANLkTimyrak4WfxWuiVvGT21k9jc0G6gz=R6=P8osvVj@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB593024C19269B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36185 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1CJJHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 04:07:35 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2A97ZjJ019316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 03:07:35 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2A97YPf011680
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 03:07:34 -0600 (CST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C19269B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 02:52 -0600, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: K, Mythri P
> > Sent: Thursday, March 10, 2011 10:32 AM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org; Valkeinen, Tomi
> > Subject: Re: [PATCH v4 4/9] OMAP4 : DSS2 : HDMI: HDMI driver header file
> > addition
> > 
> 
> [snip]...[snip]
> 
> > >
> > > [sp] Any specific reason to keep header file in separate patch?
> > >
> > When i had posted it earlier there were several compliants  that the
> > patch is huge,
> > if i include header file with the corresponding c file , and hence
> > difficult to review. So it just to make
> > reviewers job easy.
> 
> [sp] Final say on the issue rests with the maintainer. But it I found it
>      difficult to review the .c file with when looking for structure
>      definitions, members etc.
> 
>      If they were together, we wouldn't need this in a separate patch:
>      [PATCH v4 7/9] OMAP4 : DSS : HDMI: Call to HDMI module init to...

It's not a clear thing, but I find it easier to review the patches, if
new large files are added as separate patches.

But it's true that that introduces the need to do some cross checking
between patches, so it's a compromise.

 Tomi


