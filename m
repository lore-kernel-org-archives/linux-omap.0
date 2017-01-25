From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Wed, 25 Jan 2017 13:29:52 +0800
Message-ID: <1485322192.2461.4.camel@intel.com>
References: <20170123141331.GA11402@amd>
         <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
         <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
         <20170123234912.GA2460@roeck-us.net>
         <20170124070639.GA5068@rzhang1-surface> <20170124073720.GB5603@amd>
         <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
         <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
         <20170124224610.GA27340@amd>
         <CAOMZO5AFZy6YFrE0P-xDXX5BCfWYHAC34VyyX85H5Wr+1O59jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5AFZy6YFrE0P-xDXX5BCfWYHAC34VyyX85H5Wr+1O59jA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Guenter Roeck <linux@roeck-us.net>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, kernel list <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, abcloriens@gmail.com, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On Tue, 2017-01-24 at 21:07 -0200, Fabio Estevam wrote:
> On Tue, Jan 24, 2017 at 8:46 PM, Pavel Machek <pavel@ucw.cz> wrote:
> 
> > 
> > It is an ugly regression and it is -rc5 time. Actually not your
> > problem, but Fabio Estevam or Zhang Rui has to deal with it soon.
> I have already sent the revert and it was acked-by you and Guenter.

Revert patch has been applied and queued for next -rc.

thanks,
rui
