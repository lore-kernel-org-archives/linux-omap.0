From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: Re: [PATCH 0/7] Fix omap-iommu probe and convert to DT for 3.14
Date: Mon, 23 Dec 2013 21:51:54 +0100
Message-ID: <52B8A26A.3000905@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
	<52B8866D.9060100@ti.com>
Reply-To: florian.vaussard-p8DiymsW2f8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52B8866D.9060100-l0cyMroinI0@public.gmane.org>
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

On 12/23/2013 07:52 PM, Anna, Suman wrote:
> Hi Florian,
>
> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>> OMAP2+ is heading towards a full device tree boot for 3.14. Currently,
>> the iommu used by the OMAP3 camera subsystem is not yet converted. It
>> cannot be probed as necessary data are only passed through device tree.
>>
>> Patches 1 and 2 are small fixes for problems encountered while developing
>> this series.
>>
>> Patches 3 to 5 add the device tree logic to omap-iommu, and complete
>> iommu
>> data in omap3.dtsi. Patches 6 and 7 remove unused iommu hwmod data and
>> platform code from OMAP2+.
>
> This is a good starting patch series for the OMAP iommu DT conversion,
> but it only handles OMAP3 ISP MMU. The OMAP3 ISP MMU is not the only MMU
> handled by the OMAP iommu driver. There is also an OMAP3 IVA MMU and
> MMUs associated with DSP and IPU in OMAP4/OMAP5. The conversion is
> simpler just with the OMAP3 ISP MMU, as it doesn't have any reset lines
> associated with it. But all the other MMUs would require
> asserting/deasserting the resets (performed currently through the pdata
> function pointers). Your patch series removes that functionality
> completely, and if this were to go into 3.14, this has to be handled
> through some pdata quirks until all the resets in hwmod data are
> converted to a reset driver.
>

Indeed, this patchset currently addresses only the OMAP ISP IOMMU.
For the OMAP3 IVA, the current implementation looks completely
different (inside drivers/staging/tidspbridge/). And to the best of
my knowledge, the current omap-iommu driver can handle only one
instance. By calling

bus_set_iommu(&platform_bus_type, &omap_iommu_ops);

the driver register the iommu on the platform bus (which is maybe
not the best choice). This call will fill the struct iommu_ops of
the bus_type, but if an iommu is already present, it will fail
and return EBUSY. Thus only one iommu can be set on the same bus.

But for the OMAP4 and OMAP5, I understand your concern. If a reset
is needed for these IPs, then a solution must be found. pdata-quirks
can be a temporary solution for 3.14. Otherwise a proper reset
controller should be devised from the current PRM module. Even if
I already looked at the reset core, I do not know the amount of work
necessary for this solution. And I do not have the hardware to
test the solution. But I can have a look after the XMAS break.

> I have provided some more comments directly in the respective patches.
>

And I will answer inline. Thank you very much!

Regards,

Florian
