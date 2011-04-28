From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Initial B&N Nook Color support, take two
Date: Thu, 28 Apr 2011 13:21:33 -0400
Message-ID: <2AFBBB50-E419-4003-9623-768A1713860A@linuxhacker.ru>
References: <1304006259-7939-1-git-send-email-green@linuxhacker.ru> <alpine.DEB.2.00.1104281102300.11487@utopia.booyaka.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:37141 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545Ab1D1RVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 13:21:39 -0400
In-Reply-To: <alpine.DEB.2.00.1104281102300.11487@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Hello!

On Apr 28, 2011, at 1:05 PM, Paul Walmsley wrote:
>>   Ok, this is a second attempt at B&N Nook Color board file submission.
>>   USB peripheral mode is fully operational as is serial console and
>>   MMC/SDCard.
> It's good that you're sending these patches, but please also:
> - Add a Signed-off-by: to each patch (see item 12 of 
> Documentation/SubmittingPatches)

Ah, sure. Somehow I assumed this one is auto generated for the patch submitter.
(never was a problem in the past at least).

> - Cc Vikram, the original author of the board file, in the patch messages

Ok, though I am not sure he is the original author of the nook color board file
(since (C) 2008 well predates the Nook Color), the work I base this all off is
from NookColor B&N source code drop and unfortunately people that worked on it
did not identify themselves (or I don't see it) aside from just names in some
debug comments.

> - Cc the linux-arm-kernel@lists.infradead.org mailing list

Ok, I am expecting the patch will still get quite a bit of scrutiny so I'll
wait for more feedback and next submission would be conforming.

Thanks!

Bye,
    Oleg