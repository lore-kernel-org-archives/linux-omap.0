From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Thu, 25 Sep 2008 22:20:43 +0300
Message-ID: <200809252220.43229.siarhei.siamashka@gmail.com>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:14544 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbYIYTUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 15:20:46 -0400
Received: by nf-out-0910.google.com with SMTP id d3so236893nfc.21
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 12:20:44 -0700 (PDT)
In-Reply-To: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 23 September 2008, Arun KS wrote:
> Hi all,
>
> I am writing an ASOC driver for tlvaic23 on osk5912 platform.
[...]

Hi. Coincidentally I have been hacking the old aic23 driver in the last few
days to make it work on Nokia 770. Don't know if these fixes have any value
for linux-omap tree, but I would be glad if anybody finds some of them useful.
Patch against old 2.6.16 kernel can be found here:
http://lists.maemo.org/pipermail/maemo-developers/2008-September/035053.html

A bug with current position detection in 'audio_get_dma_pos' is especially bad
as it causes sound stuttering on video playback.

-- 
Best regards,
Siarhei Siamashka
