From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH v4 4/9] OMAP4 : DSS2 : HDMI: HDMI driver header file
 addition
Date: Thu, 10 Mar 2011 14:22:59 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C19269B@dbde02.ent.ti.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299671118-20839-2-git-send-email-mythripk@ti.com>
	<1299671118-20839-3-git-send-email-mythripk@ti.com>
	<1299671118-20839-4-git-send-email-mythripk@ti.com>
	<1299671118-20839-5-git-send-email-mythripk@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C1922C2@dbde02.ent.ti.com>
 <AANLkTimyrak4WfxWuiVvGT21k9jc0G6gz=R6=P8osvVj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53694 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab1CJIxI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 03:53:08 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2A8r5LM016125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 02:53:07 -0600
In-Reply-To: <AANLkTimyrak4WfxWuiVvGT21k9jc0G6gz=R6=P8osvVj@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

> -----Original Message-----
> From: K, Mythri P
> Sent: Thursday, March 10, 2011 10:32 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; Valkeinen, Tomi
> Subject: Re: [PATCH v4 4/9] OMAP4 : DSS2 : HDMI: HDMI driver header file
> addition
> 

[snip]...[snip]

> >
> > [sp] Any specific reason to keep header file in separate patch?
> >
> When i had posted it earlier there were several compliants  that the
> patch is huge,
> if i include header file with the corresponding c file , and hence
> difficult to review. So it just to make
> reviewers job easy.

[sp] Final say on the issue rests with the maintainer. But it I found it
     difficult to review the .c file with when looking for structure
     definitions, members etc.

     If they were together, we wouldn't need this in a separate patch:
     [PATCH v4 7/9] OMAP4 : DSS : HDMI: Call to HDMI module init to...

~sanjeev

