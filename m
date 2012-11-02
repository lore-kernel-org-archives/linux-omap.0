From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Fri, 2 Nov 2012 13:11:50 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFD849@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41055 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab2KBNMA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 09:12:00 -0400
In-Reply-To: <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Fri, Nov 02, 2012 at 18:02:46, Bedia, Vaibhav wrote:
[...]
> +int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg)
> +{
> +	return 0;
> +}

This should have been static. Will change in the next version.
