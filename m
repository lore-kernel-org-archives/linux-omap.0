From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/7] phy: ti-pipe3: cleanup ti_pipe3_probe()
Date: Wed, 5 Aug 2015 19:38:08 +0530
Message-ID: <55C218C8.1070906@ti.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com> <1438701646-7876-2-git-send-email-kishon@ti.com> <20150804160028.GG23659@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150804160028.GG23659-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: rogerq-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 04 August 2015 09:30 PM, Felipe Balbi wrote:
> On Tue, Aug 04, 2015 at 08:50:40PM +0530, Kishon Vijay Abraham I wrote:
>> No functional change. Add separate functions for pll,
>> clocks and syscon to make ti_pipe3_probe clean.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> 
> I think this needs to be splitted into smaller patches.

yeah sure.

Thanks
Kishon

> 
> Seems like the very first patch would be to introduce a local struct
> device pointer to be used. Than add each and every new function on their
> own patch. This will help big time making your refactoring a lot clearer
> and, should anything go wrong, we can atomically revert a specific
> change, instead of loosing the entire refactor.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
