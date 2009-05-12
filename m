From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: OMAP4 naming conventions
Date: Tue, 12 May 2009 20:48:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B48439C4@dbde02.ent.ti.com>
References: <87tz3qe5ay.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38899 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbZELPSW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 11:18:22 -0400
In-Reply-To: <87tz3qe5ay.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, May 12, 2009 8:29 PM
> To: linux-omap@vger.kernel.org
> Cc: Shilimkar, Santosh
> Subject: OMAP4 naming conventions
> 
> As the OMAP4 patches are coming in, there seems to be a bit of variety
> in the naming of functions/macros/variables etc.
> *
> Could I propose that we just use omap4_* and OMAP4_* instead of
> OMAP44XX_* or OMAP4XXXX_* etc.
> 
> I know that OMAP2 and OMAP3 have a variety of forms here too, but
> those should probably be cleaned up eventually too.
> 
> With proper runtime revision detecting, IMO, we should only really
> have the OMAP4 prefix, and leave the sub revision handling to runtime
> code.
> 
> Thoughts?

Tony has also proposed this during the review. Current macros are using only OMAP44XX_* . And these can be changed to OMAP4_*

Regards,
Santosh
 