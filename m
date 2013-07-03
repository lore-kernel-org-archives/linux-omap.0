From: Joel Fernandes <joelf@ti.com>
Subject: Re: [alsa-devel] Query on Audio DMA using DMAEngine
Date: Wed, 3 Jul 2013 13:18:06 -0500
Message-ID: <51D46ADE.3040500@ti.com>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com> <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl> <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl> <20130702121345.GL27646@sirena.org.uk> <51D3EA42.3040205@metafoo.de> <20130703094307.GE27646@sirena.org.uk> <51D46598.6070005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41508 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932744Ab3GCSSI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jul 2013 14:18:08 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id r63II73c016422
	for <linux-omap@vger.kernel.org>; Wed, 3 Jul 2013 13:18:07 -0500
In-Reply-To: <51D46598.6070005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Darren Etheridge <detheridge@ti.com>
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

On 07/03/2013 01:12 PM, Mark Brown wrote:> On Wed, Jul 03, 2013 at 12:55:36PM
-0500, Joel Fernandes wrote:
>
>> When would it not be possible to cope with a large period size? Are there any
>> guidelines on what to consider when fixing a period size?
>
> This is an application issue not a driver issue.  An application that
> wants low latency may need high resolution information about what
> exactly the hardware is doing.
>

Hi Darren,

  Can anyone in your team share some insight about min/max buffer size and
min/max period size in the davinci-pcm driver. This will help make better
decisions about the Cyclic DMA. Below was my original email on the mailing list.

Also could you copy Peter? I couldn't find his email address.

Thanks,
Joel


Quoting my original email to the mailing list:


Copying some more lists are we're also discussing the DMA controller in the
SoCs. Thanks.

On 07/03/2013 04:43 AM, Mark Brown wrote:
> On Wed, Jul 03, 2013 at 11:09:22AM +0200, Lars-Peter Clausen wrote:
>> On 07/02/2013 02:13 PM, Mark Brown wrote:
>
>>> This sort of cyclic thing tends to be best, ideally you don't need
>>> interrupts at all (other than a timer).
>
>> Yes, this is usually how it is done. But I'm wondering maybe the EDMA
>> controller only has a small total amount of slots available.
>
> Well, you don't need particularly many slots so long as you can cope
> with a large period size.

Hi Mark,

When would it not be possible to cope with a large period size? Are there any
guidelines on what to consider when fixing a period size?

I see tegra and aux1x go upto .period_bytes_min = 1024

About slots, following are no.of slots on some SoCs with EDMA:

am1808 - 96 slots available + 32 taken up for channel but can be reused with
some changes.
am335x - 172 slots available + 64 taken up for channels

On a slightly different note, about buffer_bytes_max, is there any drawback to
setting it to a smaller value? Currently 128K is about what is used on davinci-pcm.
My idea is to map to do the direct mapping to IRAM if the IRAM transfers are
really what are preventing the under runs, but 128K will be too much for the
buffer as we don't have that much IRAM infact it is just the boundary on am33xx
(128K)


Thanks,

-Joel


