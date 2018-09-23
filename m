From: Stefan Lengfeld <contact@stefanchrist.eu>
Subject: Re: [RFC PATCH 0/4] i2c: core: introduce master_xfer_irqless
Date: Sun, 23 Sep 2018 22:20:34 +0200
Message-ID: <20180923202034.qugs4fxucj7h4vri@porty>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Tero Kristo <t-kristo@ti.com>, preid@electromag.com.au, Keerthy <j-keerthy@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-renesas-soc@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

On Thu, Sep 20, 2018 at 06:14:19PM +0200, Wolfram Sang wrote:
> To keep the discussion about master_xfer_irqless going, I post here a
> draft how I envision the changes to the I2C core. They are only build
> tested. I am unsure if I can test them on hardware before next week, so
> I'll send them around as RFC already, so people can get an idea and
> comment. Maybe Stefan has some bandwidth to test his imx driver
> implementation on top of this?

No problem. I have some spare time in the next days and will post my
results to the mailinglist.

Kind Regards,
Stefan Lengfeld
