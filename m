From: Mike Turquette <mturquette@ti.com>
Subject: Re: [RFC 00/24] Move OMAP2+ over to use COMMON clock
Date: Fri, 1 Jun 2012 10:58:46 -0700
Message-ID: <20120601175846.GA23978@gmail.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:38776 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933511Ab2FAR6z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 13:58:55 -0400
Received: by obbwd20 with SMTP id wd20so3489996obb.4
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 10:58:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 20120601-17:37, Rajendra Nayak wrote:
> Hi,
> 
> This RFC series is based of Mikes' latest clk-next. I will
> rebase it once 3.5-rc1 is out and post with more testing thats
> in progress. Meanwhile, the RFC is for me to get some early
> feedback on the patches.
> 
> This series retains the static clock declarations

Hi Rajendra,

Thanks for sending this out.  FYI I'm looking into using bootmem to get
rid of the terrible static init macros.  That's just something to
consider for the future since I do not know when I will have time to
implement that.

Hopefully that change could make it possible to get rid of the static
init macros entirely.  It won't block acceptance of these patches
though.

Regards,
Mike
