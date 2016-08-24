From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v3 0/2] AM335x-ICE: Add support for rotary switch
Date: Wed, 24 Aug 2016 10:35:52 +0200
Message-ID: <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
References: <20160824075859.30979-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160824075859.30979-1-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vignesh R <vigneshr@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Daniel Hung-yu Wu <hywu@google.com>, Russell King <linux@armlinux.org.uk>, "Andrew F . Davis" <afd@ti.com>, Grant Grundler <grundler@chromium.org>, Rob Herring <robh+dt@kernel.org>, S Twiss <stwiss.opensource@diasemi.com>, linux-input@vger.kernel.org, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 08/24/2016 09:58 AM, Vignesh R wrote:
> This series adds support for rotary-switch on AM335x-ICE that is
> connected to TI PCA9536 I2C GPIO expander.
> First patch adds new generic driver to read status of group of GPIO
> lines and report the value as an input event. The second patch adds DT
> entries for the same.
> 
> v2: https://lkml.org/lkml/2016/8/23/111
> v1: https://lkml.org/lkml/2016/8/12/7

Is there a reason why the rotary-encoder driver cannot handle this?
Commit 7dde4e74744 ("Input: rotary-encoder - support more than 2 gpios
as input") added support for that mode AFAIU.

I copied the author of that patch to have a look.


Thanks,
Daniel
