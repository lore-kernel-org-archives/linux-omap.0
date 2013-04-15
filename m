From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: Re: [RFC v1] regulator: core: introduce regulator chain locking scheme
Date: Mon, 15 Apr 2013 19:21:25 +0300
Message-ID: <516C2905.8000200@ti.com>
References: <1366031015-17073-1-git-send-email-grygorii.strashko@ti.com>
 <1366031015-17073-2-git-send-email-grygorii.strashko@ti.com>
 <20130415155040.GD15837@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130415155040.GD15837@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On 04/15/2013 06:50 PM, Mark Brown wrote:
>> In addition, such locking scheme allows to have access to the supplier
>> regulator API from inside child's (consumer) regulator API.
> I've still not seen any use case articulated for doing this...
Use case is introduced in ABB series:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg88293.html

During voltage scaling we would like to have the following sequence:

cpufreq_cpu0
     |
     |---> set_voltage(ABB)
                 |
                 |->set_voltage(AVS)
                         |
                         |-->set_voltage(smps123)


Where smps123 is a regulator, connected ot i2c bus. In this particular 
case "regulator chain" guarantees proper order of calls of voltage 
scaling sequence.

Regards,
Andrii
