From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: Suspend/Resume support with Omap2fb
Date: Wed, 11 Mar 2009 14:49:58 +0200
Message-ID: <1236775798.12797.33.camel@tubuntu>
References: <19F8576C6E063C45BE387C64729E73940427C51A3F@dbde02.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17923 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbZCKMuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 08:50:21 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940427C51A3F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-03-11 at 11:47 +0100, ext Hiremath, Vaibhav wrote:

> > >
> > > How have you tested this?
> > > Have you also tested with "echo mem > /sys/power/state"?
> > > Are you using Kevin's power management tree? What is default
> > configuration of your kernel during this test?
> > 
> > It's been some time since I tested it, but it did work on OMAP3 SDP
> > with
> > the pm-branch. Only changed needed were the
> > get_last_off_on_transaction_id and omapfb -> omapdss. I also tested
> > echo
> > mem > ....
> > 
> > I'll try to find time to test it again with latest trees.
> > 
> [Hiremath, Vaibhav] That would be great, I am also trying few things here at my end. Hopefully I will get something.

Yeah, it works ok for me. I rebased my DSS2 tree to latest l-o, then
merged pm-branch, and made the changes mentioned above. I get some
warnings from getnstimeofday when resuming the kernel, but they seem to
be unrelated to DSS, and the image is fine after resume. I used my
dss_omap_3430sdp_defconfig and made the following commands to enable PM:

echo 1 > /sys/power/clocks_off_while_idle
echo 1 > /sys/power/enable_off_mode
echo 1 > /sys/power/voltage_off_while_idle
echo 1 > /sys/power/sleep_while_idle

 Tomi


