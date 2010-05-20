From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/4 v2] fbdev: add a MIPI DSI header
Date: Thu, 20 May 2010 17:32:35 +0300
Message-ID: <1274365955.4246.58.camel@tubuntu.research.nokia.com>
References: <Pine.LNX.4.64.1005201121340.26000@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005201121340.26000@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev, @vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-20 at 11:30 +0200, ext Guennadi Liakhovetski wrote:
> This header adds defines for MIPI DSI and DCS commands and data formats. See
> http://www.mipi.org/ for details.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Ok, how about this? If this is acceptable I'll repost other patches too, 
> adjusted accordingly.

Something that is missing are transaction types from peripheral to the
host. I think they should be defined here also.

But what should the prefix be for them... MIPI_DSI_RX_? I don't know.

 Tomi


