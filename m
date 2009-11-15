From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Modifying the kernel keymap
Date: Mon, 16 Nov 2009 00:31:05 +0200
Message-ID: <1258324265.10351.1.camel@gandalf>
References: <6cb013310911151206s2496a6edxb3101d2d96c8dea0@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59839 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbZKOWbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 17:31:05 -0500
In-Reply-To: <6cb013310911151206s2496a6edxb3101d2d96c8dea0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Sun, 2009-11-15 at 12:06 -0800, Cory Maccarrone wrote:
> All,
> 
> I'm working with the Wing Linux and Linwizard projects in porting
> various omap850-based devices to Linux, and was wondering about
> keymaps.
> 
> In particular, I'm working with the HTC Herald, which uses an Alt key
> to access things like numbers and symbols on a physical keyboard.  In
> Linux, the keymappings are wrong for this -- Alt does something
> different and doesn't allow access to those extra characters.
> 
> In Linwizard, we've modified the defkeymap and added makefile rules to
> compile our modified defkeymap when a specific board was selected, but
> this isn't portable when building a kernel for many boards at once,
> each having a different mapping.
> 
> So, my question is, what is the best way to go about changing the
> defkeymap, or supplying a keymap that allows all the keys to function
> correctly, but doesn't require non-portable makefile hacks?

how about letting xmodmap handle that ? If you use alt key, then kernel
passes alt key. Userland can later remap that key to some other
function.

-- 
balbi


