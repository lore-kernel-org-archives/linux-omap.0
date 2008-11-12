From: "Sudipta GHOSH" <sudipta.in@gmail.com>
Subject: twl4030 i2c problem
Date: Wed, 12 Nov 2008 12:17:24 +0200
Message-ID: <9e6474ae0811120217l101f7a12tbb2287779651fd32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:38141 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbYKLKRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 05:17:25 -0500
Received: by rv-out-0506.google.com with SMTP id k40so355704rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 02:17:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am having some problem with i2c.

In my env I cant make i2c working.

During boot, Twl4030 tries to send few i2c data, but it didnt going ok.

static void twl_init_irq(void), issues many i2c write but fails with
error -121 (EREMOTEIO).

I tries to some twl4030 i2c read and write from video driver but also
failes with same error.

My env and my board is based on OMAP2. I have configured the kernel to
use board-add08.

with some debugging I found dev->cmd_err is 2.

any idea?

is there any special initialization needed for twl4030?

-SG
