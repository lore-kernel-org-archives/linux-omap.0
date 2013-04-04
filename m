From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 4 Apr 2013 08:47:26 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED8AFAA@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
	<1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
 <CACTFLAM=69kZOGoJU8_tBfrJKmDTivpF8ZC8R95anHHA37f7_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58974 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933714Ab3DDIrj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 04:47:39 -0400
In-Reply-To: <CACTFLAM=69kZOGoJU8_tBfrJKmDTivpF8ZC8R95anHHA37f7_A@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi Daniel,

On Wed, Apr 03, 2013 at 17:22:41, Daniel Mack wrote:
> Hi Vaibhav,
> 
> On Mon, Dec 31, 2012 at 2:07 PM, Vaibhav Bedia <vaibhav.bedia@ti.com> wrote:
> > AM335x supports various low power modes as documented
> > in section 8.1.4.3 of the AM335x TRM which is available
> > @ http://www.ti.com/litv/pdf/spruh73f
> 
> May I ask about the plans for this series? Will you be re-spinning
> them for a current
> tree, and what's the planned merge window for it?
> 

I am tied up in some other stuff right now. I plan to address Kevin's comments
and repost the patches soon. Since rc5 is already out i think v3.10 is not
a realistic target any more but I do hope to have this accepted for v3.11.

Regards,
Vaibhav
