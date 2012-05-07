From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Mon, 7 May 2012 11:12:35 -0500
Message-ID: <4FA7F473.7060607@ti.com>
References: <cover.1335874494.git.afzal@ti.com> <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com> <4FA04A8C.4050703@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com> <4FA4041D.9010000@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E987159@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E987159-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org" <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Afzal,

On 05/07/2012 06:02 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Fri, May 04, 2012 at 22:00:21, Hunter, Jon wrote:
>>>>> +
>>>>> +	pdata->clk_prd = gpmc_get_fclk_period();
>>>>
>>>> Does this need to be done here? May be this should be done in the probe
>>>> function. You could store the handle to the main clk in the pdata.
>>>
>>> This is done so that migration of gpmc driver to the drivers folder
>>> would be smooth, remember that this function will still live here.
>>
>> Sure, but why call this here?
> 
> Clk_prd is a platform data passed to the driver, so platform code
> updates it, where else can it be done ?

The point is that you can pass what ever you like. You do not need to
pass the frequency you can pass the clock handle instead.

What happens it the clk_get() of the gpmc_l3_clk fails during the init?

In fact if you migrate to runtime pm then we should not have the clk_get
in the gpmc_init any more.

Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
