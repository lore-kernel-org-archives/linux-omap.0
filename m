From: Arnd Bergmann <arnd.bergmann@linaro.org>
Subject: Re: [PATCH v8 0/8] Consolidate cpuidle functionality
Date: Tue, 20 Mar 2012 21:58:07 +0000
Message-ID: <201203202158.08042.arnd.bergmann@linaro.org>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Lee <rob.lee@linaro.org>
Cc: nicolas.pitre@linaro.org, venki@google.com, linaro-dev@lists.linaro.org, linux-sh@vger.kernel.org, tony@atomide.com, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, ccross@google.com, kernel@wantstofly.org, khilman@ti.com, kgene.kim@samsung.com, mturquette@linaro.org, daniel.lezcano@linaro.org, magnus.damm@gmail.com, jon-hunter@ti.com, len.brown@intel.com, patches@linaro.org, nsekhar@ti.com, jean.pihet@newoldbits.com, rjw@sisk.pl, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux-omap@vger.kernel.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, g.trinabh@gmail.com, linux-pm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, lethal@linux-sh.org, amit.kachhap@linaro.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 March 2012, Robert Lee wrote:
> This patch series moves various functionality duplicated in platform 
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into 
> cpuidle_call_idle will have already called local_irq_disable().
> 
> These changes have been pulled into linux-next.
> 
> Len, Andrew, can a request be made for Linus to pull these changes?

FWIW, Len seems to be rather inactive on the kernel mailing list right
now and generally not very interested in anything outside of x86 and
acpi. If he doesn't reply in the next few days and Andrew also isn't
interested in handling these patches, I'd suggest you just send the pull
request to Linus, with Len on Cc and explain that you tried to send
them through him but gave up in the end.

	Arnd
