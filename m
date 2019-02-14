From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get
 EPC features
Date: Thu, 14 Feb 2019 10:36:35 +0530
Message-ID: <4cb9ce03-e360-b518-96fd-f8a618a9c803@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
 <20190107064148.10152-12-kishon@ti.com>
 <20190212150718.GA28306@e107981-ln.cambridge.arm.com>
 <6d72cfdf-97a7-4aab-f746-d0e545431ea2@ti.com>
 <20190213143646.GC25260@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190213143646.GC25260-4tUPXFaYRHv6sAKXYmQ0tx/iLCjYCKR+VpNB7YpNyf8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gustavo Pimentel <gustavo.pimentel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jia-Ju Bai <baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cyrille Pitchen <cyrille.pitchen-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Lorenzo,

On 13/02/19 8:06 PM, Lorenzo Pieralisi wrote:
> On Wed, Feb 13, 2019 at 07:08:18PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 12/02/19 8:37 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Jan 07, 2019 at 12:11:44PM +0530, Kishon Vijay Abraham I wrote:
>>>
>>> [...]
>>>
>>>>  static int pci_epf_test_bind(struct pci_epf *epf)
>>>>  {
>>>>  	int ret;
>>>>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>>>  	struct pci_epf_header *header = epf->header;
>>>> +	const struct pci_epc_features *epc_features;
>>>> +	enum pci_barno test_reg_bar = BAR_0;
>>>>  	struct pci_epc *epc = epf->epc;
>>>>  	struct device *dev = &epf->dev;
>>>> +	bool linkup_notifier = false;
>>>> +	bool msix_capable = false;
>>>> +	bool msi_capable = true;
>>>>  
>>>>  	if (WARN_ON_ONCE(!epc))
>>>>  		return -EINVAL;
>>>>  
>>>> -	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
>>>> -		epf_test->linkup_notifier = false;
>>>> -	else
>>>> -		epf_test->linkup_notifier = true;
>>>> -
>>>> -	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
>>>> +	epc_features = pci_epc_get_features(epc, epf->func_no);
>>>
>>> I think it would work out better if struct pci_epc_features was
>>> allocated in the caller (stack) and pci_epc_get_features() take a
>>> pointer parameter to it rather than the callee and the callee would just
>>> have to fill it out, this also removes data in the driver that is not
>>> really useful.
>>>
>>> Is there any other reason behind the current design choice ?
>>
>> Some drivers are used by multiple platforms each with different features. In
>> such cases it's cleaner to have separate epc_feature table for each platform.
>>
>> I think the driver should maintain some sort of data to even populate
>> pci_epc_features allocated by EP function driver.
> 
> You mean that every EP controller driver should keep a table of
> pci_epc_features (instead of a single instance) to be matched using DT
> compatible strings to detect the platform variations ?

Yes.

Thanks
Kishon
