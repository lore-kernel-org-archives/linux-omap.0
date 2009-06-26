From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to support
 off-mode
Date: Fri, 26 Jun 2009 14:13:08 +0300
Message-ID: <4A44AD44.4070107@nokia.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com> <1245965646-20070-2-git-send-email-khilman@deeprootsystems.com> <1245965646-20070-3-git-send-email-khilman@deeprootsystems.com> <1245965646-20070-4-git-send-email-khilman@deeprootsystems.com> <1245965646-20070-5-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42215 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbZFZLNL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 07:13:11 -0400
In-Reply-To: <1245965646-20070-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Hello,

Kevin Hilman wrote:
 > From: Rajendra Nayak <rnayak@ti.com>
 >
 > Because of OMAP off-mode, powerdomain can go off when I2C is idle.
 > Save enough state, and do a re-init for each transfer.
 >
 > Additional save/restore state added by Jagadeesh Bhaskar Pakaravoor
 > (SYSC_REG) and Aaro Koskinen (wakeup sources.)
 >
 > Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
 > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
 > Cc: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
 > Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
 > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

This patch introduces a compiler warning:

   CC      drivers/i2c/busses/i2c-omap.o
drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_init':
drivers/i2c/busses/i2c-omap.c:303: warning: unused variable 'v'

So the declaration of "v" should be also removed here:

 > @@ -289,21 +302,22 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 >  		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
 >  			u32 v;
 >
 > -			v = SYSC_AUTOIDLE_MASK;
 > -			v |= SYSC_ENAWAKEUP_MASK;
 > -			v |= (SYSC_IDLEMODE_SMART <<
 > +			dev->syscstate = SYSC_AUTOIDLE_MASK;
 > +			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
 > +			dev->syscstate |= (SYSC_IDLEMODE_SMART <<

A.
