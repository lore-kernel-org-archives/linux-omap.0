From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dmaengine: cppi41: Fix list not empty warning on
 runtime suspend
Date: Mon, 9 Jan 2017 21:08:41 +0300
Message-ID: <0e98fc1a-a3c5-d663-70b6-4c687a56791f@cogentembedded.com>
References: <20170109170337.6957-1-abailon@baylibre.com>
 <20170109170337.6957-2-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109170337.6957-2-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello!

On 01/09/2017 08:03 PM, Alexandre Bailon wrote:

> Sometime, a transfer may not be queued due to a race between runtime pm
> and cppi41_dma_issue_pending().
> Sometime, cppi41_runtime_resume() may be interrupted right before to
> update device PM state to RESUMED.
> When it happens, if a new dma transfer is issued, because the device is not
> in active state, the descriptor will be added to the pendding list.

    Pending.

> But because the descriptors in the pendding list are only queued to cppi41

    Likewise.

> on runtime resume, the descriptor will not be queued.
> On runtime suspend, the list is not empty, which is causing a warning.
> Queue the descriptor if the device is active or resuming.
>
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
