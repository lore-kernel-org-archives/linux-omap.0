From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] palmas usb driver
Date: Wed, 29 May 2013 11:36:01 +0530
Message-ID: <51A59AC9.9000908@ti.com>
References: <1369405896-30246-1-git-send-email-kishon@ti.com>
 <20130528173554.GD15794@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130528173554.GD15794-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
To: balbi-l0cyMroinI0@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tuesday 28 May 2013 11:05 PM, Felipe Balbi wrote:
> On Fri, May 24, 2013 at 08:01:33PM +0530, Kishon Vijay Abraham I wrote:
>> This patch series adds driver for palmas usb which is used to detect
>> attach/detach events of usb device and usb host.
>>
>> [PATCH v5 2/3] extcon: Palmas Extcon Driver which was sent previously
>> is added in this patch series itself. The revision history is added
>> in the patch comments section.
>>
>> A checkpatch warning "WARNING: static const char * array should
>> probably be static const char * const"is ignored since it introduces a
>> compilation warning.
>>
>> Graeme Gregory (2):
>>    drivers: regulator: palmas: add an API to set/clear the switch bit on
>>      SMPS10
>>    extcon: Palmas Extcon Driver
>>
>> Kishon Vijay Abraham I (1):
>>    usb: dwc3: use extcon fwrk to receive connect/disconnect notification
>
>
> There were some comments to this series, what will happen with it ? Any
> new versions coming ?

I've already sent new versions. Palmas Extcon Driver is already queued 
in extcon-next.
Chanwoo can take this patch in his tree after your ACK. [PATCH v2] usb: 
dwc3: use extcon fwrk to receive connect/disconnect notification.

Thanks
Kishon
