From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 01/39] ARM: OMAP2+: gpmc: driver conversion
Date: Tue, 8 May 2012 10:08:24 -0500
Message-ID: <4FA936E8.1080801@ti.com>
References: <cover.1335874494.git.afzal@ti.com> <363273a9ef82d6836197929157aa9a8eb8f5171a.1335874494.git.afzal@ti.com> <4FA4035E.6020308@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E987147@DBDE01.ent.ti.com> <4FA7F232.7050802@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9878EC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9878EC-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org" <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Hire
List-Id: linux-omap@vger.kernel.org

Hi  Afzal,

On 05/08/2012 01:18 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Mon, May 07, 2012 at 21:32:58, Hunter, Jon wrote:
> 
>>>>> +	/* no waitpin */
>>>>> +	case 0:
>>>>> +		break;
>>>>> +	default:
>>>>> +		dev_err(gpmc->dev, "multiple waitpins selected on CS:%u\n", cs);
>>>>> +		return -EINVAL;
>>>>> +		break;
>>>>> +	}
>>>>
>>>> Why not combined case 0 and default? Both are invalid configurations so
>>>> just report invalid selection.
>>>
>>> Case 0 is not invalid, a case where waitpin is not used, default refers
>>> to when a user selects multiple waitpins wrongly.
>>
>> Ok. Then for case 0, just return here. If the polarity is set, you could
>> print an error here.
> 
> Different ways of doing things, this looks cleaner to me as already it is
> checked, and time of execution in both cases would not differ much.

Sure. However, I think that this could be simplified so that it is
easier to read. At a minimum you may wish to add some comments to
explain the purposes of the multi-level if-statements as it is not
intuitive for the reader.

>>>>> +		if (gd->have_waitpin) {
>>>>> +			if (gd->waitpin != idx ||
>>>>> +					gd->waitpin_polarity != polarity) {
>>>>> +				dev_err(gpmc->dev, "error: conflict: waitpin %u with polarity %d on device %s.%d\n",
>>>>> +					gd->waitpin, gd->waitpin_polarity,
>>>>> +					gd->name, gd->id);
>>>>> +				return -EBUSY;
>>>>> +			}
>>>>> +		} else {
>>>>
>>>> Don't need the else as you are going to return in the above.
>>>
>>> Not always, only in case of error
>>
>> Ok, but seems that it can be simplified a little.
>>
>> What happens if a device uses more than one wait-pin? In other words a
>> device with two chip-selects that uses two wait-pins?
> 
> Please re-read http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg67702.html
> and your reply

Ok thats fine. Sorry for my repeated questions, but I think that this
just highlights that this code is not clear in it purpose. So again may
be some comments would make this all clearer.

Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
