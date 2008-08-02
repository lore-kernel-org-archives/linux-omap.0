From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 11:21:37 +0300
Message-ID: <20080802082136.GA8213@frodo>
References: <8cef9d540807311747k614eba83p5a783960c7613ec8@mail.gmail.com> <593912.7876.qm@web53203.mail.re2.yahoo.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52094 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYHBIVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Aug 2008 04:21:44 -0400
Content-Disposition: inline
In-Reply-To: <593912.7876.qm@web53203.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emanoil Kotsev <deloptes@yahoo.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hi,

On Sat, Aug 02, 2008 at 12:47:44AM -0700, Emanoil Kotsev wrote:
> I gave up the discussion because it leads to nothing. Greg says I'm missing the point but I think they miss my (our) point.
> 
> I also think they don't use linux on server or embeded equipment and don't have the responsibility to ralay on something stable, so they do not understand my (our) point.

Stop speculating, I'm one developing kernel for maemo devices and I use
recent kernel on my devices, for developing/debugging/testing purposes.
Most of our development is done together with linux-omap community.

> Anyway I've installed the 2.6.26 kernel and now few things are not working of course wit hthis version, so where is the point of this installation I DO NOT understand. I have to go back to 2.6.24 anyway.

And now you report the bugs you found in 2.6.26...

> Of course few other things are working better, so somehow all of us are right.
> 
> My point is that it would be VERY nice if kernel developers DO SUPPORT one version for longer time and provide bug fixes. May be it could be done in a separate tree, but it would help people working with exotic hardware to propagade linux.

And that's called stable tree:

http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.24.y.git;a=summary
http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.25.y.git;a=summary
http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.26.y.git;a=summary

> I think we as comunity should support each other, as the most people here do. The problem was with the neglecting statement that something is old afer beeing few months old, so I was thinking may be Felipe and Greg are buying a new house because they don't like the sink in their present one ;-)

This analogy was really bad and you know that, I suppose.

Did you see greg's talk about the kernel development process ? Really,
do it.

-- 
balbi
