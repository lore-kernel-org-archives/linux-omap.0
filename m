From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH, RFC 8/8] ARM: dts: am43-pre-silicon support
Date: Tue, 19 Feb 2013 16:30:13 +0530
Message-ID: <51235B3D.5000907@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <e344f74da47579c11db68d9f6efe25259ed7f25d.1361186097.git.afzal@ti.com>
 <5123556A.9050109@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EAA86DE@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EAA86DE-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori,
 Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Syed Mohammed, Khasim" <khasim-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 February 2013 04:22 PM, Mohammed, Afzal wrote:
> Hi Santosh,
>
> On Tue, Feb 19, 2013 at 16:05:22, Shilimkar, Santosh wrote:
>> On Monday 18 February 2013 05:08 PM, Afzal Mohammed wrote:
>
>>> AM43 SoC is in pre-silicon stage, meanwhile it has been modelled in
>>> a pre-silicon platform. To validate and boot Linux in pre-silicon
>>> platform that emulates an AM43 SoC, add DT build support.
>
>>> Note: This would be replaced by an original board support.
>
>>> -	am335x-bone.dtb
>>> +	am335x-bone.dtb \
>>> +	am43-pre-silicon.dtb
>
>> Well the pre-silicon platform and the SOC are very
>> close and at least the support you are adding here is
>> exactly same. So lets just use am437x.dtb or something
>> like that.
>
> SoC support is already added in patch 7/8. This is board (which doesn't
> exist now) support, hence a pre-silicon temporary one to validate it.
>
I mean we can call it am437x-xyxboard.dtb already considering the data
here can be re-used. Boot-args can be used from default kernel config
with CONFIG_CMDLINE_FORCE.

No strong opinion if you still insist to have a pre-silicon dtb.

Regards,
Santosh
