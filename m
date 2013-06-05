From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 1/9] drivers: phy: add generic PHY framework
Date: Wed, 5 Jun 2013 10:55:58 +0530
Message-ID: <51AECBE6.9090400@ti.com>
References: <1367229812-30574-1-git-send-email-kishon@ti.com>
 <1367229812-30574-2-git-send-email-kishon@ti.com>
 <51ADBF9B.5060403@samsung.com> <51ADDCD9.8080400@ti.com>
 <51ADEEF6.1030200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51ADEEF6.1030200-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 04 June 2013 07:13 PM, Sylwester Nawrocki wrote:
> Hi,
>
> On 06/04/2013 02:26 PM, Kishon Vijay Abraham I wrote:
>>>> +static inline int phy_init(struct phy *phy)
>>>> +{
>>>> +	pm_runtime_get_sync(&phy->dev);
>>>
>>> Hmm, no need to check return value here ? Also it looks a bit unexpecte=
d to
>>
>> I purposely dint check the return values in order to support platforms
>> that don=92t enable pm_runtime.
>
> Then I guess this should be called conditionally and any errors returned
> if runtime PM is enabled ? Not sure if pm_runtime_enabled() would be
> helpful such situation.
Indeed. I think it can be used.
>
>>> possibly have runtime_resume callback of a PHY device called before ops=
->init()
>>> call ? It seems a bit unclear what the purpose of init() callback is.
>>
>> Not really. Anything that is used to initialize the PHY (internal
>> configuration) can go in phy_init. Usually in runtime_resume callback,
>> optional functional clocks are enabled and also in some cases context
>> restore is done. So it really makes sense to enable clocks/module
>> (pm_runtime_get_sync) before doing a PHY configuration (phy_init).
>
> OK, that makes sense. All PHY device resources must be prepared anyway
> before a PHY object is registered with the PHY core.
>
>>>> +	if (phy->ops->init)
>>>> +		return phy->ops->init(phy);
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>> +static inline int phy_exit(struct phy *phy)
>>>> +{
>>>> +	int ret =3D -EINVAL;
>>>> +
>>>> +	if (phy->ops->exit)
>>>> +		ret =3D phy->ops->exit(phy);
>>>> +
>>>> +	pm_runtime_put_sync(&phy->dev);
>>>> +
>>>> +	return ret;
>>>> +}
>>>
>>> Do phy_init/phy_exit need to be mandatory ? What if there is really
>>
>> No. phy_init/phy_exit is not mandatory at all.
>>> nothing to do in those callbacks ? Perhaps -ENOIOCTLCMD should be
>>> returned if a callback is not implemented, so PHY users can recognize
>>> such situation and proceed ?
>>
>> So currently these APIs return -EINVAL if these callbacks are not
>> populated which is good enough IMHO.
>
> But -EINVAL could be well returned from the callback function. Perhaps
> ENOTSUPP could be used instead ?

hmm.. could be..

Thanks
Kishon
