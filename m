From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: Re: [PATCH 1/7] iommu/omap: Do bus_set_iommu() only if probe()
	succeeds
Date: Mon, 23 Dec 2013 22:07:04 +0100
Message-ID: <52B8A5F8.3000706@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
	<1387284818-28739-2-git-send-email-florian.vaussard@epfl.ch>
	<52B888C2.8040303@ti.com>
Reply-To: florian.vaussard-p8DiymsW2f8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52B888C2.8040303-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On 12/23/2013 08:02 PM, Anna, Suman wrote:
> Hi Florian,
> 
> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>> Currently, bus_set_iommu() is done in omap_iommu_init(). However,
>> omap_iommu_probe() can fail in a number of ways, leaving the platform
>> bus with a dangling reference to a non-initialized iommu. Perform
>> bus_set_iommu() only if omap_iommu_probe() succeed.
> 
> Can you clarify a bit more on what kind of issues you were seeing
> specifically? In general, there can be multiple instances of the iommu,
> so setting it in probe may not be fixing whatever issue you were seeing.
> The current OMAP3 code has only the ISP MMU enabled, but there is also
> another one for the IVA MMU (currently not configured by default).
> Moving the bus_set_iommu to probe makes sense if only one iommu is
> present, so this patch may not be needed at all.
> 

If omap_iommu_probe() fails, the init will have called bus_set_iommu()
anyways. Thus, when a driver request the iommu by calling
iommu_domain_alloc(), it will succeed (but iommu_attach_device() will
fail if I remember). Leaving a driver with a dangling reference to
a phantom iommu is not good IMHO. It will lead to strange behaviours
one day or another.

As for the multiple iommu case, as I do not think it is currently
possible, as bus_type (in this case &platform_bus_type) has only
one struct iommu_ops. bus_set_iommu() will return EBUSY on the
second call. Am I missing something?

> Also, the main change in this patch is moving the bus_set_iommu from
> omap_iommu_init to omap_iommu_probe, so you should probably leave out
> moving the function. The omap_iommu_probe function would anyway need
> conversion to using devm_ functions.
> 

This was my first try also, but as bus_set_iommu() needs omap_iommu_ops
(itself depending on several functions), its call must come after the
declaration of omap_iommu_ops. Thus I moved omap_iommu_probe() after
the declaration of omap_iommu_ops. But I can probably use a forward
declaration for omap_iommu_ops, this would be better.

Indeed, we can also convert to devm_.

Regards,

Florian
