From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: dts: n900: Include adp1653 device
Date: Wed, 27 Jan 2016 11:18:28 +0000
Message-ID: <20160127111828.GK5783@n2100.arm.linux.org.uk>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
 <20160121092909.GH5783@n2100.arm.linux.org.uk>
 <20160121101828.GA7411@amd>
 <20160121163857.GH19432@atomide.com>
 <20160121165408.GJ5783@n2100.arm.linux.org.uk>
 <20160127100237.GH25796@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160127100237.GH25796@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 27, 2016 at 11:02:37AM +0100, Pali Roh=E1r wrote:
> In my opinion this patch is not support for new hardware. It just add
> missing DT definition for one specific board for HW which was added t=
o
> linux kernel in v4.2-rc1 version. For me it looks like that needed DT
> definition was forgotten...

Opinions differ, but ultimately it's up to whoever is responsible for
accepting the patch, and in the case of ARM SoC based patches, the
arm-soc maintainers.

The arm-soc maintainers close their trees for development changes a
few weeks before hand (a patch of mine which was acked etc by 7th
December never made the 4.5 merge window either, and the alleged
reason I've been told is because arm-soc was already closed by then).

--=20
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
