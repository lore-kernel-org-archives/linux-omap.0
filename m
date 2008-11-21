From: "Amit Pundir" <pundiramit@gmail.com>
Subject: Re: defconfig for omap3-evm
Date: Fri, 21 Nov 2008 17:43:49 +0530
Message-ID: <52c7556c0811210413jb6616ddj51950b59897ffc47@mail.gmail.com>
References: <52c7556c0811210359n73256679pd50f391c48af5530@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403E8E67DEC@dbde02.ent.ti.com>
	 <52c7556c0811210408k62cd7d4cxfa8b677f978ef68a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:39768 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbYKUMNv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 07:13:51 -0500
Received: by ti-out-0910.google.com with SMTP id b6so612148tic.23
        for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 04:13:49 -0800 (PST)
In-Reply-To: <52c7556c0811210408k62cd7d4cxfa8b677f978ef68a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The reason I moved to linux-omap kernel from the provided with EVM is
that I was not able to run my Xorg server on omap-3.

So I raised my concern in Xorg mailing list regarding my problem i.e.
running X on
omap3-evm. In reply they told me that "the problem is the TI's omapfb
which won't let you set arbitrary modes. The mainstream one (i.e. the
one in linux-omap) works fine with fbdev."

Can anyone please confirm that it is a known issue with TI provided kernel.


Regards
Amit Pundir
