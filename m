From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
Date: Wed, 19 Oct 2011 19:50:06 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930328693855@dbde02.ent.ti.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
 <1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
 <CAAL8m4wKu8w2iTBXmtekD09RaD200qFAG6jH=RgdmjJ2uuX8cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35775 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab1JSOUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Oct 2011 10:20:17 -0400
In-Reply-To: <CAAL8m4wKu8w2iTBXmtekD09RaD200qFAG6jH=RgdmjJ2uuX8cA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Govindraj,

On Wed, Oct 19, 2011 at 18:22:58, Govindraj wrote:
> On Wed, Oct 19, 2011 at 11:05 AM, Mohammed, Afzal <afzal@ti.com> wrot=
e:
> > Hi Govindraj,
> >
> > On Tue, Oct 18, 2011 at 21:05:41, R, Govindraj wrote:
> >> If OMAP UART is used as console uart and debug is enabled,
> >> avoid gating of uart clocks to print all debug prints.
> > :
> > :
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_uart_id =3D ua=
rt->num;
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmdline_find_option(=
"debug")) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_deb=
ug =3D true;
> >
> > Shouldn't "loglevel" also be checked?
> >
>=20
> Might not be necessary,
>=20
> loglevel only sets the option in console driver how a printk should b=
e handled
> from vprintk so any printk should be to sent to console or to syslogd=
 action
> where it will be buffered to a file(var/log/messages).
>=20
> Any print's with any log level should be handled and printed to conso=
le.
>=20
> consider below path below path
>=20
> uart->ops
>  -> runtime_get_sync
>       -> omap_device_enable
>           -> clock_enable
>=20
> All the prints in given path are dev_dbgs for which we need debug to =
be set from
> command line argument.
>=20
> As stated in change log any dev_dbg prints from these path can be
> redirect to uart->ops
> so even before our clock was enabled we got redirected back to uart c=
ode.
>=20
> So for dev_dbg prints from above path we need debug to be set from co=
mmand-line
> and we can prevent uart clock gating to this scenario.

Isn't passing bootargs "loglevel=3D10" same as "debug"? (init/main.c)

Regards
Afzal
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
