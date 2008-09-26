From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Fri, 26 Sep 2008 10:56:37 +0300
Message-ID: <20080926105637.5d8a8a4d.jarkko.nikula@nokia.com>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
	<200809252220.43229.siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59030 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbYIZH50 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 03:57:26 -0400
In-Reply-To: <200809252220.43229.siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 25 Sep 2008 22:20:43 +0300
"ext Siarhei Siamashka" <siarhei.siamashka@gmail.com> wrote:

> On Tuesday 23 September 2008, Arun KS wrote:
> > Hi all,
> >
> > I am writing an ASOC driver for tlvaic23 on osk5912 platform.
> [...]
> 
> Hi. Coincidentally I have been hacking the old aic23 driver in the
> last few days to make it work on Nokia 770. Don't know if these fixes
> have any value for linux-omap tree, but I would be glad if anybody
> finds some of them useful. Patch against old 2.6.16 kernel can be
> found here:
>
Hi

sound/arm/omap is likely to disappear but with ASoC codec driver for
aic23 and machine driver for OSK, those would allow quite easily to add
support for 770 as well and to rotate support patch to 770 via
alsa-devel list.


Jarkko
