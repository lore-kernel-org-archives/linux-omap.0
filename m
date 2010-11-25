From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC/PATCH v6 02/12] media: Media device
Date: Thu, 25 Nov 2010 18:06:27 +0000
Message-ID: <20101125180627.16aa89c0@lxorguk.ukuu.org.uk>
References: <1q7hf5w7lvslx3nba6ooh9j2.1290705631030@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52512 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823Ab0KYSHg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 13:07:36 -0500
In-Reply-To: <1q7hf5w7lvslx3nba6ooh9j2.1290705631030@email.android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Clemens Ladisch <clemens@ladisch.de>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, lennart@poettering.net

On Thu, 25 Nov 2010 12:20:31 -0500
Andy Walls <awalls@md.metrocast.net> wrote:

> The signedness of char is ambiguous for 8 bit data, which is why an API would normally use u8 (or s8, I guess).
> 
> Since this is known to be character data, I would think char would be fine.  I am assuming C compilers would never assume multibyte "char"s.

char is 8bit in all modern C. I have used C compilers with configurable 9
or 7 bit char and such a machine is never going to run Linux without
serious insanity. Even grep in 9bit char is not fun...

The advantage of using u8 is that any casting goes the way you expect
whereas when working with UTF-8 things like

	int x = name[0];

may not produce the expected result otherwise.

Alan
