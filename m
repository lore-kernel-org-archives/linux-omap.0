From: "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] rtc: make rtc-omap driver ioremap its register space
Date: Tue, 13 Oct 2009 16:00:23 -0700
Message-ID: <20091013230023.GA24116@mag.az.mvista.com>
References: <20090917000458.GA6119@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090917000458.GA6119-S3yzRvi4kHRa+ipTMWa7OQC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 16, 2009 at 05:04:58PM -0700, Mark A. Greer wrote:
> From: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> 
> The rtc-omap driver currently assumes that the rtc's
> registers are at a fixed address and already mapped
> into virtual memory space.  Remove those assumptions
> so the same driver can be used for similar devices
> that reside at different physical addresses (e.g.,
> TI's DA8xx/OMAP-L13x SoC's).
> 
> Also allow the possibility for the timer and alarm
> interrupts to use the same IRQ.
> 
> Signed-off-by: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> CC: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> ---

Ping?

Just wondering if this patch was noticed.

FYI, the following were added by subsequent emails:

	Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
	Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
	Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Thanks,

Mark
--
