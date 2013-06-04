From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v6 1/9] drivers: phy: add generic PHY framework
Date: Tue, 04 Jun 2013 15:43:18 +0200
Message-ID: <51ADEEF6.1030200@samsung.com>
References: <1367229812-30574-1-git-send-email-kishon@ti.com>
 <1367229812-30574-2-git-send-email-kishon@ti.com>
 <51ADBF9B.5060403@samsung.com> <51ADDCD9.8080400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <51ADDCD9.8080400@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: grant.likely@linaro.org, tony@atomide.com, balbi@ti.com, arnd@arndb.de, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, benoit.cousson@linaro.org, mchehab@redhat.com, akpm@linux-foundation.org, cesarb@cesarb.net, davem@davemloft.net, rnayak@ti.com, shawn.guo@linaro.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 06/04/2013 02:26 PM, Kishon Vijay Abraham I wrote:
>>> +static inline int phy_init(struct phy *phy)
>>> +{
>>> +	pm_runtime_get_sync(&phy->dev);
>>
>> Hmm, no need to check return value here ? Also it looks a bit unexpe=
cted to
>=20
> I purposely dint check the return values in order to support platform=
s=20
> that don=92t enable pm_runtime.

Then I guess this should be called conditionally and any errors returne=
d
if runtime PM is enabled ? Not sure if pm_runtime_enabled() would be
helpful such situation.

>> possibly have runtime_resume callback of a PHY device called before =
ops->init()
>> call ? It seems a bit unclear what the purpose of init() callback is=
=2E
>=20
> Not really. Anything that is used to initialize the PHY (internal=20
> configuration) can go in phy_init. Usually in runtime_resume callback=
,=20
> optional functional clocks are enabled and also in some cases context=
=20
> restore is done. So it really makes sense to enable clocks/module=20
> (pm_runtime_get_sync) before doing a PHY configuration (phy_init).

OK, that makes sense. All PHY device resources must be prepared anyway
before a PHY object is registered with the PHY core.

>>> +	if (phy->ops->init)
>>> +		return phy->ops->init(phy);
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static inline int phy_exit(struct phy *phy)
>>> +{
>>> +	int ret =3D -EINVAL;
>>> +
>>> +	if (phy->ops->exit)
>>> +		ret =3D phy->ops->exit(phy);
>>> +
>>> +	pm_runtime_put_sync(&phy->dev);
>>> +
>>> +	return ret;
>>> +}
>>
>> Do phy_init/phy_exit need to be mandatory ? What if there is really
>=20
> No. phy_init/phy_exit is not mandatory at all.
>> nothing to do in those callbacks ? Perhaps -ENOIOCTLCMD should be
>> returned if a callback is not implemented, so PHY users can recogniz=
e
>> such situation and proceed ?
>=20
> So currently these APIs return -EINVAL if these callbacks are not=20
> populated which is good enough IMHO.

But -EINVAL could be well returned from the callback function. Perhaps
ENOTSUPP could be used instead ?


Thanks,
Sylwester
