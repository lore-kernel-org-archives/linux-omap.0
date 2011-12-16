From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 16 Dec 2011 23:57:17 +0800
Message-ID: <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51349 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759889Ab1LPP5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 10:57:21 -0500
Received: by wgbds13 with SMTP id ds13so3290731wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 07:57:20 -0800 (PST)
In-Reply-To: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Hi,

On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> wrote:

> Also I have tried to add 'l3_2_clkdm' into dependency table of iss_clkdm in [2],
> and it doesn't work.

Also, I still have the question why the static dependency isn't generated from
the table .wkdep_srcs of struct clockdomain? Seems the static dep info has been
put inside the tables.

thanks,
-- 
Ming Lei
