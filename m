From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH, RFC 2/8] ARM: twd: register clock event for 1 core SMP
Date: Tue, 19 Feb 2013 17:50:33 +0530
Message-ID: <51236E11.1030900@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <a7f62b8580aa4b33d5658f4f03371a453adaea9b.1361186097.git.afzal@ti.com>
 <51235076.8040200@ti.com> <20130219121400.GP23197@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130219121400.GP23197-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Syed Mohammed Khasim <khasim-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 February 2013 05:44 PM, Felipe Balbi wrote:
> On Tue, Feb 19, 2013 at 03:44:14PM +0530, Santosh Shilimkar wrote:
>> On Monday 18 February 2013 05:07 PM, Afzal Mohammed wrote:
>>> Register percpu local timer for scheduler tick in the case of one core
>>> SMP configuration. In other cases - secondary cpu's as well as boot
>>> cpu's having more than one core, this is being registered as per
>>> existing boot flow, with a difference that they happens after delay
>>> calibration. Registering the clock for tick in case of one core should
>>> be done before Kernel calibrates delay (this is required to boot,
>>> unless local timer is the only one registered for tick). Registering
>>> twd local timer at init_time (which platforms are doing now) helps
>>> achieve that with the proposed change.
>>>
>>> This helps in an almost booting Kernel (minimal) by only relying on
>>> ARM parts for an A9 one core SMP.
>>>
>>> Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
>>> ---
>> As mentioned in cover-letter, I don't think we have good
>> reasoning to make TWD to work with UP configuration. Even
>> you fix the timer code, there are more cascaded dependencies
>> which is not worth the effort.
>
> if CONFIG_SMP_ON_UP is enabled, smp_twd.c can still be compiled, right ?
>
Yep though just from deps pesrpective TWD is made available for ARM SMP
machines as below

config HAVE_ARM_TWD
         bool
         depends on SMP

Regards,
Santosh
