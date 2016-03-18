From: =?UTF-8?Q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE_?=
	 =?UTF-8?Q?=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?=
	<ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Fri, 18 Mar 2016 15:13:49 +0200
Message-ID: <1458306829.11841.2.camel@Nokia-N900>
References: <201507251228.27128@pali> <201601050034.12810@pali>
	 <20160306152339.GA428@earth> <201603121342.33099@pali>
	 <56E68B71.2030202@ti.com> <20160316133319.GR8413@pali>
	 <20160316144709.GA3389@earth> <56E9A42B.3010209@gmail.com>
	 <56E9A6D9.7000003@ti.com> <56E9B910.7000904@gmail.com>
	 <56EA6282.5050501@ti.com> <56EAE8C3.1080301@gmail.com>
	  <56EBD96A.8090505@ti.com>
Reply-To: =?UTF-8?Q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE_?=
	   =?UTF-8?Q?=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?=
	  <ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56EBD96A.8090505@ti.com>
Content-ID: <1458306829.11841.1.camel@Nokia-N900>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sebastian Reichel <sre@kernel.org>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi

On Fri Mar 18 12:33:14 2016 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> But enabling the pull via DT for the i2c2 works?
> 

No :(. I even migrated the driver to regmap - no gain. Maybe i2c bus is blocked by another device held in reset. The next thing I am going to try is to deassert reset/power gpios on all the devices on i2c-2 bus, to see if it will make any difference. Or if you have any other ideas, please share.

Ivo
