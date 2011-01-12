From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Wed, 12 Jan 2011 16:50:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60686 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab1ALXus (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 18:50:48 -0500
In-Reply-To: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Wed, 12 Jan 2011, Bryan Wu wrote:

> We are trying to build kernel package or GCC natively on OMAP4 panda
> board. With the mainline 2.6.37 kernel or Ubuntu Natty 2.6.35 based
> kernel, we met same instabilities on the system when we try to use
> mem=1G on the board.
> 
> Please find our bug tracker here:
> https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/633227
> and I think another bug is also related:
> https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/690370.
> System will freeze at all when building GCC natively on Panda.
> 
> Did any folks meet this issue? or we need more simple test case to
> catch the root cause of this issue.

Does the problem also happen if you boot with 'nosmp' on the kernel 
command line?


- Paul
