From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Mon, 17 Jun 2013 13:01:29 -0700
Message-ID: <20130617200129.GG28497@quad.lixom.net>
References: <CAFiDJ5_1w+M6TTroeQEjOcc5GNN2RCmLN4ZB5dxQNwoc+9R1YQ@mail.gmail.com>
 <51BE1C89.5080800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50943 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3FQUBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 16:01:23 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so3216098pad.37
        for <linux-omap@vger.kernel.org>; Mon, 17 Jun 2013 13:01:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51BE1C89.5080800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: "LF.Tan" <lftan.linux@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux@arm.linux.org.uk, loic.pallardy@st.com, tony@atomide.com, Linus Walleij <linus.walleij@linaro.org>, omar.ramirez@copitl.com, linux-omap@vger.kernel.org, jaswinder.singh@linaro.org

On Sun, Jun 16, 2013 at 03:14:01PM -0500, Suman Anna wrote:
> Hi Tan,
> 
> On 06/14/2013 04:32 AM, LF.Tan wrote:
> > 
> > Hi Suman
> > 
> > Thanks for your reply.
> > I have took a look the patches you've mentioned in [1]. It is totally
> > new framework from what is located in linux-next git tree now.
> 
> Yes, that is correct. The framework is different, but functionality
> wise, you should be able to achieve the same (and a bit more).

I noticed that we had accidentally merged the previous version of the
framework, since it was never intended to sit in linux-next given the
redesign underway. I dropped it on Friday, so it wasn't included in the
latest build of linux-next, and should not be part of it from here on out.


-Olof
