From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v2 2/2] pwm: pwm-tiecap: Low power sleep support
Date: Fri, 18 Jan 2013 04:19:39 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA5F455@DBDE01.ent.ti.com>
References: <1358414403-13431-1-git-send-email-avinashphilip@ti.com>
 <1358414403-13431-3-git-send-email-avinashphilip@ti.com>
 <20130117155914.GB2186@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130117155914.GB2186@avionic-0098.adnet.avionic-design.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 17, 2013 at 21:29:14, Thierry Reding wrote:
> On Thu, Jan 17, 2013 at 02:50:03PM +0530, Philip Avinash wrote:
> > In low power modes of AM33XX platforms, peripherals power is cut off.
> > This patch supports low power sleep transition support for ECAP driver.
> > 
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> > ---
> > Changes since v1:
> > 	- check the enabled status of pwm device for handling module
> > 	  enable/disable on resume/suspend
> > 
> >  drivers/pwm/pwm-tiecap.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> 
> Applied, thanks.

Thanks for applying this patch
Avinash

> 
> Thierry
> 
