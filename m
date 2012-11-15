From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ARM: OMAP3/4: iommu: adapt to runtime pm
Date: Thu, 15 Nov 2012 13:05:58 -0600
Message-ID: <CALLhW=6yKs8Moq6zAP06E6Nevhj8v5C-BGSgNyCsQbYXoJpLxQ@mail.gmail.com>
References: <1352860489-19960-1-git-send-email-omar.luna@linaro.org>
	<1352860489-19960-3-git-send-email-omar.luna@linaro.org>
	<CAK=WgbZm+sjavwb_Li_W5ygm0XuS9YMYfQEkdoB188Uir0arGg@mail.gmail.com>
	<CALLhW=46xUZzuEBaQD7vsOTQOGR7bwXMSM_mugN_gWa-oqwfuw@mail.gmail.com>
	<CAK=WgbaTupjayMLmgptfLtNkkk_GZL8RYQrYn8O7FG5GpANswg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAK=WgbaTupjayMLmgptfLtNkkk_GZL8RYQrYn8O7FG5GpANswg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 15 November 2012 11:39, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
>> I do agree description is missing, again I thought I had done this
>> somewhere but looks like I didn't, will update these. If you think
>> these should be different patches please let me know, otherwise I
>> would like to keep a single *documented* patch.
>
> It seems like there are 3 different logical changes here:
>
> 1. remove clk_* invocations from iommu_fault_handler()
> 2. keep clocks enabled as long as iommu is enabled
> 3. convert to runtime pm
>
> If we split this to three patches in this order, you won't have to add
> and remove runtime pm functions.
>
> Let's do it, please. It's a small nuisance now, but may be really
> helpful in the future when someone tries to debug stuff and understand
> the motivation behind these changes. It'd make it much easier for you
> to document the changes, too: you have an entire commit log per
> change.

Ok, not a problem then.

Cheers,

Omar
