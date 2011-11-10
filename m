From: Grant Erickson <marathon96@gmail.com>
Subject: Re: Which toolchain are we using?
Date: Thu, 10 Nov 2011 09:07:04 -0800
Message-ID: <CAE144B8.32218%marathon96@gmail.com>
References: <E28AAFD00EFAA646AE3DF9B89CD24A8903B687@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:48284 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933053Ab1KJRHO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Nov 2011 12:07:14 -0500
Received: by pzk36 with SMTP id 36so1795860pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 09:07:14 -0800 (PST)
In-Reply-To: <E28AAFD00EFAA646AE3DF9B89CD24A8903B687@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/10/11 12:47 AM, Premi, Sanjeev wrote:
> I have been running latest linux-omap/master on OMAP3EVM (boot from MMC).
> When building with CodeSourcery 2011.03-41, I see frequent "hangs" just
> after "Uncompressing Linux... done, booting the kernel"
> 
> However, builds with CodeSourcery 2009q1-203 boot consistently all the
> time.
> 
> Before trying to investigate further, wanted to know if someone else has
> seen the problem. If no, which toolchain is being used.

Sanjeev:

I've seen this behavior with kernels as far back as 2.6.32. The solutions
explored in discussions on the Web seem to be around soft- vs. hardware
alignment exception handling.

Mentor is aware of the issue but has no specific recommendations at this
time.

Best,

Grant


