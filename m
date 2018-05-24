From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Thu, 24 May 2018 09:25:50 +0300
Message-ID: <39a1e3a3-b9ca-3aa9-eed1-7ac5ee580c8f@ti.com>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd> <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523220254.GD2299@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180523220254.GD2299@darkstar.musicnaut.iki.fi>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, abcloriens@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>, clayton@craftyguy.net, sakari.ailus@linux.intel.com, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Dave Airlie <airlied@redhat.com>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On 24/05/18 01:02, Aaro Koskinen wrote:

> But turns out that omapdrm tree is unbisectable, as I get build failures such
> as (commit 28d79f3e56b2c1d5ff0fd363da3229be0962cc85):
> 
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.c:1473:52: error: undefined identifier 'dss_debug_dump_clocks'
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.c:1472:51: warning: callwith no type!

This goes away if you enable CONFIG_OMAP2_DSS_DEBUGFS.

> In file included from /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/core.c:28:0:
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.h:395:25: error: conflicting types for 'port'
>       struct device_node *port,
>                           ^~~~

And this goes away if you enable CONFIG_OMAP2_DSS_DPI.

Sorry about those.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. 
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
