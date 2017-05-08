From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] memory: omap-gpmc: Fix debug output for access width
Date: Mon, 8 May 2017 10:36:10 -0700
Message-ID: <20170508173610.GJ3489@atomide.com>
References: <20170505223706.4913-1-tony@atomide.com>
 <a59b8a21-056a-0e1f-44a6-585256945747@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a59b8a21-056a-0e1f-44a6-585256945747@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [170508 03:44]:
> Hi Tony,
> 
> On 06/05/17 01:37, Tony Lindgren wrote:
> > The width needs to be configured in bytes with 1 meaning 8-bit
> > access and 2 meaning 16-bit access.
> 
> As per the TRM, for GPMC_CONFIG1.DEVICESIZE
> 0 means 8-bit
> 1 means 16-bit
> 
> > 
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/memory/omap-gpmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> > --- a/drivers/memory/omap-gpmc.c
> > +++ b/drivers/memory/omap-gpmc.c
> > @@ -513,7 +513,7 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
> >  	pr_info("gpmc cs%i access configuration:\n", cs);
> >  	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
> >  	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
> > -	GPMC_GET_RAW_MAX(GPMC_CS_CONFIG1, 12, 13,
> > +	GPMC_GET_RAW_SHIFT_MAX(GPMC_CS_CONFIG1, 12, 13, 1,
> >  			 GPMC_CONFIG1_DEVICESIZE_MAX, "device-width");
> 
> setting shift 1 means the value will be multiplied by 2
> so this will read 0 for 8-bit and 2 for 16-bit.
> 
> Is this what we want?

Yeah we already have debug output that is supposed to be usable
for configuring a new device based on debug output of the bootloader
timings. And the configured parameters use bytes for device-width.

> I'd still prefer the old way of showing RAW values than interpreted ones.

We have that too in the debug output as the raw values of
all the GPMC_CS_CONFIG registers.

Regards,

Tony
