From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 08/16] ARM: OMAP3: remove deprecated
	CONFIG_OMAP_IOMMU_IVA2
Date: Fri, 28 Feb 2014 14:42:06 -0600
Message-ID: <5310F49E.4040804@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
	<1392315347-32967-9-git-send-email-s-anna@ti.com>
	<alpine.DEB.2.02.1402281958170.453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1402281958170.453-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Paul,

On 02/28/2014 01:58 PM, Paul Walmsley wrote:
> On Thu, 13 Feb 2014, Suman Anna wrote:
>
>> From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>>
>> CONFIG_OMAP_IOMMU_IVA2 was defined originally to avoid conflicting
>> usage by tidspbridge and other iommu users. The same can be achieved
>> by marking the DT node disabled, so remove this obsolete flag and
>> the corresponding hwmod data can be enabled.
>>
>> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>> [s-anna-l0cyMroinI0@public.gmane.org: revise commit log]
>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
>
> Acked-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>
> Am assuming that someone else will be merging this as part of the entire
> series.
>

Thanks, I am expecting Tony to pick up all the arch/arm/mach-omap2/ 
patches. I am just about to send the v3 including all the acks received 
so far.

regards
Suman
