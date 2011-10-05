From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 04/16] OMAP2+: UART: cleanup 8250 console driver support
Date: Wed, 05 Oct 2011 11:42:22 -0700
Message-ID: <87sjn78elt.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-4-git-send-email-govindraj.raja@ti.com>
	<87lit077ry.fsf@ti.com>
	<CAAL8m4yhbPQdz5od-cv4HirzTUT4qxUJv_c3Lpj9+efjqxm6hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4yhbPQdz5od-cv4HirzTUT4qxUJv_c3Lpj9+efjqxm6hg@mail.gmail.com>
	(Govindraj's message of "Wed, 5 Oct 2011 12:24:11 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> Hi Kevin,
>
> Thanks for the review,
>
>
> On Wed, Oct 5, 2011 at 3:12 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> We had been using traditional 8250 driver as uart console driver
>>> prior to omap-serial driver. Since we have omap-serial driver
>>> in mainline kernel for some time now it has been used as default
>>> uart console driver on omap2+ platforms. Remove 8250 support for
>>> omap-uarts.
>>
>> Nice to see the this disappearing.
>>
>>> Serial_in and serial_out override for 8250 serial driver is also
>>> removed.
>
>>> Empty fifo read fix is already taken care with omap-serial
>>> driver with data ready bit check from LSR reg before reading RX fif=
o.
>>
>> As stated in the previous review. =C2=A0Patches that move code/featu=
res
>> should have the removal and the add-back in the same patch. =C2=A0Do=
ing so
>> makes it easy for reviewers to see whether it was simply moved, or i=
f it
>> was modified when it was moved, etc.
>>
>
> Empty fifo read is already taken care in omap-serial.c and is part of
> mainline code.  Nothing to add to omap-serial.c

OK, good.  I guess I missed the 'already' part in your changelog.

>>> Also waiting for THRE(transmit hold reg empty) is done with wait_fo=
r_xmitr
>>> in omap-serial driver.
>>
>> Again, remove it here in the patch that adds that support (the errat=
a
>> patch I guess.)
>>
>
> The errata patch ( [PATCH v6 11/16] ) moves only mdr_errata and force=
_idle
> from serial.c to omap-serial.c.
>
> Already handled stuffs and things that already exists with omap-seria=
l.c
> are removed here.

OK.

>>> Remove headers that were necessary to support 8250 support
>>> and remove all config bindings done to keep 8250 backward compatibi=
lity
>>> while adding omap-serial driver. Remove omap_uart_reset needed for
>>> 8250 autoconf.
>>>
>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>
>> So basically, this patch should only remove the legacy 8250 support =
(as
>> the subject says) and everything else should be done in the other
>> relevant patches.
>>
>
> Yes removes only the 8250 code. serial_in/serial_out were read/write =
overrides
> part of 8250 code.
>
> serial_in/serial_out had these checks for empty fifo read and wait fo=
r tx
> which is already handled with omap-serial.c.

OK, thanks for the clarification. =20

The changelog could've been a bit more specific for readers not
intimately familiar with the driver.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
