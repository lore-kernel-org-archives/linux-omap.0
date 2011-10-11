From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 02/16] OMAP2+: hwmod: Add API to check IO PAD wakeup status
Date: Tue, 11 Oct 2011 11:47:02 +0530
Message-ID: <CAAL8m4wf42G6767untYqSE1pjtogDJmMKL4AZTyZ=77yFomBiw@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-2-git-send-email-govindraj.raja@ti.com> <4E8724D7.6060907@ti.com>
 <CAAL8m4zLz4kv+nNPKHD6zKG0pdXifXpmWiHnLAyn_bq228qHXA@mail.gmail.com>
 <4E8946BD.1010108@ti.com> <CAAL8m4xkC1Ftnr=RpAK5m2PVvPx3yzitO5gNJfOKiD0_YkGkdA@mail.gmail.com>
 <878vosh4ds.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <878vosh4ds.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 3:54 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Mon, Oct 3, 2011 at 10:53 AM, Rajendra Nayak <rnayak@ti.com> wrot=
e:
>>> On Monday 03 October 2011 10:30 AM, Govindraj wrote:
>>>
>>>> On Sat, Oct 1, 2011 at 8:03 PM, Rajendra Nayak<rnayak@ti.com> =A0w=
rote:
>>>>>
>>>>> On Friday 30 September 2011 04:31 PM, Govindraj.R wrote:
>>>>>>
>>>>>> Add API to determine IO-PAD wakeup event status for a given
>>>>>> hwmod dynamic_mux pad.
>>>>>>
>>>>>> Wake up event set will be cleared on pad mux_read.
>>>>>
>>>>> Are these api's even getting used in this series?
>>>>
>>>> Used in Tero's irq_chaining patches.
>>>
>>> So shouldn't this patch be part of his series instead?
>>
>> Yes it is. Part of his v9-series.
>>
>
> Then please drop from this series and state the introductory patch
> (PATCH 0/n) that this series has a dependency on Tero's series.
>

Okay.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
