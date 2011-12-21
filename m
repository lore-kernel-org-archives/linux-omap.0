From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Wed, 21 Dec 2011 10:44:42 +0100
Message-ID: <4EF1AA8A.8060304@linux.intel.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4EF1A0B4.5080307@linux.intel.com>
	<CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/21/2011 10:40 AM, Colin Cross wrote:

>> this smells fundamentally racey to me; you can get an interrupt one
>> cycle after you think you're done, but before the last guy enters WFI...
>>
>> how do you solve that issue ?
> 
> All the cpus have interrupts off when they increment the counter, so
> they cannot receive an interrupt.  If an interrupt is pending on one
> of those cpus, it will be handled later when WFI aborts due to the
> pending interrupt.

... but this leads to cases where you're aborting before other cpus are
entering..... so your "last guy in" doesn't really work, since while cpu
0 thinks it's the last guy, cpu 1 is already on the way out/out
already...  (heck it might already be going back to sleep if your idle
code can run fast, like in the size of a cache miss)
