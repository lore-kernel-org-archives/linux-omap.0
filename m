From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Fri, 29 Jun 2012 06:15:49 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A0D32@DBDE01.ent.ti.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58409 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab2F2GQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 02:16:00 -0400
In-Reply-To: <4FEC89B9.3090404@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony, Jon,

On Thu, Jun 28, 2012 at 22:13:37, Hunter, Jon wrote:
> On 06/28/2012 07:32 AM, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120628 02:36]:
> >> On Wed, Jun 27, 2012 at 20:28:45, Tony Lindgren wrote:

> >>> The last patch in this series causes onenand not to show
> >>> up on my n900. I believe the problem has been there earlier
> >>> too, but I just did not notice it.

> > Yes that seems to do the trick, thanks! I can fold that into the
> > breaking patch when applying.
> 
> I am not sure what to make of this. Testing Afzal's this series along with the other
> gpmc-prep series [1], onenand is working fine on my 3430sdp and I see ...
> 
> [    2.792510] OneNAND driver initializing
> [    2.797576] omap2-onenand omap2-onenand: initializing on CS2, phys base 0x20000000, virtual base c88c0000, freq 0 MHz
> [    2.808929] OneNAND Manufacturer: Samsung (0xec)
> [    2.808990] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
> [    2.814208] OneNAND version = 0x002c
> 
> The above change seems to imply that Tony's n900 is dependent on the bootloader settings
> and not those being set by the kernel. Ideally, we should not need to set the async mode

In one of the Samsumg onenand datasheet, it was mentioned,
(seems Numonyx datasheet is under NDA)

[A] "If device is accessed synchronously, while set to asynchronous
read mode, it is possible to read out first data without problems"

It seems even though above may not imply the below, chances are that
below would be true

[B] "If device is accessed asynchronously, while set to synchronous
read mode, it will not be possible to read out data"

And B seems logical(to me); if onenand is set to synchronous mode,
it would expect clocks to transfer data which may not happen with
asynchronous operation from gpmc.

Here the problem with Tony's n900 (expecting it to use one of mach-id
in n8x0, hence flag sync read) board may be that bootloader (could not
find uboot handling these machines) before handing over control to
Kernel, sets it to synchronous mode. And then if we apply B, we can
expect what we are seeing here.

Assuming above is a explanation to what Tony is observing on n900,
perhaps, resetting onenand may help Kernel work even without the
proposed diff. There is a gpio pin field used in n8x0, if that is
connected to reset of onenand, may be it can achieve what we
want without the diff.

> Numonyx. The gpmc-onenand.c only has one set of settings that it is using for all
> devices. However, it would appear that at least the async settings are not working for
> the Numonyx. Therefore, may be we need to get a dump of Tony's n900 settings and make

I have a different opinion, even with the existing code, with the default
timings for onenand, Numonyx is working in async mode, reason being that
frequency is being obtained with read operation executed in async mode
(later based on this frequency, code calculates sync timings & then set
to sync mode)


This change indeed has brought to our notice one instance where
Kernel can't handle gpmc by itself, may be resetting onenand is
a solution, as it seems bootloader is leaving it in sync mode.

Regards
Afzal
