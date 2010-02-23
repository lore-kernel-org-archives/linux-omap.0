From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] musb: fix power field to hold all possible values
Date: Tue, 23 Feb 2010 15:27:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321A20364@dbde02.ent.ti.com>
References: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
 <20100223095154.GA12815@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34974 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab0BWJ5p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 04:57:45 -0500
In-Reply-To: <20100223095154.GA12815@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi wrote:

> Hi,
> 
> On Tue, Feb 23, 2010 at 03:16:44PM +0530, Ajay Kumar Gupta wrote:
> > MUSB can supply upto 500mA such as, AM3517 and OMAP3EVM Rev >=E and thus
> > the 'power' field has to hold values above 255.
> 
> power on the arch code is same as bMaxPower it will be multiplied by two
> on musb_core.c. See line 150 of that file.
> 
> Meaning 500mA is set to 250 on the board-file.
> 

Any reason we have the "multiply by 2" there?

- Anand
