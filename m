From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [ask] Keypad Driver in zoom ldp
Date: Sat, 26 Dec 2009 23:14:33 +0200
Message-ID: <1261862073.28789.28.camel@gandalf>
References: <d9ca78710912261213yb192dc7vb69083eb8917acfd@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54089 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbZLZVOg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Dec 2009 16:14:36 -0500
In-Reply-To: <d9ca78710912261213yb192dc7vb69083eb8917acfd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Sun, 2009-12-27 at 03:13 +0700, Tar Gz wrote:
> Hi all,
> 
> where i can download source for keypad driver for ldp board?...

it's located under drivers/input/keyboard/twl4030_keypad.c of any kernel
source tree. Here's a link to gitweb interface:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/input/keyboard/twl4030_keypad.c;h=eeaa7acb9cfcfcc4ebf847a7035874a60c169d72;hb=6b7b284958d47b77d06745b36bc7f36dab769d9b

-- 
balbi

