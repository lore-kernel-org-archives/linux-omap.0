From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Tue, 03 Jan 2012 16:41:27 -0800
Message-ID: <87sjjw70zs.fsf@ti.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1324426147-16735-1-git-send-email-ccross@android.com> (Colin
 Cross's message of "Tue, 20 Dec 2011 16:09:04 -0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Colin Cross <ccross@android.com>
Cc: Len Brown <len.brown@intel.com>, Trinabh Gupta <g.trinabh@gmail.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Colin Cross <ccross@android.com> writes:


> This patch series implements an alternative solution, where each
> cpu will wait in the WFI state until all cpus are ready to enter
> a coupled state, at which point the coupled state function will
> be called on all cpus at approximately the same time.

This looks great, and is certainly preferred to hotplug IMO.

[...]

> None of the platforms I work with have an SMP idle implementation
> upstream, so I can't easily show a patch that converts a platform
> from hotplug governor to coupled cpuidle states.  

Basic OMAP4 CPUidle support is in now queued for v3.3 (see omap4
branch Tony's tree[1].)  

Can you (or Santosh) send a patch that adds coupled support to that
driver so it can see some broader testing on OMAP4?

Thanks,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
