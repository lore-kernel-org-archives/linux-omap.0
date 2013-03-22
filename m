From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [BUGFIX PATCH] ARM: OMAP: fix type of return values in
	omap_device_get_by_hwmod_name()
Date: Fri, 22 Mar 2013 16:36:05 +0000
Message-ID: <20130322163605.GM30923@n2100.arm.linux.org.uk>
References: <1363867990-24593-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363867990-24593-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 21, 2013 at 01:13:10PM +0100, Lothar Wa=DFmann wrote:
> The merge bda5e141fbe96295c669692114d18687730269fb erroneously change=
d

Don't forget that commit's description as well...
