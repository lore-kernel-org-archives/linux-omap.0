From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: zlib error in x-windows on omap osk
Date: Sat, 31 May 2008 12:03:35 +0300
Message-ID: <20080531090335.GA8786@kedavra.cpe.vivax.com.br>
References: <a1d91fa0805302340q10d4a00dn12087f0cf0e8c3dc@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53866 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbYEaJDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 May 2008 05:03:18 -0400
Content-Disposition: inline
In-Reply-To: <a1d91fa0805302340q10d4a00dn12087f0cf0e8c3dc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>

On Sat, May 31, 2008 at 12:10:31PM +0530, mohammed shareef wrote:
> Hi all,
> 
> when i run the autogen script for Xfonf in xlibs for x-windows, i get
> the following error..
> 
> checking for gzopen in -lz... no
> configure: error: *** zlib is required
> [sbox-ARM-GLIBC: ~/xwin_snapshot/xlibs/Xfont] >
> 
> 
> i have already installed zlib..
> all the previous xlib files compiled without any error.

how about zlib-dev?

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
