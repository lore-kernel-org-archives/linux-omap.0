From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: OMAP: Update OMAP keypad driver
Date: Fri, 17 Feb 2006 07:12:07 -0800 (PST)
Message-ID: <20060217151207.48903.qmail@web32904.mail.mud.yahoo.com>
References: <1139821011.5208.11.camel@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1139821011.5208.11.camel@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Juha Yrj=F6l=E4 <juha.yrjola@nokia.com> wrote:

>=20
> I was the one who removed that, since it breaks keypad support on all
> OMAP24xx boards (except H4, I presume) that have Menelaus on them.=20
> And
> there are quite a few of those.
>=20
> Please submit a patch that moves the stuff above into board-h4.c.
>=20

I will submit that patch soon, having some problem in H4 setup right
now.

Before that can't we convert the code below in keypad to

253 down(&kp_enable_mutex);
254 	if (state !=3D kp_enable) {
255 	if (state)
256 		enable_irq(INT_KEYBOARD);
257 	else
258 		disable_irq(INT_KEYBOARD);
259 		kp_enable =3D state;
260 }
261 up(&kp_enable_mutex);

- Use mutex apis.
- and use platform driver data omap_kp->irq instead of INT_KEYBOARD.

Also as of now, I am not getting interrupt on H4 Menelaus keypad, looks
like due to trigger flags changes...or something else.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
