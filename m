From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] omap3: ehci: remove chargepump hack
Date: Thu, 24 Sep 2009 17:49:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C5936@dbde02.ent.ti.com>
References: <1253794017-25552-1-git-send-email-gadiyar@ti.com>
 <20090924121051.GG4186@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54664 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbZIXMT5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 08:19:57 -0400
In-Reply-To: <20090924121051.GG4186@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> On Thu, Sep 24, 2009 at 02:06:57PM +0200, ext Anand Gadiyar wrote:
> > omap3: ehci: remove chargepump hack
> > 
> > This hack was for a very early development board that is no longer
> > in use. Remove it. No board should require it.
> 
> do we have anyone using it besides development boards ?
> 

Not sure I understand the question. If you meant "is anyone other than
development boards using the chargepump hack", then the short answer is no.

The chargepump hack was only for one particular reference design board - the
very first version of it. Only 6-odd boards were made which needed that hack.
It's long gone from internal codebases, as are the boards.

As far as I know, no board in the wild will need it. If you look at the
patch, only the 3430 SDP board set this flag to true, and all others
were false. I confirm that all later versions of the expansion board in use
with the 3430SDP do not require this hack.

So there's no point having it around.

- Anand
