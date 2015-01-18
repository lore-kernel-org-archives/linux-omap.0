From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
Date: Sun, 18 Jan 2015 23:02:10 +0100
Message-ID: <20150118220210.GA7481@amd>
References: <20141203214641.GA1390@amd>
 <20141224223434.GA20669@amd>
 <20150104094352.GA3790@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150104094352.GA3790@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, sakari.ailus@iki.fi, m.chehab@samsung.com, devicetree@vger.kernel.org, linux-media@vger.kernel.org
Cc: j.anaszewski@samsung.com
List-Id: linux-omap@vger.kernel.org

On Sun 2015-01-04 10:43:52, Pavel Machek wrote:
> 
> We are moving to device tree support on OMAP3, but that currently
> breaks ADP1653 driver. This adds device tree support, plus required
> documentation.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Sakari? You are listed as adp1653 maintainer. Did you apply the patch?
Is it going to be in 3.20?

Thanks,
								Pavel
								
> ---
> 
> Please apply,
> 							Pavel
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> new file mode 100644
> index 0000000..0fc28a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> @@ -0,0 +1,37 @@
> +* Analog Devices ADP1653 flash LED driver

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
