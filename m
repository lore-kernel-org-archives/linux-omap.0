From: Haribabu Narayanan <haribabu@iastate.edu>
Subject: linux on sdp2420
Date: Fri, 6 Nov 2009 01:16:20 -0600
Message-ID: <965945430911052316g72370d3sae87ecc799373212@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58210 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbZKFHQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 02:16:35 -0500
Received: by yxe17 with SMTP id 17so700163yxe.33
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2009 23:16:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,

    I am trying to get the latest possible working linux kernel on SDP
2420 board.  I have managed to get 2.6.14
(http://linux.omap.com/pub/kernel/2430sdp/source/) to boot on this.
However, the later versions of kernel in the TI site (pointing to
linux.omap.com) don't compile for H4 (is it no longer supported?).

    It would be great if you guys can provide your inputs on the
following doubts:

1. Will the OMAP git kernel be of any use w.r.t 2420? Or is 2420
completely unsupported after 2.6.14?
2. Has anybody ever got wireless to work on 2420 (2.6.14 or others)?
I need to get a 802.11 connection working on that board and not sure
what is the level of kernel/drivers support for that.  I should be ok
with any underlying connectivity (miniPCI, SDIO or USB) as long as I
can work on the code.
3. Is OMAP2420 data sheet not available in public?

-hari
