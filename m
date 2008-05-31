From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: x-windows on omap osk
Date: Sat, 31 May 2008 11:28:01 +0530
Message-ID: <a1d91fa0805302258m48359694ocfe98bb1692ec26c@mail.gmail.com>
References: <a1d91fa0805302210g768a22dega1b4b4fe35cdcac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:22982 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbYEaF6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 May 2008 01:58:02 -0400
Received: by ti-out-0910.google.com with SMTP id b6so83840tic.23
        for <linux-omap@vger.kernel.org>; Fri, 30 May 2008 22:58:01 -0700 (PDT)
In-Reply-To: <a1d91fa0805302210g768a22dega1b4b4fe35cdcac3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Hi,
Abraham rightly pointed out that the path should be properly set as:

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/home/mdshareef/xwin_snapshot/xlibs/XExtensions/

and NOT as:

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/scratchbox/users/mdshareef/home/mdshareef/xwin_snapshot/xlibs/XExtensions/

so the problem is solved now.

regards,
Shareef

On Sat, May 31, 2008 at 10:40 AM, mohammed shareef <mdshareef@gmail.com> wrote:
> Hi,
>
> when i compile xlibs-FixesExt, i get the following error:
>
> checking for xextensions... Package xextensions was not found in the
> pkg-config search path.
> Perhaps you should add the directory containing `xextensions.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'xextensions' found
>
> configure: error: Library requirements (xextensions) not met; consider
> adjusting the PKG_CONFIG_PATH environment variable if your libraries
> are in a nonstandard prefix so pkg-config can find them.
>
>
> what does it mean? could someone give the solution?
>
> Regards,
> shareef
>
