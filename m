From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Fri, 22 Aug 2008 10:57:57 +0300
Message-ID: <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	<5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22710 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYHVH6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 03:58:09 -0400
In-Reply-To: <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 21 Aug 2008 14:51:04 -0700
"ext Steve Sakoman" <sakoman@gmail.com> wrote:

> I will submit the TWL4030 + Beagle, EVM, and Overo ASoC driver patches
> as soon as I can track down a recurring crashing bug -- a null
> substream pointer that seems to show up in certain circumstances.  Not
> quite sure my driver is causing the error, but I would like to get to
> the bottom of it.  It may be a compatibility issue with the version of
> alsa lib I am using with the linux-omap kernel since the lib is
> passing in the null pointer.  Have you seen anything like this on the
> N810?
> 
Thus far I've seen only these two fixed
66c23551b1b774e2be3c7bdf91c0ebf2c7a3519e and
55502f74b56f609a84d8919b9b29390b2e0147ff OMAP DMA related dump_stacks
but probably I haven't stressed enough :-)

For testing I use Debian/testing and alsa-utils and various
players like mpg321, madplay, etc from there.

ii  libasound2                      1.0.16-2           ALSA library

cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.17.

Can you share the error log and steps when this typically occurs in
order to see can I reproduce it?


Jarkko
