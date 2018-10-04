From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Thu, 4 Oct 2018 07:23:19 -0700
Message-ID: <20181004142319.GA5662@atomide.com>
References: <20180925144021.GN5662@atomide.com>
 <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com>
 <20180926162303.GU5662@atomide.com>
 <cfc3f1db-9468-ed92-a673-882b51b4dec8@ti.com>
 <20180926233111.GY5662@atomide.com>
 <305bf1c3-915d-dac1-95e4-4d32621247e1@ti.com>
 <20181001163253.GW5662@atomide.com>
 <ff68a664-aa7a-92b6-b78c-78382f7b0ec1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ff68a664-aa7a-92b6-b78c-78382f7b0ec1@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [181004 04:34]:
> Apologies for the delay in responding.
> 
> AM437X-GP-EVM: https://pastebin.ubuntu.com/p/m3ybBvH7Qj/
> 
> Tested for UART/RTCWAKE/TOUCH_WAKE from DS0, apart from the expected
> gpio warnings all seems fine.
> 
> AM335X-BONEBLACK: https://pastebin.ubuntu.com/p/xdsMDS5XtQ/
> 
> Tested for rtcwake/UART wake up from DS0. Again except for gpio messages
> everything else seems to be fine.

OK good to hear and thanks for testing again :) I've sent
a pull request for the ti-sysc driver changes, the dts
changes for am335x, am437x and dra7 will have to wait until
v4.21 merge window at this point. Let's plan on having the
dts changes sit in Linux next for a few weeks right after
v4.20-rc1.

Regards,

Tony
