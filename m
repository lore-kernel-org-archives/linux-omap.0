From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: Incorrect Register Offsets in OMAP Mailbox
Date: Fri, 10 Feb 2012 04:25:54 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433179C534@DBDE01.ent.ti.com>
References: <331ABD5ECB02734CA317220B2BBEABC1317897C8@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433179B3F8@DBDE01.ent.ti.com>
 <20120209174709.GH1426@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433179BF04@DBDE01.ent.ti.com>
 <20120210011447.GN1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34287 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab2BJE0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 23:26:03 -0500
In-Reply-To: <20120210011447.GN1426@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "enli.chan@gmail.com" <enli.chan@gmail.com>

Hi Tony,

On Fri, Feb 10, 2012 at 06:44:47, Tony Lindgren wrote:
> * Bedia, Vaibhav <vaibhav.bedia@ti.com> [120209 09:27]:
> > On Thu, Feb 09, 2012 at 23:17:10, Tony Lindgren wrote:
> > > Care to reply with Acked-by/Tested-by so I can queue this into fixes?
> > > 
> > 
> > Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> Is the mailbox now actually usable on this hardware with this patch?
> 

I am using this fix to make use of the mailbox on AM335x which has the same IP
as OMAP4. With a couple of patches to add AM335x support I have been able to make
use of the mailbox for one-way communication between the A8 and Cortex-M3.

I don't have an OMAP4 board with me to test this out.

Regards,
Vaibhav
