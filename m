From: Kalle Valo <kalle.valo@nokia.com>
Subject: Re: Android on N810 File System Problem
Date: Wed, 30 Apr 2008 12:49:12 +0300
Message-ID: <87bq3ry8o7.fsf@nokia.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
	<48116F5C.9040009@googlemail.com>
	<20080425183605.GA27479@kedavra.cpe.vivax.com.br>
	<87fxt7my4o.fsf@nokia.com>
	<20080427223248.GA5962@kedavra.cpe.vivax.com.br>
	<20080428233827.GE8449@atomide.com>
	<20080429090032.GA25363@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59833 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144AbYD3Jtc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 05:49:32 -0400
In-Reply-To: <20080429090032.GA25363@bulgaria.corp.google.com> (ext Brian Swetland's message of "Tue\, 29 Apr 2008 02\:00\:32 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

Brian Swetland <swetland@google.com> writes:

> [Tony Lindgren <tony@atomide.com>]
>> 
>> I've merged Jarkko's asoc patch to linux-omap for testing. Have not
>> gotten any sound out of it on my n810 though.. Maybe some alsamixer
>> settings issue?
>> 
>> Kalle, do you have any tips on getting WLAN to work on n8x0?
>
> This was the show-stopper for me.  When I last got things hobbling
> along on n8x0, the binary-only wlan module was incompatible with
> newer kernels than 2.6.21 (changes in some network data structures).

That's exactly the problem. I have written something about it here:

https://garage.maemo.org/pipermail/cx3110x-devel/2007-December/000007.html

Currently there's nothing I can do to resolve the issue,
unfortunately.

-- 
Kalle Valo
