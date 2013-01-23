From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 0/6] USB: Add support for multiple PHYs of same type
Date: Wed, 23 Jan 2013 19:56:37 +0530
Message-ID: <50FFF31D.2070908@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
 <2D906ABA-71F2-4843-9DBE-F82527A1240A@dominion.thruhere.net>
 <50FEB3FD.3050001@ti.com> <50FEBB61.9000707@ti.com>
 <B9531499-0746-44DA-BDBB-999D4CA31E63@dominion.thruhere.net>
 <C8443D0743D26F4388EA172BF4E2A7A93EA922F5@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA922F5-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi,
 Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org" <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org List" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Afzal,

On Wednesday 23 January 2013 07:28 PM, Mohammed, Afzal wrote:
> Hi Koen,
>
> On Tue, Jan 22, 2013 at 22:32:56, Koen Kooi wrote:
>
>> Actually it uses nop-phy as a phy, which is missing from arch/arm/boot/dts/am33xx.dtsi, so mainline is already broken. But adding the nop-phy to the DT is easy enough to patch in locally.
>
> USB first instance of am335x works in mainline as of now.

Can you check if this series indeed breaks am335x?

Thanks for your help.

Regards
Kishon
