From: PERIER Romain <romain.perier@gmail.com>
Subject: Re: [RFC PATCH v1 4/4] dt-bindings: Document the property
 poweroff-source for act8865 regulator
Date: Mon, 13 Oct 2014 15:54:20 +0200
Message-ID: <CABgxDoLkcHJzWa1c+UPNbdWxZrMJ+iQM-2gz=N22xgMBdAJrYA@mail.gmail.com>
References: <1412711104-15902-1-git-send-email-romain.perier@gmail.com>
	<1412711104-15902-4-git-send-email-romain.perier@gmail.com>
	<20141013131713.GB27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141013131713.GB27755@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "sameo@linux.intel.com" <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, robh <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Anton Vorontsov <anton@enomsg.org>, Laxman Dewangan <ldewangan@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Mark,

I did not update the whole serie yet, so, this is the old version... :)
(my patch about act8865 too, as "is_system_poweroff_source" should be
prefixed by "of_get" as requested by Grant)
I noted all your remarks.

Thanks

2014-10-13 15:17 GMT+02:00 Mark Brown <broonie@kernel.org>:
> On Tue, Oct 07, 2014 at 07:45:04PM +0000, Romain Perier wrote:
>> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/regulator/act8865-regulator.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> Should this documentation be put in some central place (and perhaps
> referenced from this binding) given that we're trying to make it a
> standard property?  Not sure where it'd fit though...
