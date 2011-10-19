From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
Date: Wed, 19 Oct 2011 18:22:58 +0530
Message-ID: <CAAL8m4wKu8w2iTBXmtekD09RaD200qFAG6jH=RgdmjJ2uuX8cA@mail.gmail.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
 <1318952141-10697-2-git-send-email-govindraj.raja@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 19, 2011 at 11:05 AM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Govindraj,
>
> On Tue, Oct 18, 2011 at 21:05:41, R, Govindraj wrote:
>> If OMAP UART is used as console uart and debug is enabled,
>> avoid gating of uart clocks to print all debug prints.
> :
> :
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_uart_id =3D uart=
->num;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmdline_find_option("d=
ebug")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_debug=
 =3D true;
>
> Shouldn't "loglevel" also be checked?
>

Might not be necessary,

loglevel only sets the option in console driver how a printk should be =
handled
from vprintk so any printk should be to sent to console or to syslogd a=
ction
where it will be buffered to a file(var/log/messages).

Any print's with any log level should be handled and printed to console=
=2E

consider below path below path

uart->ops
 -> runtime_get_sync
      -> omap_device_enable
          -> clock_enable

All the prints in given path are dev_dbgs for which we need debug to be=
 set from
command line argument.

As stated in change log any dev_dbg prints from these path can be
redirect to uart->ops
so even before our clock was enabled we got redirected back to uart cod=
e.

So for dev_dbg prints from above path we need debug to be set from comm=
and-line
and we can prevent uart clock gating to this scenario.

--
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
