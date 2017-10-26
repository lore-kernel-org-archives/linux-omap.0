From: =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 08:25:02 +0200
Message-ID: <3dbb966f-c279-2c57-d3c2-98ca7c04accd@gmail.com>
References: <20171025203459.GA22035@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171025203459.GA22035@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On 10/25/2017 10:34 PM, Pavel Machek wrote:
> 3.5.3-nemo kernel seems to work

I did take a quick look at the board-rm680.c since there are some
conditional statements with regards to system revision but I didn't
notice anything that might prevent it from booting.

> If you have
> any ideas, let me know.

Last time I couldn't get output on serial I used CONFIG_DEBUG_LL,
CONFIG_DEBUG_OMAP3UART3, CONFIG_EARLY_PRINTK... and ignore_loglevel
earlyprintk kernel params to get output early enough - I guess you
already tried that.

Regards,
Filip
