From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 07/18] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod
 with the right flags
Date: Wed, 13 Feb 2013 10:56:50 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED1CDEA@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
	<1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com>
 <87fw12xw70.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60793 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451Ab3BMK5C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 05:57:02 -0500
In-Reply-To: <87fw12xw70.fsf@linaro.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Kevin,

On Tue, Feb 12, 2013 at 05:03:23, Kevin Hilman wrote:
> Vaibhav Bedia <vaibhav.bedia@ti.com> writes:
> 
> > TPTC0 needs to be idled and put to standby under SW control.
> 
> Please elaborate about why (e.g. HW support not available, HW support
> broken/buggy, etc.) since these blocks are not well documented in the
> docs that I have (spruh73f.)
> 

This change was picked up for v3.9. I'll submit a follow-up patch adding
in a comment in the hwmod file for this.

Regards,
Vaibhav 

