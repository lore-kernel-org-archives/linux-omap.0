From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] CBUS: Do not BUG_ON in retu-headset in case of
	spurious release event
Date: Thu, 15 Nov 2007 13:30:04 -0800
Message-ID: <20071115213004.GP20686@atomide.com>
References: <1194961994-12212-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1194961994-12212-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [071113 05:53]:
> There is a small chance that retu_headset_detect_timer can run twice
> and pressed flag being zero in second run. Do nothing in that case instead
> of throwing BUG_ON.
> 
> Double run can happen under very busy system assuming following scenario
> 
> 1. Hook interrupt (run in softirq context, pressed flag = 1)
> 2. First retu_headset_enable_timer call
> 3. Busy system, retu raises an interrupt but cannot run hook interrupt for
>    300-350 ms
> 4. Second hook interrupt
> 5. First retu_headset_detect_timer call (pressed flag = 0)
> 6. Second retu_headset_enable_timer
> 7. Second retu_headset_detect_timer
>    -> pressed flag == 0 => BUG_ON
> 
> Patch also removes two debug messages since they are not needed very much
> and removal cleans up code a bit.

Pushing today.

Tony
