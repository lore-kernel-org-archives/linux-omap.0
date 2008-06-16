From: James Carlson <carlsonj@workingcode.com>
Subject: Re: ppp on 2.6.18
Date: Mon, 16 Jun 2008 10:23:53 -0400
Message-ID: <18518.30585.717869.634719@gargle.gargle.HOWL>
References: <a1d91fa0806160536r646577e2n7099431aa934a556@mail.gmail.com>
	<48566242.1080306@katalix.com>
	<18518.29942.550676.275051@gargle.gargle.HOWL>
	<a1d91fa0806160719u3dc02e20w50f7e02570cd21f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from carlson.workingcode.com ([75.150.68.97]:39510 "EHLO
	carlson.workingcode.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbYFPOYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2008 10:24:10 -0400
In-Reply-To: mohammed shareef's message of 16 June 2008 19:49:35
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: James Chapman <jchapman@katalix.com>, omap <linux-omap@vger.kernel.org>, linux-ppp@vger.kernel.org

mohammed shareef writes:
> I downloaded a 2.4.4 ppp package and did the following to compile it
> for my omap-osk:
> 
> ./configure --host=arm-linux --prefix=/root/Desktop/pppbuild
> make
> make install
> 
> then i copied the binaries to the filesystem of my omap. but when i
> say: "pppd -h" the system hangs. i guess this is because my filessytem
> files are not proper or i didnt compile them properly.

That sounds like a fairly basic problem with your platform.  The '-h'
option just prints out some simple explanatory text and exits.  It's
the pppd equivalent of a "hello, world" program.  It doesn't do much
at all.

If that doesn't work, then I'd expect that either your cross-compiler
is misconfigured, or there are serious problems in the platform
itself.  Either way, I don't think I can help.

-- 
James Carlson         42.703N 71.076W         <carlsonj@workingcode.com>
