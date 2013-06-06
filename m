From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/4] ARM: dts: AM3XXX: Use preprocessor for device trees
Date: Thu, 6 Jun 2013 09:22:26 +0200
Message-ID: <51B038B2.4020007@ti.com>
References: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
 <51AF33BC.4020708@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EB16EED@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EB16EED-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/06/2013 07:28 AM, Mohammed, Afzal wrote:
> Hi Benoit,
> 
> On Wed, Jun 05, 2013 at 18:19:00, Cousson, Benoit wrote:
>> + Afzal,
>>
>> Hi Vaibhav and Afzal,
>>
>> Can someone test this series before I pull it. I still don't have any AM
>> board to do it myself :-(
> 
> Tested-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org> (am335x evm)

Thanks Afzal.


Florian,

I've just pushed the series including Azal tested-by.
I added as well the Makefile change you have done to add missing target
with a slight change in the subject:
ARM: dts: OMAP4/AM35xx: Add missing dtb in the dtbs target

Thanks,
Benoit
