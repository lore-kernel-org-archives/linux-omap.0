From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
Date: Thu, 27 Oct 2016 16:50:24 +0530
Message-ID: <ae3d5312-a328-f643-7e0a-cacc5bb95d28@ti.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161024060226.4170-1-mugunthanvnm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: John Syne <john3909@gmail.com>, Vignesh R <vigneshr@ti.com>, linux-iio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Monday 24 October 2016 11:32 AM, Mugunthan V N wrote:
> Increase ADC reference clock from 3MHz to 24MHz so that the
> sampling rates goes up from 100K samples per second to 800K
> samples per second on AM335x and AM437x SoC.
> 
> Also increase opendelay for touchscreen configuration to
> equalize the increase in ADC reference clock frequency,
> which results in the same amount touch events reported via
> evtest on AM335x GP EVM.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Found issues with touchscreen usage with GUI on my AM335x GP EVM. Fixed
with change the "ti,charge-delay" DT property based on change in ADC
clocks. Will be sending v2 patch soon.

Regards
Mugunthan V N
