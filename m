From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 04/16] OMAP2+: UART: cleanup 8250 console driver support
Date: Thu, 6 Oct 2011 13:46:26 +0530
Message-ID: <CAAL8m4ytTGnc5zoARwFi8jBx6oiwQ1_dv+LqT8bPmnSbs+pe5A@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-4-git-send-email-govindraj.raja@ti.com> <87lit077ry.fsf@ti.com>
 <CAAL8m4yhbPQdz5od-cv4HirzTUT4qxUJv_c3Lpj9+efjqxm6hg@mail.gmail.com> <87sjn78elt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40182 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245Ab1JFIQs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 04:16:48 -0400
In-Reply-To: <87sjn78elt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu, Oct 6, 2011 at 12:12 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> Hi Kevin,
>>
>> Thanks for the review,
>>
>>
>> On Wed, Oct 5, 2011 at 3:12 AM, Kevin Hilman <khilman@ti.com> wrote:
>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>
>>>> We had been using traditional 8250 driver as uart console driver
>>>> prior to omap-serial driver. Since we have omap-serial driver
>>>> in mainline kernel for some time now it has been used as default
>>>> uart console driver on omap2+ platforms. Remove 8250 support for
>>>> omap-uarts.
>>>
>>> Nice to see the this disappearing.
>>>
>>>> Serial_in and serial_out override for 8250 serial driver is also
>>>> removed.
>>
>>>> Empty fifo read fix is already taken care with omap-serial
>>>> driver with data ready bit check from LSR reg before reading RX fi=
fo.
>>>
>>> As stated in the previous review. =A0Patches that move code/feature=
s
>>> should have the removal and the add-back in the same patch. =A0Doin=
g so
>>> makes it easy for reviewers to see whether it was simply moved, or =
if it
>>> was modified when it was moved, etc.
>>>
>>
>> Empty fifo read is already taken care in omap-serial.c and is part o=
f
>> mainline code. =A0Nothing to add to omap-serial.c
>
> OK, good. =A0I guess I missed the 'already' part in your changelog.
>
>>>> Also waiting for THRE(transmit hold reg empty) is done with wait_f=
or_xmitr
>>>> in omap-serial driver.
>>>
>>> Again, remove it here in the patch that adds that support (the erra=
ta
>>> patch I guess.)
>>>
>>
>> The errata patch ( [PATCH v6 11/16] ) moves only mdr_errata and forc=
e_idle
>> from serial.c to omap-serial.c.
>>
>> Already handled stuffs and things that already exists with omap-seri=
al.c
>> are removed here.
>
> OK.
>
>>>> Remove headers that were necessary to support 8250 support
>>>> and remove all config bindings done to keep 8250 backward compatib=
ility
>>>> while adding omap-serial driver. Remove omap_uart_reset needed for
>>>> 8250 autoconf.
>>>>
>>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>
>>> So basically, this patch should only remove the legacy 8250 support=
 (as
>>> the subject says) and everything else should be done in the other
>>> relevant patches.
>>>
>>
>> Yes removes only the 8250 code. serial_in/serial_out were read/write=
 overrides
>> part of 8250 code.
>>
>> serial_in/serial_out had these checks for empty fifo read and wait f=
or tx
>> which is already handled with omap-serial.c.
>
> OK, thanks for the clarification.
>
> The changelog could've been a bit more specific for readers not
> intimately familiar with the driver.
>

Okay fine, I will re-visit this.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
