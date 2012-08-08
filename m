From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Wed, 8 Aug 2012 17:41:47 +0200
Message-ID: <502288BB.6020709@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <5022529D.3090406@ti.com>
 <20120808125252.GR16861@opensource.wolfsonmicro.com>
 <50227936.3040701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <50227936.3040701@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/08/2012 04:35 PM, Peter Ujfalusi wrote:
> On 08/08/2012 03:52 PM, Mark Brown wrote:
>> On Wed, Aug 08, 2012 at 01:50:53PM +0200, Benoit Cousson wrote:
>>
>>> That being said, since we do have the clock binding now, maybe we should
>>> create a clock provider at board level for the sys_clk and thus you will
>>> just have to create a phandle to it in your audio description.
>>
>> Yes, we should be doing this.
> 
> Does this needs the common clock framework on the platform? OMAP3 certainly
> does not have it enabled since it has not been adopted.
> 

Yeah, good point, we are still not there yet. Rajendra is still working
on it and I hope we can get something for 3.7, but let's avoid having a
strong dependency on that migration for the moment.

Regards,
Benoit
