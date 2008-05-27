From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: omap 0sk and mistral touchscreen..
Date: Tue, 27 May 2008 21:41:09 +0300
Message-ID: <20080527184109.GB18735@kedavra.cpe.vivax.com.br>
References: <a1d91fa0805252349w266c2f8x11377f2dce066b93@mail.gmail.com> <cb8016980805260842m2f06e9e8yb39fd91f1384d921@mail.gmail.com> <a1d91fa0805262126v65745282k4ac45d3e71c1894f@mail.gmail.com> <001101c8bfb7$01e58ac0$310da8c0@mistral.in> <a1d91fa0805262232g4a441f5fwdb62a7015b1f0e84@mail.gmail.com> <cb8016980805262237q54980f33y6a58d7fdf25328f5@mail.gmail.com> <a1d91fa0805262239m10ae2836p776c94207852e19f@mail.gmail.com> <a1d91fa0805262330h5e3990b9u1ce4577d3fc269fa@mail.gmail.com> <a1d91fa0805270642i66744055oe2f3f72863065995@mail.gmail.com> <a1d91fa0805270702g41f95fdfi21cbd4a5a806951e@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60251 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756905AbYE0Skn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2008 14:40:43 -0400
Content-Disposition: inline
In-Reply-To: <a1d91fa0805270702g41f95fdfi21cbd4a5a806951e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: Abraham Arce <abraham.arce.moreno@gmail.com>, "S. Rajeev" <srajeev@mistralsolutions.com>, omap <linux-omap@vger.kernel.org>

On Tue, May 27, 2008 at 07:32:12PM +0530, mohammed shareef wrote:
> Hi,
> everything looks fine from the kernel side. I think the problem might
> be in the file system. i have used the following options to get the
> touchscreen files compiled from tslib:
> 
> ./autogen.sh
> 
> ./configure --prefix=/tslib --host=arm-linux-gnu
> 
> make
> 
> make install
> 
> is it right?

Are you compiling inside the arm system??
doesn't tslib has a --target=<arch> flag??

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
