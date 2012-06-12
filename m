From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v2] ARM: OMAP2/3: hwmod data: add gpmc
Date: Tue, 12 Jun 2012 10:23:48 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998025@DBDE01.ent.ti.com>
References: <1339420503-7920-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52278 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab2FLKX5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 06:23:57 -0400
In-Reply-To: <1339420503-7920-1-git-send-email-afzal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On Mon, Jun 11, 2012 at 18:45:03, Mohammed, Afzal wrote:
> Add gpmc hwmod and associated interconnect data
> 
> HWMOD_INIT_NO_RESET can be removed once kernel is updated to
> configure GPMC for all peripherals. Currently many depend on
> bootloader, this facility will be removed.
> (feature-removal-schedule.txt will get updated in upcoming
> gpmc series).
> 
> No reset is also required for smooth migration to gpmc driver;
> approach being taken is to hold old interface until boards are
> converted to use driver interface one-by-one. Till that time,
> this flag is a must as old interface rely on bootloader
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> v2: rebased to 3.5-rc1

Please let me know your comments on this. I am proceeding as you
have suggested; beagle board, omap3evm had been made to configure
in Kernel at runtime [1] and provision has been given in gpmc
driver to cry loud if no configuration in Kernel [2]

Updating feature-removal-schedule.txt will be done as part of
another series (yet to be posted, that series depends on gpmc
driver conversion series [3], needs to know Tony's comments on
driver series first and if fine, it will be posted). Right now
it won't make sense to post a patch on feature-removal as first
all boards that depend on bootloader has to modified to make use
of driver interface. So patch on feature-removal-schedule.txt
will be posted along with migration of remaining boards to use
driver interface.

And this patch is necessary for gpmc driver conversion [3] to proceed.

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69917.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69906.html
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69897.html

