From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH / RFC] Basic OMAP2430 High speed I2C & Speed handling
	(final)
Date: Tue, 17 Apr 2007 18:19:17 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47B66F12@dlee13.ent.ti.com>
References: <20070417231212.GK26287@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070417231212.GK26287@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>Well you could keep it only for omap1 in device.c.

OK, I will do the following, please correct me if I am wrong.

- I will keep the I2C data structure in plat-omap/device.c under a OMAP1 =
macro.

- Will remove I2C platform_data structure from mach-omap2/device.c

- Add a platform_data structure and i2c_set_clock() function (similar to =
n800-usb.c) in=20
	board-2430sdp.c
	board-h4.c
	board-n800.c
	board-apollon.c

- In I2C driver call the set_clock function to set the clock and speed.

Regards,
Khasim

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Tuesday, April 17, 2007 6:12 PM
>To: Syed Mohammed, Khasim
>Subject: Re: [PATCH / RFC] Basic OMAP2430 High speed I2C & Speed =
handling
>(final)
>
>* Syed Mohammed, Khasim <x0khasim@ti.com> [070417 23:09]:
>>
>> >If the clock and rate can be board specific, then you can board =
specific
>> >i2c_set_clock() function. There are some examples, see =
board-n800-usb.c
>> >for example.
>> >
>>
>> But what should happen to the definitions in device.c? If I remove =
them
>it might break other boards. I am more worried about omap1s.
>>
>> Should I still keep device.c one?
>
>Well you could keep it only for omap1 in device.c.
>
>Tony
