From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH v3] i2c: omap: improve duty cycle on SCL
Date: Thu, 18 Jun 2015 10:09:59 +0200
Message-ID: <55827CD7.7030207@nokia.com>
References: <1434569475-17378-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1434569475-17378-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ext Felipe Balbi <balbi@ti.com>, wsa@the-dreams.de
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello Felipe,

On 17/06/15 21:31, ext Felipe Balbi wrote:
> With this patch we try to be as close to 50%
> duty cycle as possible. The reason for this
> is that some devices present an erratic behavior
> with certain duty cycles.
> 
> One such example is TPS65218 PMIC which fails
> to change voltages when running @ 400kHz and
> duty cycle is lower than 34%.
> 
> The idea of the patch is simple:
> 
> calculate desired scl_period from requested scl
> and use 50% for tLow and 50% for tHigh.
> 
> tLow is calculated with a DIV_ROUND_UP() to make
> sure it's slightly higher than tHigh and to make
> sure that we end up within I2C specifications.

if you refuse to change the calculations to achieve maximum possible
bus rate (as I've shown you with SCLL=9 and SCLH=9), maybe you want to
change the description? Because you are doing something else than is
written here. You are only in spec because you are not doing 50% duty
cycle. And you didn't mention here that you lower the bus speed below
400kHz to achieve this.

-- 
Best regards,
Alexander Sverdlin.
