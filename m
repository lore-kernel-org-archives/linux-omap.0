From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 21 Mar 2016 15:39:15 +0200
Message-ID: <56EFF983.2050303@gmail.com>
References: <56E9B910.7000904@gmail.com> <56EA6282.5050501@ti.com>
 <56EAE8C3.1080301@gmail.com> <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900> <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com> <20160318150404.GA30829@earth>
 <56ED12B5.9000103@gmail.com> <20160320051704.GA12934@earth>
 <20160321114521.GO2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160321114521.GO2566@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 21.03.2016 13:45, Mark Brown wrote:
>
> No, if the voltage is variable we can't tell what the current
> constraints are without something telling us so we just don't vary the
> voltage until we're told to do this.  If we immediately lower the
> voltage to the minimum supported voltage that's going to break things.
>

There are constraints set by the board DTS. Isn't it reasonable the 
framework to set the voltage to minimum voltage from the dts if the 
current set one is bellow it?

Regards,
Ivo
