From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Initial B&N Nook Color support, take two
Date: Thu, 28 Apr 2011 11:05:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104281102300.11487@utopia.booyaka.com>
References: <1304006259-7939-1-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47319 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab1D1RFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 13:05:21 -0400
In-Reply-To: <1304006259-7939-1-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org

On Thu, 28 Apr 2011, green@linuxhacker.ru wrote:

> Hello!
> 
>    Ok, this is a second attempt at B&N Nook Color board file submission.
>    USB peripheral mode is fully operational as is serial console and
>    MMC/SDCard.

It's good that you're sending these patches, but please also:

- Add a Signed-off-by: to each patch (see item 12 of 
Documentation/SubmittingPatches)

- Cc Vikram, the original author of the board file, in the patch messages

- Cc the linux-arm-kernel@lists.infradead.org mailing list


- Paul
