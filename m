From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
Date: Fri, 2 Dec 2011 18:14:48 +0000
Message-ID: <DF0F476B391FA8409C78302C7BA518B6039FFA@DBDE01.ent.ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-4-git-send-email-hvaibhav@ti.com> <878vmxump8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51850 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932066Ab1LBSPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 13:15:02 -0500
In-Reply-To: <878vmxump8.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Patil, Rachna" <rachna@ti.com>

On Thu, Dec 01, 2011 at 06:34:19, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > From: Afzal Mohammed <afzal@ti.com>
> >
> > This patch adds AM33XX power domain data,
> > corresponding API's to access PRM module and
> > PRM register offsets & bit fields.
> >
> > Signed-off-by: Rachna Patil <rachna@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> 
> First some general comments:
> 
> At first glance, it seems like there could be much more reuse with OMAP4
> code here.  From what I see, AM33x has only one partition compared to
> several on OMAP4, but that doesn't mean you couldn't reuse the OMAP4
> functions and just use a single partition.
> 
> IOW, it seems to me that all the pwrdm_ops could be shared with OMAP4.
> 
> From what I read (after an admittedly quick glance), the main thing you
> need is a way to override the PRM offsets due to the fact that some
> crazy person decided to make each instance different.

If its any consolation, this has been fed back to the
chip designers and is expected to be corrected for the
next AM335x derivative.

Thanks,
Sekhar

