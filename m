From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/5] Minimal cpuidle fixes for omap5 and dra7
Date: Wed, 26 Oct 2016 15:56:19 -0500
Message-ID: <c1b6bf69-ed11-3355-323f-9d6503180310@ti.com>
References: <20161026151703.24730-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161026151703.24730-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Dave Gerlach <d-gerlach@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Pau Pajuel <ppajuel@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony,
On 10/26/2016 10:16 AM, Tony Lindgren wrote:
> Hi all,
>
> Here are some fixes to get minimal cpuidle support working with omap5
> and dra7. Not sure if there are still some unsorted issues on enabling
> this on dra7, but at least omap5 has been behving for me for few
> weeks with these.

I am OK with cpuidle for OMAP5, but NOT dra7. we have enabled this 
series of patches close to a couple of years back and hit quiet a few 
issues that do not have silicon resolution. CPU states lower than WFI 
will not work in cpuidle for DRA7 and has already been "descoped" from 
TI investigation charter. details of the issue remain TI internal, 
given that the descope was already done.

Again, OMAP5 has only had limited exposure from verification point of 
view - and all of it TI internal (unlike OMAP4 which has had 
production devices go ahead) -> at the very least, I'd link it with 
experimental.

-- 
Regards,
Nishanth Menon
