From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP HSMMC: fix MMC3 dma
Date: Tue, 27 Jan 2009 19:00:33 +0200
Message-ID: <6ed0b2680901270900t24838c73l3aa8edca62c91710@mail.gmail.com>
References: <1233052573-6223-1-git-send-email-notasas@gmail.com>
	 <497EF7E2.7010906@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:36837 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZA0RAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 12:00:35 -0500
In-Reply-To: <497EF7E2.7010906@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "drzeus-mmc@drzeus.cx" <drzeus-mmc@drzeus.cx>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jan 27, 2009 at 2:02 PM, Adrian Hunter
<ext-adrian.hunter@nokia.com> wrote:
> Grazvydas Ignotas wrote:
>>
>> Data transfers on third OMAP3 MMC controller don't work
>> because DMA line numbers are only defined for MMC1 and MMC2.
>> Fix that and store line numbers in mmc_omap_host structure
>> to reduce code size.
>> Tested on OMAP3 pandora board.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c |   31 +++++++++++++++++++++++--------
>>  1 files changed, 23 insertions(+), 8 deletions(-)
>>
>
> Have you considered using the scatter-gather emulation patch:
>
>        http://marc.info/?l=linux-omap&m=122726069922195&w=2
>
> It was reverted:
>
>        http://marc.info/?l=linux-omap&m=122904725322787&w=2
>
> because of a hardware problem with OMAP3430 before ES3.0, but applying:
>
>
>  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6a79e391df295bd7c2aa1309ea5031f361c197fd
>
> seems to overcome even that.

Hmm, but it still doesn't know about MMC3. But in case that SG patch
goes first, I can resend.
