From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] usb: dwc3: core: add dt support for dwc3 core
Date: Mon, 1 Oct 2012 10:40:12 +0530
Message-ID: <CAAe_U6Lt-+HQ5ZZ3xGsfhCqcOewWGprBCYc31qbZE_uUK7VtvA@mail.gmail.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
 <1348836795-4783-7-git-send-email-kishon@ti.com>
 <5068779A.20402@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5068779A.20402-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
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
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Sep 30, 2012 at 10:17 PM, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> wrote:
> Hello.
>
>
> On 28-09-2012 14:53, Kishon Vijay Abraham I wrote:
>
>> Added dwc3 support for dwc3 core and update the documentation with
>> device tree binding information.
>>
>> Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
>
> [...]
>
>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 08a5738..0c17a7a 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>
> [...]
>
>> @@ -602,11 +601,22 @@ static int __devexit dwc3_remove(struct
>> platform_device *pdev)
>>         return 0;
>>   }
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id of_dwc3_matach[] = {
>
>
>     I guess you meant 'of_dwc3_match' here and below?

indeed.. will re-post the patch..

Thanks
Kishon
