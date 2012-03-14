From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Tue, 13 Mar 2012 19:04:49 -0700
Message-ID: <4F5FFCC1.2030702@linux.intel.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4F1929E9.7070707@linaro.org> <8762e8kqi6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8762e8kqi6.fsf@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 3/13/2012 4:52 PM, Kevin Hilman wrote:
> Checking the ready_count seemed like an easy way to do this, but did you
> have any other mechanisms in mind for CPUs to communicate that they've
> exited/aborted?

this indeed is the tricky part (which I warned about earlier);
I've spent quite a lot of time (weeks) to get this provably working for
an Intel system with similar requirements... and it's extremely unfunny,
and needed firmware support to close some of the race conditions.

I sure hope that hardware with these requirements is on the way out...
it's not very OS friendly.
