From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc5 0/5] twl4030 irq assignments
Date: Wed, 19 Nov 2008 17:09:28 -0800
Message-ID: <200811191709.28974.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:25965 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752524AbYKTBei (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 20:34:38 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The following patches remove some needless dependencies from
TWL4030 support, supporting non-OMAP builds and in some cases,
non-SDP (etc) builds.

 - keypad driver ... use platform_get_irq(), no board dependencies
 - BCI driver ... likewise
 - MADC driver ... use platform_get_irq()
 - power button ... still pretty hacky, there's no device here
 - removes the now-dead symbols, and OMAP-dependency

Build-tested.

With this, I think the keypad driver becomes ready to go upstream,
after related twl4030-core updates.  At least, it's ready for review.
(Including:  Why pass the keypad module id to kpread/kpwrite, it's
the only one ever used?  Why does Kconfig mention GPIOs, since they
aren't used?)

The point of these patches is that last one, which lets non-OMAP
folk do test builds and easily make updates when APIs change.
Yeah, it's a strange notion, but not everyone does OMAP builds.  ;)

- Dave



