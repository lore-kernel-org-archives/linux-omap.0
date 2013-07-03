From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 0/8] Generic PHY Framework
Date: Wed, 3 Jul 2013 15:35:39 +0530
Message-ID: <51D3F773.9000209@ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Patel, Satish" <satish.patel-l0cyMroinI0@public.gmane.org>
Cc: "mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori,
 Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org" <cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org>, "Cherian,
 George" <george.cherian-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 03 July 2013 03:02 PM, Patel, Satish wrote:
> Hi Kishon,
>
>> -----Original Message-----
>> From: ABRAHAM, KISHON VIJAY
>> Sent: Wednesday, June 26, 2013 5:17 PM
>> To: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Balbi, Felipe; ABRAHAM,
>> KISHON VIJAY; arnd-r2nGTMty4D4@public.gmane.org; swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org;
>> sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-
>> usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; akpm@linux-
>> foundation.org
>> Cc: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org; rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org; linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org;
>> benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org;
>> davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org; Nayak, Rajendra; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Shilimkar,
>> Santosh; devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
>> doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Nori, Sekhar; Krishnamoorthy, Balaji T; Cherian,
>> George
>> Subject: [PATCH v9 0/8] Generic PHY Framework
>>
>> Added a generic PHY framework that provides a set of APIs for the PHY
>> drivers
>> to create/destroy a PHY and APIs for the PHY users to obtain a
>> reference to
>> the PHY with or without using phandle.
>>
>> This framework will be of use only to devices that uses external PHY
>> (PHY
>> functionality is not embedded within the controller).
>>
>> The intention of creating this framework is to bring the phy drivers
>> spread
>> all over the Linux kernel to drivers/phy to increase code re-use and
>> to
>> increase code maintainability.
>
> I would like to use this framework for a smart-card controller connected =
to a
> smart-card phy. I have some questions and would like to get feedback on t=
he same.

glad to know that :-)
>
> I am using =93TDA8026" Smartcard PHY from NXP. Here is the link for datas=
heet
> and app note for the same. The smart card controller is inside the TI SoC
> I am working with.
>
> Datasheet :
> www.nxp.com/documents/data_sheet/TDA8026.pdf?
>
> Appnote :
> http://www.nxp.com/documents/application_note/AN10724.pdf
>
> The TI SoC details are not public (yet). I can provide details to you off=
line.
>
> Brief about operation:
> -	The controller can work with and without a PHY
> -	When not using PHY, it is limited to talking to a single
> 	smart card. There is also a need to put external de-activation logic
> 	on card removal for this case.
> -	With a PHY you can use more than one smart card.
> -	Phy has 5 slots :  1 for smart card (credit/debit/other card with chip)
>        and others for SAM =96 SIM like modules
> - 	Once the PHY is initialized, there are some operations that the contro=
ller
> 	can request of the PHY like:
> 	- Card configurations  - set voltage
> 	- Activation of card
> 	- ATR =96 Answer to reset
> 	- Warm reset
> 	- ADPU exchange
> 	- Deactivation ( Normal/Emergency)

hmm.. We should think about extending the phy_ops to include these =

operations (something like phy_smart_card_ops so that other smart_card =

PHYs will also be able to use it).
> - 	In the mode when smartcard controller talks directly to the card witho=
ut the need
> 	for a PHY, all the above operations will be carried out by the controlle=
r itself
>
> My current thought process is to make the controller driver provide the u=
ser interface
> and talk to the PHY using the generic PHY framework you proposed. In the =
case where there
> is no PHY, my idea is to create a "dummy" PHY which uses the controller f=
unctionality itself.

right. And in the case where you actually have a PHY, create a PHY =

driver and implement the phy_smart_card_ops and register with the PHY =

framework.
>
> What I seem to be missing from the PHY framework is support for event det=
ection and generic
> read/write API which will enable the controller to talk to the PHY for th=
e operations listed
> above and also react to events from the PHY.

IMO the event detection should be handled in the PHY driver. And I dint =

feel the need for a read/write API as phy_xxxx_ops should be doing that =

precisely.

Thanks
Kishon
