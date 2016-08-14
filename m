From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 6/7] ARM: dts: OMAP3-N900: Add bluetooth
Date: Sun, 14 Aug 2016 10:53:20 +0200
Message-ID: <20160814085320.GD21321@amd>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-7-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471058078-5579-7-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat 2016-08-13 05:14:37, Sebastian Reichel wrote:
> Add bcm2048 node and its system clock to the N900 device tree file.
> Apart from that a reference to the new clock has been added to
> wl1251 (which uses it, too).
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

As the driver is not currently working at N900, I agree that this
patch is useful, but it should probably not go upstream.

Thanks,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
