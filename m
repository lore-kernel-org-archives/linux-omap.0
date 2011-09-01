From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Thu, 1 Sep 2011 12:08:29 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A383@HQMAIL01.nvidia.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
	<4E5F5FA9.3010305@arm.com> <201109011313.42547.marvin24@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201109011313.42547.marvin24@gmx.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Dietich <marvin24@gmx.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, "ming.lei@canonical.com" <ming.lei@canonical.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Mark Salter <msalter@redhat.com>, Chen Peter-B29397 <B29397@freescale.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Marc Dietich wrote at Thursday, September 01, 2011 5:14 AM:
> I'll add Stephen Warren from NVIDIA to the CC list. He has more HW to test on.

Here are the results I found:

Harmony:
Tegra USB3 -> SMSC9514 hub: NOT affected
(Unplugging LAN cable, or disabling SMSC9514 LAN driver doesn't change this)

Seaboard (springbank; clamshell):
Tegra USB1 -> no hub: Affected

Seaboard (seaboard non-clamshell):
Tegra USB1 -> no hub: Affected
Tegra USB3 -> no hub: Affected

TrimSlice:
Tegra USB3 -> unknown hub: Affected

This implies there's something different about Harmony.

Is the USB hub a clue? Seaboard doesn't have one, and although I don't
know what model TrimSlice uses, I assume it's different since I know
TrimSlice's Ethernet is not the same as Harmony's.

I don't see anything in board-harmony.c vs. board-seaboard.c that'd affect
anything USB-related.

Perhaps there's some kind of bootloader or BCT difference. However, my
Harmony and both Seaboards both use (a very old) U-Boot and BCT from
ChromeOS, so I don't imagine there's actually much difference there.

-- 
nvpublic
