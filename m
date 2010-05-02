From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: mailbox_mach dependency problem
Date: Sun, 2 May 2010 18:59:04 +0300
Message-ID: <20100502155903.GA2246@gandalf>
References: <h2g94a0d4531005010747n6ef7b7d0r9b4714d289d61032@mail.gmail.com>
 <20100501173328.GA4706@gandalf>
 <w2y94a0d4531005011608kda24768ep87897ec46b39641e@mail.gmail.com>
 <20100502071354.GA2360@gandalf>
 <v2k94a0d4531005020557w60b0ca34q3703ddf39d0d82aa@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57381 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab0EBP62 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 11:58:28 -0400
Content-Disposition: inline
In-Reply-To: <v2k94a0d4531005020557w60b0ca34q3703ddf39d0d82aa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <hiroshi.doyu@gmail.com>

Hi,

On Sun, May 02, 2010 at 03:57:42PM +0300, Felipe Contreras wrote:
> Indeed, that was my understanding, but the mailbox doesn't seem to be
> designed that way. Apparently the driver has an internal linked list
> of mailboxes, and the platform device registers a bunch of them.
> Effectively they need each other.

you could make it the other way around. For each registered
platform_device you instantiate one mailbox and add it to the list on
the fly, you would probably like to use a list_head for that also
instead of having your own list implementation.

if you do that, you leave the mbox "instantiation" up to the
platform_device code. You would simply register several omap-mbox with a
different id for each mbox you need. Then the name could be sent using a
well-defined platform_data. Just a suggestion.

-- 
balbi
